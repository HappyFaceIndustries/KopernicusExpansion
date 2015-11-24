using System;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;
using UnityEngine;
using Kopernicus;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Configuration;

namespace KopernicusExpansion.Utility
{
	[KSPAddon(KSPAddon.Startup.MainMenu, true)]
	public class KopernicusExpansionRuntimeUtility : MonoBehaviour
	{
		static bool buttonAdded = false;

		void Start()
		{
			//don't startup when editors are off
			if (!Settings.AllowEditors)
			{
				DestroyImmediate (this);
				return;
			}

			DontDestroyOnLoad (this);

			foreach (var body in PSystemManager.Instance.localBodies)
			{
				if (body.pqsController != null)
					pqsPlanets.Add (body);
			}

			if (!buttonAdded)
			{
				ApplicationLauncher.Instance.AddModApplication (delegate {
					showWindow = true;
				}, delegate {
					showWindow = false;
				}, null, null, null, null, ApplicationLauncher.AppScenes.FLIGHT | ApplicationLauncher.AppScenes.MAPVIEW | ApplicationLauncher.AppScenes.TRACKSTATION | ApplicationLauncher.AppScenes.SPACECENTER, AssetBase.GetTexture ("scienceicon"));
				buttonAdded = true;
			}
		}

		List<CelestialBody> pqsPlanets = new List<CelestialBody>();
		int[] possibleResolutions = new int[]{512, 1024, 2048};

		GUISkin skin = HighLogic.Skin;

		bool showWindow = false;
		Rect exportRect = new Rect(200f, 200f, 200f, 140f);
		void OnGUI()
		{
			GUI.skin = skin;
			if (showWindow)
				exportRect = GUILayout.Window ("KopernicusExpansion_RuntimeUtility".GetHashCode (), exportRect, ExportWindow, "PQS Maps");
			if (showTextureWindow)
			{
				texWindowRect = GUILayout.Window ("KopernicusExpansion_TextureViewer".GetHashCode (), texWindowRect, TextureWindow, "Texture Viewer");
				if (texture != null)
					GUI.DrawTexture (new Rect (10f, 10f, 512f, 512f), texture);
			}
		}

		int pqsIndex = 0;
		int resIndex = 1;
		void ExportWindow(int id)
		{
			GUILayout.BeginHorizontal (GUILayout.ExpandWidth(true));
			if (GUILayout.Button ("<", GUILayout.Width (30f), GUILayout.Height(30f)))
			{
				pqsIndex--;

				if (pqsIndex < 0)
					pqsIndex = pqsPlanets.Count - 1;
				if (pqsIndex >= pqsPlanets.Count)
					pqsIndex = 0;
			}

			GUILayout.Label (pqsPlanets[pqsIndex].theName, GUI.skin.box, GUILayout.ExpandWidth(true), GUILayout.Height(30f));

			if (GUILayout.Button (">", GUILayout.Width (30f), GUILayout.Height(30f)))
			{
				pqsIndex++;

				if (pqsIndex < 0)
					pqsIndex = pqsPlanets.Count - 1;
				if (pqsIndex >= pqsPlanets.Count)
					pqsIndex = 0;
			}
			GUILayout.EndHorizontal ();

			GUILayout.BeginHorizontal (GUILayout.ExpandWidth(true));
			if (GUILayout.Button ("<", GUILayout.Width (30f), GUILayout.Height(30f)))
			{
				resIndex--;

				if (resIndex < 0)
					resIndex = possibleResolutions.Length - 1;
				if (resIndex >= possibleResolutions.Length)
					resIndex = 0;
			}

			GUILayout.Label (possibleResolutions[resIndex].ToString() + " x " + (possibleResolutions[resIndex] / 2).ToString(), GUI.skin.box, GUILayout.ExpandWidth(true), GUILayout.Height(30f));

			if (GUILayout.Button (">", GUILayout.Width (30f), GUILayout.Height(30f)))
			{
				resIndex++;

				if (resIndex < 0)
					pqsIndex = possibleResolutions.Length - 1;
				if (resIndex >= possibleResolutions.Length)
					resIndex = 0;
			}
			GUILayout.EndHorizontal ();

			if (GUILayout.Button ("Export Textures"))
			{
				Directory.CreateDirectory (KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansion/PluginData/");
				PQS pqs = pqsPlanets [pqsIndex].pqsController;
				var texs = pqs.CreateMaps (possibleResolutions [resIndex], pqs.mapMaxHeight, pqsPlanets [pqsIndex].ocean, pqs.mapOceanHeight, pqs.mapOceanColor);
				var texNorm = Kopernicus.Utility.BumpToNormalMap (texs [1], 9);
				string bodyName = pqsPlanets [pqsIndex].bodyName;

				File.WriteAllBytes (KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansion/PluginData/" + bodyName + "_Color.png", texs [0].EncodeToPNG ());
				File.WriteAllBytes (KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansion/PluginData/" + bodyName + "_Height.png", texs [1].EncodeToPNG ());
				File.WriteAllBytes (KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansion/PluginData/" + bodyName + "_Normal.png", texNorm.EncodeToPNG ());
			}

			GUI.DragWindow ();
		}

		bool showTextureWindow = false;
		Rect texWindowRect = new Rect (200f, 200f, 200f, 110f);
		string textureName = "";
		Texture2D texture;
		void TextureWindow(int id)
		{
			textureName = GUILayout.TextField (textureName);
			if (GUILayout.Button ("Print Texture"))
			{
				texture = UnityEngine.Resources.FindObjectsOfTypeAll<Texture2D> ().Where (t => t.name == textureName).First ();
				if (texture == null)
				{
					ScreenMessages.PostScreenMessage ("<color=red>Error: texture " + textureName + " not found.</color>");
				}
			}

			GUI.DragWindow ();
		}

		//debugging crap
		void Update()
		{
			bool isModDown = GameSettings.MODIFIER_KEY.GetKey ();

			if (isModDown && Input.GetKeyDown (KeyCode.P))
			{
				Debug.Log ("FPS: " + (1f / Time.deltaTime));
			}

			if (isModDown && Input.GetKeyDown (KeyCode.Alpha1))
			{
				foreach (var tex in UnityEngine.Resources.FindObjectsOfTypeAll<Texture2D>())
				{
					Utils.Log ("Texture: " + tex.name);
				}
			}
			if (isModDown && Input.GetKeyDown (KeyCode.Alpha2))
			{
				showTextureWindow = !showTextureWindow;
			}
		}
	}
}

