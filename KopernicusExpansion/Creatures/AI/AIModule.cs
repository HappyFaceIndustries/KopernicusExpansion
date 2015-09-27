using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Creatures;

using UnityEngine;

namespace KopernicusExpansion.Creatures.AI.Configuration
{
	[RequireConfigType(ConfigType.Node)]
	public class AIModuleLoaderGeneric
	{
		public bool enabled = true;
		public int priority = 0;

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

		public virtual void Apply(ConfigNode node)
		{
		}
		public virtual void PostApply(ConfigNode node)
		{
		}

		//creation
		public AIModule CreateInstance(CreaturePart part)
		{
			Debug.Log ("0");
			AIModule instance = new AIModule ();
			instance.creature = part;
			instance.enabled = enabled;
			instance.priority = priority;

			return instance;
		}
	}

	[RequireConfigType(ConfigType.Node)]
	public abstract class AIModuleLoader<T> : AIModuleLoaderGeneric where T : AIModule
	{
		//creation
		public new T CreateInstance(CreaturePart part)
		{
			Debug.Log ("1");
			T instance = Activator.CreateInstance<T> ();
			instance.creature = part;
			instance.enabled = enabled;
			instance.priority = priority;

			OnCreateInstance (instance);

			return instance;
		}
		protected virtual void OnCreateInstance(T instance) {}
	}

	[AttributeUsage(AttributeTargets.Class)]
	public class AILoaderType : Attribute
	{
		public Type loaderType;

		public AILoaderType(Type loaderType)
		{
			this.loaderType = loaderType;
		}
	}
}

namespace KopernicusExpansion.Creatures.AI
{
	public class AIModule
	{
		public int priority = 0;
		public bool enabled = true;

		public CreaturePart creature;

		public virtual bool CanRunConcurrently () {return true;}
		public virtual bool ShouldRun () {return false;}
		public virtual void Start () {}
		public virtual void OnDestroy () {}
		public virtual void Update () {}
		public virtual void FixedUpdate () {}
	}
}

