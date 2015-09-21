using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Creatures;

using UnityEngine;

namespace KopernicusExpansion.Creatures.AI
{
	[RequireConfigType(ConfigType.Node)]
	public abstract class AIModule : IParserEventSubscriber
	{
		[ParserTarget("priority", optional = true)]
		public NumericParser<int> priorityLoader
		{
			set
			{
				priority = value.value;
			}
		}
		[ParserTarget("enabled", optional = true)]
		public NumericParser<bool> enabledParser
		{
			set
			{
				enabled = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{

		}

		//non-parser stuff
		public int priority = 0;
		public bool enabled = true;

		public CreaturePart creature;

		public abstract bool CanRunConcurrently ();
		public abstract bool ShouldRun ();
		public virtual void Start () {}
		public virtual void OnDestroy () {}
		public virtual void Update () {}
		public virtual void FixedUpdate () {}
	}
}

