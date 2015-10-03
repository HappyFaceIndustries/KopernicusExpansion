using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;
using UnityEngine;

using Kopernicus;

namespace KopernicusExpansion
{
	[KSPAddon(KSPAddon.Startup.Instantly, false)]
	public class KopernicusExpansionLoaderSystemAdder : MonoBehaviour
	{
		private static List<Type> LoaderSystemTypes = new List<Type>();

		private GameObject _loaderObj;
		private GameObject LoaderObject
		{
			get
			{
				if (_loaderObj == null)
					_loaderObj = new GameObject ("KopernicusExpansionLoaderObject");
				return _loaderObj;
			}
		}

		private void Awake()
		{
			foreach (var type in Assembly.GetExecutingAssembly().GetTypes())
			{
				KopernicusExpansionLoader kopELoaderAttr = null;

				foreach (var attr in Attribute.GetCustomAttributes(type))
				{
					if (attr is KopernicusExpansionLoader)
						kopELoaderAttr = (KopernicusExpansionLoader)attr;
				}

				if (kopELoaderAttr != null)
				{
					LoaderSystemTypes.Add (type);
					Utils.Log ("Found LoadingSystem type " + type.Name);
				}
			}

			LoadingScreen screen = UnityEngine.Object.FindObjectOfType<LoadingScreen> ();

			if (screen == null)
			{
				Utils.LogError ("LoadingScreen is null, abort!");
				return;
			}

			foreach (var type in LoaderSystemTypes)
			{
				//skip if this type is a dupe
				foreach (var loader in screen.loaders)
				{
					if (type == loader.GetType ())
						continue;
				}

				//skip if  this type is not a LoadingSystem
				if (type.BaseType != typeof(LoadingSystem))
					continue;

				try
				{
					LoadingSystem newLoader = (LoadingSystem)LoaderObject.AddComponent (type);
					screen.loaders.Add (newLoader);
					Utils.Log ("Added LoadingSystem type " + type.Name);
				}
				catch(Exception e)
				{
					Utils.LogError ("error encountered while attempting to add LoadingSystem type " + type.Name);
					Debug.LogException (e);
				}
			}
		}
	}

	[AttributeUsage(AttributeTargets.Class)]
	public class KopernicusExpansionLoader : Attribute
	{
	}
}

