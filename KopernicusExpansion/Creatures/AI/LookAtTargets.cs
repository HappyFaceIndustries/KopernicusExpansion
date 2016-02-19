using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Creatures.AI;
using KopernicusExpansion.Creatures.AI.Configuration;

using UnityEngine;

namespace KopernicusExpansion.Creatures.AI.Configuration
{
	[RequireConfigType(ConfigType.Node)]
	public class LookAtTargetsLoader : AIModuleLoader<LookAtTargets>, IParserEventSubscriber
	{
		//constructor
		public LookAtTargetsLoader()
		{
		}

		private float eyeSpeed = 6f;
		private float maxDistance = 250000f;
		private float maxTargetChangeInterval = 10f;
		private float minTargetChangeInterval = 1f;

		[ParserTarget("eyeTransformName", optional = true)]
		public string eyeTransformName = "Eyeball";

		[ParserTarget("eyeSpeed", optional = true)]
		public NumericParser<float> eyeSpeedParser
		{
			set
			{
				eyeSpeed = value.value;
			}
		}
		[ParserTarget("maxDistance", optional = true)]
		public NumericParser<float> maxDistanceParser
		{
			set
			{
				maxDistance = value.value * value.value;
			}
		}
		[ParserTarget("maxTargetChangeInterval", optional = true)]
		public NumericParser<float> maxIntervalParser
		{
			set
			{
				maxTargetChangeInterval = value.value;
			}
		}
		[ParserTarget("minTargetChangeInterval", optional = true)]
		public NumericParser<float> minIntervalParser
		{
			set
			{
				minTargetChangeInterval = value.value;
			}
		}

		//creation
		protected override void OnCreateInstance (LookAtTargets instance)
		{
			instance.eyeTransformName = eyeTransformName;
			instance.eyeSpeed = eyeSpeed;
			instance.maxDistance = maxDistance;
			instance.maxTargetChangeInterval = maxTargetChangeInterval;
			instance.minTargetChangeInterval = minTargetChangeInterval;
		}
	}
}

namespace KopernicusExpansion.Creatures.AI
{
	[AILoaderType(typeof(LookAtTargetsLoader))]
	public class LookAtTargets : AIModule
	{
		//constructor
		public LookAtTargets()
		{
		}

		public Transform currentTarget
		{
			get
			{
				if (eyeLook != null)
					return eyeLook.target;
				else
					return null;
			}
			set
			{
				if (eyeLook != null)
					eyeLook.target = value;
			}
		}
		private EyeLook eyeLook;

		public string eyeTransformName = "";
		public float eyeSpeed = 6f;
		public float maxDistance = 250000f;
		public float maxTargetChangeInterval = 10f;
		public float minTargetChangeInterval = 1f;

		public override bool CanRunConcurrently ()
		{
			return true;
		}
		public override bool ShouldRun ()
		{
			return true;
		}

		public override void Start ()
		{
			var transform = creature.FindModelTransform (eyeTransformName);
			if (transform != null)
			{
				eyeLook = transform.gameObject.AddComponent<EyeLook> ();
				eyeLook.speed = eyeSpeed;
			}

			GameEvents.onPartExplode.Add (OnExplosion);

			creature.StartCoroutine (LookAtThings());
		}
		public override void OnDestroy ()
		{
			GameEvents.onPartExplode.Remove (OnExplosion);
		}

		private IEnumerator<YieldInstruction> LookAtThings()
		{
			while (true)
			{
				currentTarget = GetNewTarget ();
				yield return new WaitForSeconds (UnityEngine.Random.Range (minTargetChangeInterval, maxTargetChangeInterval));
			}
		}
		private Transform GetNewTarget()
		{
			Transform target = creature.partTransform;

			var activeVessel = FlightGlobals.ActiveVessel;
			var vessels = (FlightGlobals.Vessels.Count > 0) ? (FlightGlobals.Vessels.Where(v => !v.packed && v != activeVessel && (v.ReferenceTransform.position - creature.partTransform.position).sqrMagnitude < maxDistance).ToArray()) : null;
			var vessel = (vessels != null && vessels.Length > 0) ? vessels [UnityEngine.Random.Range (0, vessels.Length)] : null;

			bool willBeActive = UnityEngine.Random.Range (0f, 1f) < 0.33f;
			bool isActiveCloseEnough = (activeVessel.ReferenceTransform.position - creature.partTransform.position).sqrMagnitude < maxDistance;

			if (vessel == null || (currentTarget != activeVessel.ReferenceTransform && willBeActive && isActiveCloseEnough))
				target = activeVessel.ReferenceTransform;
			else
				target = vessel.ReferenceTransform;

			return target;
		}

		private void OnExplosion(GameEvents.ExplosionReaction explosion)
		{
			//look at something new when there's an explosion
			if((explosion.distance * explosion.distance) < maxDistance)
				currentTarget = GetNewTarget ();
		}

		public override void Update ()
		{
			if (currentTarget == null)
				currentTarget = GetNewTarget ();
		}
	}

	public class EyeLook : MonoBehaviour
	{
		public Transform target;
		public float speed = 5f;

		void LateUpdate()
		{
			if (target != null)
			{
				var oldRot = transform.rotation;
				var lookForward = -(transform.position - target.position).normalized;
				var lookRot = Quaternion.LookRotation (lookForward);
				transform.rotation = Quaternion.Lerp (oldRot, lookRot, Time.deltaTime * speed);
			}
		}
	}
}

