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
			//activate the part
			base.force_activate ();

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
		}

		// >:D
		protected override void onPartExplode ()
		{
			//TODO: add blood effects
		}
	}
}

