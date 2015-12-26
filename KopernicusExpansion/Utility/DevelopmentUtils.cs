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

		private Rect mainWindowRect;
		private Rect scaledExporterWindowRect;
		private Rect textureViewerWindowRect;

		private void OnGUI()
		{
			if (!showUI)
				return;

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

		private void MainWindow(int id)
		{

		}

		private void ScaledExporterWindow(int id)
		{

		}

		private void TextureViewerWindow(int id)
		{

		}
	}
}

