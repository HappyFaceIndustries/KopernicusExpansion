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

using UnityEngine;

namespace KopernicusExpansion.Creatures.AI
{
	[RequireConfigType(ConfigType.Node)]
	public class AlignWithUpAxis : AIModule, IParserEventSubscriber
	{
		//constructor
		public AlignWithUpAxis ()
		{
		}

		//parser stuff
		[ParserTarget("rotateSpeed", optional = true)]
		public NumericParser<float> rotateSpeedParser
		{
			set
			{
				rotateSpeed = value.value;
			}
		}

		//apply/postApply
		public new void Apply(ConfigNode node)
		{

		}
		public new void PostApply(ConfigNode node)
		{

		}

		//actual behaviour
		private float rotateSpeed = 4f;

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



