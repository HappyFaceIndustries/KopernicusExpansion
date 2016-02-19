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
	public class AlignWithUpAxisLoader : AIModuleLoader<AlignWithUpAxis>, IParserEventSubscriber
	{
		//constructor
		public AlignWithUpAxisLoader ()
		{
		}

		private float rotateSpeed = 4f;

		[ParserTarget("rotateSpeed", optional = true)]
		public NumericParser<float> rotateSpeedParser
		{
			set
			{
				rotateSpeed = value.value;
			}
		}

		//creation
		protected override void OnCreateInstance (AlignWithUpAxis instance)
		{
			instance.rotateSpeed = rotateSpeed;
		}
	}
}

namespace KopernicusExpansion.Creatures.AI
{
	[AILoaderType(typeof(AlignWithUpAxisLoader))]
	public class AlignWithUpAxis : AIModule
	{
		//constructor
		public AlignWithUpAxis ()
		{
		}

		public float rotateSpeed = 4f;

		public override bool CanRunConcurrently ()
		{
			return true;
		}
		public override bool ShouldRun ()
		{
			return true;
		}
		public override void FixedUpdate ()
		{
			var upAxis = FlightGlobals.upAxis;
			var oldRot = creature.partTransform.rotation;
			creature.partTransform.up = upAxis;
			var newRot = creature.partTransform.rotation;
			creature.partTransform.rotation = Quaternion.Lerp (oldRot, newRot, Time.deltaTime * rotateSpeed);
		}
	}
}



