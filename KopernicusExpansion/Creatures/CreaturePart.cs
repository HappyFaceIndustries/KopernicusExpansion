using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Creatures.AI;
using KopernicusExpansion.Creatures.AI.Configuration;

using UnityEngine;

namespace KopernicusExpansion.Creatures
{
	public class CreaturePart : Part
	{
		public Creature creature;
		public List<AIModule> AI;

		//AI functions
		private bool nonConcurrentHasRun = false;
		public bool IsNonConcurrentRunning()
		{
			return nonConcurrentHasRun;
		}

		//overridden functions
		protected override void onFlightStart ()
		{
			//get the creature
			if (partInfo.partConfig.HasValue ("creature"))
			{
				var creatureName = partInfo.partConfig.GetValue ("creature");
				foreach (var c in CreatureLoader.LoadedCreatures)
				{
					if (c.name == creatureName)
						creature = c;
				}
			}

			//destroy us if we don't have a creature
			if (creature == null)
			{
				Utils.LogError ("CreaturePart " + partName + " did not have a valid creature");
			}

			//cache actual maxTemp and skinMaxTemp values
			this.maxTemp = base.maxTemp;
			this.skinMaxTemp = base.maxTemp;

			//activate the part
			base.force_activate ();

			//deactivate the highlighting
			highlightType = Part.HighlightType.Disabled;
			SetHighlightType(Part.HighlightType.Disabled);

			AI = new List<AIModule> ();
			foreach (var ai in creature.AIModules)
			{
				try
				{
					Type type = ai.GetType();
					var createInstanceMethod = type.GetMethod("CreateInstance", BindingFlags.Instance | BindingFlags.Public);
					AI.Add ((AIModule)createInstanceMethod.Invoke(ai, new object[]{this}));
				}
				catch(Exception e)
				{
					Debug.LogException (e);
				}
			}

			foreach (var ai in AI)
			{
				try
				{
					ai.Start ();
				}
				catch(Exception e)
				{
					Debug.LogException (e);
				}
			}
		}
		protected override void onPartDestroy ()
		{
			if (AI == null)
				return;

			foreach (var ai in AI)
			{
				try
				{
					ai.OnDestroy ();
				}
				catch(Exception e)
				{
					Debug.LogException (e);
				}
			}
		}
		protected override void onPartUpdate ()
		{
			if (AI == null)
				return;
			if (this.packed || !vessel.loaded)
				return;

			nonConcurrentHasRun = false;
			foreach (var ai in AI)
			{
				bool shouldRun = ai.ShouldRun ();
				bool canRunConcurrently = ai.CanRunConcurrently ();

				if (shouldRun && !canRunConcurrently && !nonConcurrentHasRun)
				{
					nonConcurrentHasRun = true;
					try
					{
						ai.Update ();
					}
					catch (Exception e)
					{
						Debug.LogException (e);
					}
				}
				else if(shouldRun && canRunConcurrently)
				{
					try
					{
						ai.Update ();
					}
					catch (Exception e)
					{
						Debug.LogException (e);
					}
				}
			}
		}
		protected override void onPartFixedUpdate ()
		{
			if (AI == null)
				return;
			if (this.packed || !vessel.loaded)
				return;

			nonConcurrentHasRun = false;
			foreach (var ai in AI)
			{
				bool shouldRun = ai.ShouldRun ();
				bool canRunConcurrently = ai.CanRunConcurrently ();

				if (shouldRun && !canRunConcurrently && !nonConcurrentHasRun)
				{
					nonConcurrentHasRun = true;
					try
					{
						ai.FixedUpdate ();
					}
					catch (Exception e)
					{
						Debug.LogException (e);
					}
				}
				else if(shouldRun && canRunConcurrently)
				{
					try
					{
						ai.FixedUpdate ();
					}
					catch (Exception e)
					{
						Debug.LogException (e);
					}
				}
			}

			//heat simulation
			base.maxTemp = double.MaxValue;
			base.skinMaxTemp = double.MaxValue;
			UpdateHeatValues ();
		}

		public new double maxTemp;
		public new double skinMaxTemp;

		public void UpdateHeatValues()
		{
			if (base.temperature > this.maxTemp || base.skinTemperature > this.skinMaxTemp)
			{
				GameEvents.onOverheat.Fire (new EventReport (FlightEvents.OVERHEAT, this, partInfo.title, "", 0, "", 0f));
				if (creature.Gore.enabled)
					explode ();
				else
					base.explode ();
			}
		}

		//TODO: optimize the collisions for having multiple colliders

		public new void OnCollisionEnter(Collision c)
		{
			if (!HighLogic.LoadedSceneIsFlight)
				return;
			if (state == PartStates.DEAD)
				return;
				
			CheckCollision (c);
		}
		public new bool CheckCollision(Collision c)
		{
			foreach (var contact in c.contacts)
			{
				if (collider != contact.thisCollider && collider != contact.otherCollider)
				{
					continue;
				}
				HandleCollision (c);
				return true;
			}
			foreach (var child in children)
			{
				if (child.physicalSignificance != PhysicalSignificance.FULL)
				{
					if (child.State != PartStates.DEAD && child.isAttached)
					{
						return child.CheckCollision (c);
					}
				}
			}
			return false;
		}
		public new void HandleCollision(Collision c)
		{
			if (!c.collider.enabled)
				return;

			if (c.collider.gameObject.activeInHierarchy && !c.collider.isTrigger)
			{
				if (c.collider.attachedRigidbody != null)
				{
					if (c.relativeVelocity.magnitude * c.collider.attachedRigidbody.mass <= crashTolerance)
						return;
				}
				else if (c.relativeVelocity.magnitude <= crashTolerance)
					return;

				if (CheatOptions.NoCrashDamage) //cheater
					return;

				if (creature.Gore.enabled)
					explode ();
				else
					base.explode ();

				if (c.gameObject.GetComponent<PQ> () != null)
				{
					GameEvents.onCrash.Fire (new EventReport (FlightEvents.CRASH, this, this.partInfo.title, c.collider.name, 0, "", c.relativeVelocity.magnitude));
				}
				else
				{
					if (Part.GetComponentUpwards<Part> (c.gameObject) != null)
					{
						GameEvents.onCollision.Fire (new EventReport (FlightEvents.COLLISION, this, this.partInfo.title, Part.GetComponentUpwards<Part> (c.gameObject).partInfo.title, 0, "", c.relativeVelocity.magnitude));
					}
					else
					{
						if (Part.GetComponentUpwards<CrashObjectName> (c.gameObject) != null)
							GameEvents.onCollision.Fire (new EventReport (FlightEvents.COLLISION, this, this.partInfo.title, Part.GetComponentUpwards<CrashObjectName> (c.gameObject).objectName, 0, "", c.relativeVelocity.magnitude));
						else
							GameEvents.onCollision.Fire (new EventReport (FlightEvents.CRASH, this, this.partInfo.title, c.gameObject.name, 0, "", c.relativeVelocity.magnitude));
					}
				}
				return;
			}
		}
		public new void explode()
		{
			if (state == PartStates.DEAD)
				return;

			CreatureFXMonger.CreateCreatureExplosion (this);
			Debug.Log ("Creature explosion of " + name);

			float distance = 0f;
			if (vessel == FlightGlobals.ActiveVessel)
				distance = 0f;
			else
				distance = Vector3.Distance (partTransform.position, FlightGlobals.ActiveVessel.vesselTransform.position);
			GameEvents.onPartExplode.Fire (new GameEvents.ExplosionReaction (distance, 0f));

			Die ();
		}
	}
}

