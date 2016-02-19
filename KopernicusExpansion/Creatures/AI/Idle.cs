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
	public class IdleLoader : AIModuleLoader<Idle>, IParserEventSubscriber
	{
		//constructor
		public IdleLoader ()
		{
		}

		[ParserTarget("animationName", optional = false)]
		public string idleAnimationName = "";

		//creation
		protected override void OnCreateInstance (Idle instance)
		{
			instance.idleAnimationName = idleAnimationName;
		}
	}
}

namespace KopernicusExpansion.Creatures.AI
{
	[AILoaderType(typeof(IdleLoader))]
	public class Idle : AIModule
	{
		//constructor
		public Idle ()
		{
		}

		public string idleAnimationName = "";

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

