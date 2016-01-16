using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using UnityEngine;

namespace KopernicusExpansion.Editors
{
	[AttributeUsage(AttributeTargets.Class)]
	public class IngameEditor : Attribute
	{
		public Type editorType;
		public string editorName;
		public GameScenes[] scenes;

		public IngameEditor(Type editorClass, string editorName, params GameScenes[] gameScenes)
		{
			this.editorType = editorClass;
			this.editorName = editorName;
			this.scenes = gameScenes;
		}
	}
}

namespace KopernicusExpansion.Editors
{
	[KSPAddon(KSPAddon.Startup.MainMenu, true)]
	public class IngameEditorSpawner : MonoBehaviour
	{
		private static Dictionary<Type, GameScenes[]> editorTypes = new Dictionary<Type, GameScenes[]> ();

		void Start()
		{
			DontDestroyOnLoad (this);
			LoadEditorTypes ();
			GameEvents.onLevelWasLoadedGUIReady.Add (OnLevelLoaded);
		}
		void LoadEditorTypes()
		{
			if (Settings.AllowEditors)
			{
				Utils.Log ("Finding editor types...");

				foreach (var assembly in AssemblyLoader.loadedAssemblies.Select(a => a.assembly))
				{
					foreach (var type in assembly.GetTypes())
					{
						var attributes = Attribute.GetCustomAttributes (type);
						foreach (var attr in attributes)
						{
							if (attr is IngameEditor)
							{
								var editor = (IngameEditor)attr;
								editorTypes.Add (editor.editorType, editor.scenes);
								Utils.Log ("IngameEditor found: " + editor.editorType.Name + " for " + type.Name);
							}
						}
					}
				}
			}
		}

		private void OnLevelLoaded (GameScenes scene)
		{
			if (Settings.AllowEditors)
			{
				foreach (var editor in editorTypes.Where(e => e.Value.Contains(scene)))
				{
					try
					{
						GameObject obj = new GameObject (editor.Key.Name);
						obj.AddComponent (editor.Key);
						obj.SetActive (true);
						Utils.Log ("IngameEditor " + editor.Key.Name + " created");
					}
					catch(Exception e)
					{
						Utils.LogError ("Failed to load editor: " + editor.Key.Name);
						Debug.LogException (e);
					}
				}
			}
		}
	}
}

