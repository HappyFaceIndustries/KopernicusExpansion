using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.OnDemand;
using Kopernicus.Constants;
using Kopernicus.Configuration;

using KopernicusExpansion;

using UnityEngine;

namespace KopernicusExpansion.Utility
{
	[KSPAddon(KSPAddon.Startup.MainMenu, true)]
	public class DevelopmentUtils : MonoBehaviour
	{
		/* Development Utils
		 * ScaledSpace Exporter:
		 *  - Resolution Selector
		 *  - Normal Strength Slider
		 *  - Bumpmap height taken from input fields instead of PQS
		 *  - Auto-update for scaledspace in-game
		 *  - Specular maps
		 * Texture Viewer
		 *  - Allow viewing textures by name
		 *  - Prints a list of texture names into a scroll-area, and you can click on them to view them
		 */

		private void Start()
		{
			//disable if not enabled... obviously
			if (!Settings.AllowEditors)
			{
				DestroyImmediate (this);
				return;
			}

			skin = HighLogic.Skin;
			lineTexture = new Texture2D (1, 1);
			lineTexture.SetPixel (0, 0, new Color (0.66f, 0.66f, 0.66f));
			lineTexture.Apply ();

			DontDestroyOnLoad (this);

			GameEvents.onShowUI.Add (OnShowUI);
			GameEvents.onHideUI.Add (OnHideUI);
		}

		//Events
		private void OnShowUI()
		{
			showUI = true;
		}
		private void OnHideUI()
		{
			showUI = false;
		}

		//GUI stuff
		private bool showUI = true;

		private bool isMainWindowOpen = false;
		private bool isScaledExporterOpen = false;
		private bool isTextureViewerOpen = false;

		private string mainWindowTitle = "KopernicusExpansion Development Utilities";
		private string scaledExporterWindowTitle = "ScaledVersion Exporter";
		private string textureViewerWindowTitle = "Inbuilt-Texture Viewer";

		private int mainWindowID = "KopE_MainWindow".GetHashCode();
		private int scaledExporterWindowID = "KopE_ScaledExporterWindow".GetHashCode();
		private int textureViewerWindowID = "KopE_TextureViewerWindow".GetHashCode();

		private Rect mainWindowRect = new Rect (200f, 200f, 350f, 200f);
		private Rect scaledExporterWindowRect;
		private Rect textureViewerWindowRect;

		private Vector2 mainScrollView;

		private GUISkin skin;
		private Texture2D lineTexture;

		private void OnGUI()
		{
			if (!showUI)
				return;

			GUI.skin = skin;

			if (isMainWindowOpen)
			{
				mainWindowRect = GUILayout.Window (mainWindowID, mainWindowRect, MainWindow, mainWindowTitle, GUILayout.ExpandHeight (true));
			}
			if (isScaledExporterOpen)
			{
				scaledExporterWindowRect = GUILayout.Window (scaledExporterWindowID, scaledExporterWindowRect, ScaledExporterWindow, scaledExporterWindowTitle);
			}
			if (isTextureViewerOpen)
			{
				textureViewerWindowRect = GUILayout.Window (textureViewerWindowID, textureViewerWindowRect, TextureViewerWindow, textureViewerWindowTitle);
			}
		}
		private void Update()
		{
			if (GameSettings.MODIFIER_KEY.GetKey () && Input.GetKeyDown (KeyCode.Alpha0))
			{
				isMainWindowOpen = !isMainWindowOpen;
			}
		}

		private void MainWindow(int id)
		{
			mainScrollView = GUILayout.BeginScrollView (mainScrollView);

			float buttonWidth;
			float buttonHeight;
			skin.button.CalcMinMaxWidth (new GUIContent ("Button Tester"), out buttonHeight, out buttonWidth);
			buttonHeight = skin.button.CalcHeight (new GUIContent ("Button Tester"), buttonWidth);

			isScaledExporterOpen = GUILayout.Toggle (isScaledExporterOpen, "Scaled Exporter", skin.button, GUILayout.Height (buttonHeight));
			isTextureViewerOpen = GUILayout.Toggle (isTextureViewerOpen, "Texture Viewer", skin.button, GUILayout.Height (buttonHeight));

			GUILayout.Space (10f);
			var lineRect = GUILayoutUtility.GetRect (0f, 10000f, 1f, 1f);
			GUI.DrawTexture (lineRect, lineTexture, ScaleMode.StretchToFill, true);
			GUILayout.Space (10f);

			//TODO: In-game Editors

			GUILayout.EndScrollView ();

			GUI.DragWindow ();
		}

		private void ScaledExporterWindow(int id)
		{

		}

		private void TextureViewerWindow(int id)
		{

		}
	}
}

