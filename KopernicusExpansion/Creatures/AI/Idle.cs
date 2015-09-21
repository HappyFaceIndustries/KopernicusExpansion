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
	public class Idle : AIModule, IParserEventSubscriber
	{
		//constructor
		public Idle ()
		{
		}

		//parser stuff
		[ParserTarget("animationName", optional = false)]
		public string idleAnimationName = null;

		//apply/postApply
		public new void Apply(ConfigNode node)
		{

		}
		public new void PostApply(ConfigNode node)
		{

		}

		//actual behaviour
		private Animation animator;

		public override bool CanRunConcurrently ()
		{
			return false;
		}
		public override bool ShouldRun ()
		{
			return true;
		}
		public override void Start ()
		{
			var animators = creature.FindModelAnimators ();
			if(animators != null && animators.Length > 0)
				animator = animators.First (a => a [idleAnimationName] != null);
		}
		public override void Update ()
		{
			if (animator == null || idleAnimationName == null || animator[idleAnimationName] == null)
				return;

			animator.CrossFade (idleAnimationName, 0.2f);
		}
	}
}

