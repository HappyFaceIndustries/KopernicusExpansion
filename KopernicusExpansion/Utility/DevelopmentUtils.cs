using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.OnDemand;
using Kopernicus.Constants;
using Kopernicus.Configuration;

using KopernicusExpansion;
using KopernicusExpansion.Editors;
using KopernicusExpansion.Resources;

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

			var buttonTexture = new Texture2D (39, 39);
			buttonTexture.LoadImage (Textures.DevelopmentUtilsIcon);
			mainWindowButton = ApplicationLauncher.Instance.AddModApplication (delegate {
				isMainWindowOpen = true;
			}, delegate {
				isMainWindowOpen = false;
			},
				null, null, null, null, ApplicationLauncher.AppScenes.TRACKSTATION | ApplicationLauncher.AppScenes.MAPVIEW | ApplicationLauncher.AppScenes.SPACECENTER | ApplicationLauncher.AppScenes.FLIGHT, buttonTexture);
			ApplicationLauncher.Instance.EnableMutuallyExclusive (mainWindowButton);

			var editors = IngameEditorUtils.GetEditors ();
			foreach (var editor in editors) 
			{
				editor.transform.parent = this.transform;
				ingameEditorObjects.Add (editor.gameObject.name, editor);
			}

			centeredText = new GUIStyle (skin.label);
			centeredText.alignment = TextAnchor.MiddleCenter;

			smallButton = new GUIStyle (skin.button);
			smallButton.padding.top = 3;
			smallButton.padding.bottom = 3;
			smallButton.padding.right = 5;
			smallButton.padding.left = 5;

			hideHorizScrollbar = new GUIStyle (skin.horizontalScrollbar);
			hideHorizScrollbar.fixedHeight = 0f;

			colorSelectorTextField = new GUIStyle (skin.textField);
			colorSelectorTextField.normal.background = Texture2D.whiteTexture;
			colorSelectorTextField.focused.background = Texture2D.whiteTexture;
			colorSelectorTextField.active.background = Texture2D.whiteTexture;
			colorSelectorTextField.hover.background = Texture2D.whiteTexture;

			//estimate the height of the text box
			float height = skin.textField.CalcHeight (new GUIContent ("0.0"), 120f);
			int marginTop = skin.textField.margin.top;
			int marginBottom = skin.textField.margin.bottom;

			manipulationSliderStyle = new GUIStyle (skin.horizontalSlider);
			manipulationSliderStyle.fixedHeight = height;
			manipulationSliderStyle.margin.top = marginTop;
			manipulationSliderStyle.margin.bottom = marginBottom;
			manipulationSliderThumbStyle = new GUIStyle (skin.horizontalSliderThumb);
			manipulationSliderThumbStyle.fixedHeight = height;

			PQSBodies = Utils.GetBodies ().Where (p => p.pqsController != null).ToArray ();

			if (PQSBodies.Length > 0)
			{
				var material = Utils.GetScaled (PQSBodies [selectedPQSBody].name).renderer.sharedMaterial;

				previewTextureColor = (Texture2D)material.GetTexture("_MainTex");
				previewTextureBump = (Texture2D)material.GetTexture ("_BumpMap");

				if (previewTextureColor == null)
					previewTextureBump = Texture2D.blackTexture;
				if (previewTextureBump == null)
					previewTextureBump = Texture2D.blackTexture;
			}
			else
			{
				previewTextureColor = Texture2D.blackTexture;
				previewTextureBump = Texture2D.blackTexture;
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

		private ApplicationLauncherButton mainWindowButton;

		private string mainWindowTitle = "KopernicusExpansion Development Tools";
		private string scaledExporterWindowTitle = "ScaledVersion Exporter";
		private string textureViewerWindowTitle = "Builtin-Texture Viewer";

		private int mainWindowID = "KopE_MainWindow".GetHashCode();
		private int scaledExporterWindowID = "KopE_ScaledExporterWindow".GetHashCode();
		private int textureViewerWindowID = "KopE_TextureViewerWindow".GetHashCode();

		private Rect mainWindowRect = new Rect ((Screen.width - 305f), 40f, 300f, 410f);
		private Rect mainWindowRectTrackingStation = new Rect ((Screen.width - 305f), (Screen.height - 460f), 300f, 410f);
		private Rect scaledExporterWindowRect = new Rect (200f, 200f, 600f, 400f);
		private Rect textureViewerWindowRect = new Rect (200f, 200f, 350f, 200f);

		private Vector2 mainScrollView;
		private Vector2 scaledExporterScrollView1;
		private Vector2 scaledExporterScrollView2;

		private GUISkin skin;
		private Texture2D lineTexture;
		private GUIStyle centeredText;
		private GUIStyle smallButton;
		private GUIStyle colorSelectorTextField;
		private GUIStyle hideHorizScrollbar;

		private Dictionary<string, IngameEditor> ingameEditorObjects = new Dictionary<string, IngameEditor> ();

		private int selectedPQSBody = 0;
		private Texture2D previewTextureColor;
		private Texture2D previewTextureBump;
		private bool previewIsBump = false;
		private int exportResolution = 2048;
		private float normalStrength = 8f;
		private string specPath = "";
		private string oceanColorString = "#0000ff";
		private ColorParser oceanColorColorParser = new ColorParser ();
		private bool genSpecFromOceans = false;
		private bool colorOceans = true;
		private bool updateScaled = true;
		private bool writeFiles = true;
		private CelestialBody[] PQSBodies = new CelestialBody[0];

		private void OnGUI()
		{
			if (!showUI)
				return;

			GUI.skin = skin;

			if (isMainWindowOpen)
			{
				var rect = HighLogic.LoadedScene == GameScenes.TRACKSTATION ? mainWindowRectTrackingStation : mainWindowRect;
				GUILayout.Window (mainWindowID, rect, MainWindow, mainWindowTitle);
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

			isScaledExporterOpen = GUILayout.Toggle (isScaledExporterOpen, "ScaledVersion Exporter", skin.button, GUILayout.Height (buttonHeight));
			isTextureViewerOpen = GUILayout.Toggle (isTextureViewerOpen, "Texture Viewer", skin.button, GUILayout.Height (buttonHeight));

			GUILayout.Space (5f);
			var lineRect = GUILayoutUtility.GetRect (1f, 1f, 1f, 1f);
			GUI.DrawTexture (lineRect, lineTexture, ScaleMode.StretchToFill, true);
			GUILayout.Space (5f);

			foreach (var editor in ingameEditorObjects)
			{
				editor.Value.IsWindowOpen = GUILayout.Toggle (editor.Value.IsWindowOpen, editor.Key, skin.button, GUILayout.Height (buttonHeight));
			}

			GUILayout.EndScrollView ();
		}

		#region ScaledExporter
		private void ScaledExporterWindow(int id)
		{
			GUILayout.BeginHorizontal ();

			GUILayout.BeginVertical (GUILayout.Width (380f));
			scaledExporterScrollView1 = GUILayout.BeginScrollView (scaledExporterScrollView1, false, true, hideHorizScrollbar, skin.verticalScrollbar, skin.scrollView);

			var selectedBody = PQSBodies [selectedPQSBody];

			GUILayout.Label ("<b><color=#b7fe00>" + selectedBody.theName + "</color></b>", centeredText);
			GUILayout.Space (5f);

			GUILayout.BeginHorizontal ();
			if (previewIsBump)
			{
				if (GUILayout.Button ("Color Map", smallButton, GUILayout.ExpandWidth (false)))
				{
					previewIsBump = false;
				}
			}
			else
			{
				GUILayout.Toggle (true, "Color Map", smallButton, GUILayout.ExpandWidth (false));
			}
			if (!previewIsBump)
			{
				if (GUILayout.Button ("Bump Map", smallButton, GUILayout.ExpandWidth (false)))
				{
					previewIsBump = true;
				}
			}
			else
			{
				GUILayout.Toggle (true, "Bump Map", smallButton, GUILayout.ExpandWidth (false));
			}
			GUILayout.EndHorizontal ();

			if(previewIsBump)
				GUILayout.Label (previewTextureBump, GUILayout.Width (360f), GUILayout.Height (180f));
			else
				GUILayout.Label (previewTextureColor, GUILayout.Width (360f), GUILayout.Height (180f));

			if (HighLogic.LoadedScene == GameScenes.TRACKSTATION || HighLogic.LoadedScene == GameScenes.FLIGHT)
			{
				string buttonText = HighLogic.LoadedSceneIsFlight ? "View in Map Mode" : "Focus on planet";
				if (GUILayout.Button (buttonText, smallButton, GUILayout.ExpandWidth (false)))
				{
					PlanetariumCamera.fetch.SetTarget (selectedBody);
					PlanetariumCamera.fetch.SetDistance ((float)selectedBody.Radius * 4f * ScaledSpace.InverseScaleFactor);
					if (HighLogic.LoadedSceneIsFlight)
						MapView.EnterMapView ();
				}
			}
			GUILayout.Space (5f);

			//resolution
			GUILayout.Label ("Resolution:");
			exportResolution = (int)(DrawManipulationSlider ("exportResolution", "", (float)exportResolution, 4f, 8192f, "###0") / 2f) * 2;

			//normal strength
			GUILayout.Label ("Normal Map Strength:");
			normalStrength = DrawManipulationSlider ("normalStrength", "", normalStrength, 0f, 16f);

			//specular map selection
			GUILayout.Label ("Specular Map Path");
			if (!GameDatabase.Instance.ExistsTexture (specPath))
			{
				GUI.color = Color.red;
			}
			specPath = GUILayout.TextField (specPath);
			GUI.color = Color.white;

			GUILayout.Space (5f);
			var lineRect = GUILayoutUtility.GetRect (1f, 1f, 1f, 1f);
			GUI.DrawTexture (lineRect, lineTexture, ScaleMode.StretchToFill, true);
			GUILayout.Space (5f);

			//ocean related options
			if(selectedBody.ocean)
			{
				//ocean color
				colorOceans = GUILayout.Toggle (colorOceans, "Render Oceans");
				if(colorOceans)
				{
					//ocean color selection
					GUILayout.Label ("Ocean Color (hexadecimal)");
					try
					{
						oceanColorColorParser.SetFromString (oceanColorString);
						GUI.backgroundColor = oceanColorColorParser.value;
						GUI.contentColor = oceanColorColorParser.value.grayscale < 0.5f ? Color.white : Color.black;
					}
					catch
					{
						GUI.contentColor = Color.red;
						GUI.backgroundColor = Color.red;
						GUI.color = Color.red;
					}
					oceanColorString = GUILayout.TextField (oceanColorString, colorSelectorTextField);
					GUI.contentColor = Color.white;
					GUI.backgroundColor = Color.white;
					GUI.color = Color.white;
				}

				//spec
				genSpecFromOceans = GUILayout.Toggle (genSpecFromOceans, "Generate Specular Map from Oceans");

				GUILayout.Space (5f);
				lineRect = GUILayoutUtility.GetRect (1f, 1f, 1f, 1f);
				GUI.DrawTexture (lineRect, lineTexture, ScaleMode.StretchToFill, true);
				GUILayout.Space (5f);
			}

			//build options
			updateScaled = GUILayout.Toggle (updateScaled, "Update ScaledSpace");
			writeFiles = GUILayout.Toggle (writeFiles, "Export Files");

			if (GUILayout.Button ("<b>Build Maps</b>"))
			{
				var specMap = GameDatabase.Instance.GetTexture (specPath, false);
				Color oceanColor = Color.black;
				try
				{
					oceanColorColorParser.SetFromString (oceanColorString);
					oceanColor = oceanColorColorParser.value;
				}
				catch {}

				Utils.BuildMaps (selectedBody, specMap, exportResolution, normalStrength, writeFiles, genSpecFromOceans, colorOceans, oceanColor, updateScaled);
				var material = Utils.GetScaled (selectedBody.name).renderer.sharedMaterial;

				previewTextureColor = (Texture2D)material.GetTexture("_MainTex");
				previewTextureBump = (Texture2D)material.GetTexture ("_BumpMap");

				if (previewTextureColor == null)
					previewTextureBump = Texture2D.blackTexture;
				if (previewTextureBump == null)
					previewTextureBump = Texture2D.blackTexture;
			}

			GUILayout.Label ("You can see more information about the exported maps in the exported log file at Logs/KopernicusExpansion/" + selectedBody.bodyName + ".ScaledExport.log");

			GUILayout.EndScrollView ();
			GUILayout.EndVertical ();

			GUILayout.Space (1f);

			GUILayout.BeginVertical ();
			GUILayout.Label ("<b><color=#b7fe00>Celestial Bodies</color></b>", centeredText);
			scaledExporterScrollView2 = GUILayout.BeginScrollView (scaledExporterScrollView2);

			for(int i = 0; i < PQSBodies.Length; i++)
			{
				var body = PQSBodies [i];
				if (i == selectedPQSBody)
				{
					GUILayout.Toggle (true, body.theName, skin.button);
				}
				else
				{
					if (GUILayout.Button (body.theName))
					{
						selectedPQSBody = i;
						var material = Utils.GetScaled (PQSBodies [selectedPQSBody].name).renderer.sharedMaterial;

						previewTextureColor = (Texture2D)material.GetTexture("_MainTex");
						previewTextureBump = (Texture2D)material.GetTexture ("_BumpMap");

						if (previewTextureColor == null)
							previewTextureBump = Texture2D.blackTexture;
						if (previewTextureBump == null)
							previewTextureBump = Texture2D.blackTexture;
					}
				}
			}

			GUILayout.EndScrollView ();
			GUILayout.EndVertical ();

			GUILayout.EndHorizontal ();

			GUI.DragWindow ();
		}

		private Dictionary<string, string> textBoxValues = new Dictionary<string, string>();
		private Dictionary<string, Color> textBoxColors = new Dictionary<string, Color>();
		private GUIStyle manipulationSliderStyle;
		private GUIStyle manipulationSliderThumbStyle;
		private float DrawManipulationSlider(string uniqueName, string name, float value, float min, float max, string toStringPattern = "###0.0###")
		{
			value = Mathf.Clamp (value, min, max);
			if (!textBoxValues.ContainsKey (uniqueName))
				textBoxValues.Add (uniqueName, value.ToString ());
			if (!textBoxColors.ContainsKey (uniqueName))
				textBoxColors.Add (uniqueName, Color.white);

			GUILayout.BeginHorizontal ();

			if(!string.IsNullOrEmpty(name))
				GUILayout.Label ("<b><color=orange>" + name + ":</color></b>");

			//gui focus stuff
			string textBoxControlName = "ManipulationTextBox_" + uniqueName;
			string sliderControlName = "ManipulationSlider_" + uniqueName;
			string focusedControl = GUI.GetNameOfFocusedControl ();

			GUI.SetNextControlName (textBoxControlName);
			GUI.color = textBoxColors [uniqueName];
			textBoxValues [uniqueName] = GUILayout.TextField (textBoxValues [uniqueName], GUILayout.Width(120f));
			GUI.color = Color.white;

			float parsedTextBoxFloat;
			bool parsedTextBox = true;
			if (!float.TryParse (textBoxValues [uniqueName], out parsedTextBoxFloat))
			{
				//make the color red if it fails to parse the text box
				textBoxColors [uniqueName] = Color.red;
				parsedTextBox = false;
			}
			if (parsedTextBox && (parsedTextBoxFloat < min || parsedTextBoxFloat > max))
			{
				//also make the color red if the value is not within the specified contraints
				textBoxColors [uniqueName] = Color.red;
				parsedTextBox = false;
			}
			if(parsedTextBox)
			{
				textBoxColors [uniqueName] = Color.white;
			}

			float sliderValue = value;
			if (parsedTextBox && focusedControl == textBoxControlName)
			{
				sliderValue = parsedTextBoxFloat;
			}

			GUI.SetNextControlName (sliderControlName);
			sliderValue = GUILayout.HorizontalSlider (sliderValue, min, max, manipulationSliderStyle, manipulationSliderThumbStyle, GUILayout.Width(220f));

			//take focus off of the text box if it's focused, and the slider has been clicked
			Rect sliderRect = GUILayoutUtility.GetLastRect ();
			if(focusedControl == textBoxControlName && sliderRect.Contains(Event.current.mousePosition) && (Input.GetMouseButtonDown(0) || Input.GetMouseButtonDown(1)))
			{
				GUI.FocusControl (sliderControlName);
			}

			if (focusedControl != textBoxControlName)
			{
				textBoxValues [uniqueName] = sliderValue.ToString (toStringPattern);
			}

			GUILayout.EndHorizontal ();

			return sliderValue;
		}
		#endregion

		#region TextureViewer
		private string textureName = "";
		private Texture2D texture;

		private void TextureViewerWindow(int id)
		{


			GUI.DragWindow ();
		}
		#endregion
	}
}

