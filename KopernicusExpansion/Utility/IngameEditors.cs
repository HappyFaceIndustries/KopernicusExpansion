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
	public class IngameEditorAttribute : Attribute
	{
		public string editorName;

		public IngameEditorAttribute(string editorName)
		{
			this.editorName = editorName;
		}
	}

	public class IngameEditor : MonoBehaviour
	{
		public bool IsWindowOpen = false;
	}

	public static class IngameEditorUtils
	{
		private static Dictionary<string, Type> editorTypes = new Dictionary<string, Type> ();

		public static List<IngameEditor> GetEditors()
		{
			//find editor types
			foreach (var assembly in AssemblyLoader.loadedAssemblies.Select(a => a.assembly))
			{
				foreach (var type in assembly.GetTypes())
				{
					if(type.BaseType == typeof(IngameEditor))
					{
						var attributes = Attribute.GetCustomAttributes (type);
						foreach (var attr in attributes)
						{
							if (attr is IngameEditorAttribute)
							{
								var editor = (IngameEditorAttribute)attr;
								editorTypes.Add (editor.editorName, type);
								Utils.Log ("IngameEditor found: " + type.Name);
							}
						}
					}
				}
			}

			List<IngameEditor> editors = new List<IngameEditor> ();

			//spawn editors
			foreach (var editor in editorTypes)
			{
				try
				{
					GameObject obj = new GameObject (editor.Key);
					var editorComp = (IngameEditor)obj.AddComponent (editor.Value);
					editors.Add (editorComp);
					obj.SetActive (true);
					Utils.Log ("IngameEditor " + editor.Key + " created");
				}
				catch(Exception e)
				{
					Utils.LogError ("Failed to load editor: " + editor.Key);
					Debug.LogException (e);
				}
			}

			return editors;
		}
	}
}

