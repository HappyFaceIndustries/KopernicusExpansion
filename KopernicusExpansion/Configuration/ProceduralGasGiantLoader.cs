using System;
using System.Linq;
using System.Collections.Generic;

using KopernicusExpansion.Editors;
using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Resources;
using KopernicusExpansion.Utility.Noise;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using UnityEngine;

#pragma warning disable 0414

namespace KopernicusExpansion.Configuration
{
	[ExternalParserTarget("ProceduralGasGiant", parentNodeName = "ScaledVersion")]
	public class ProceduralGasGiantLoader : ExternalParserTargetLoader, IParserEventSubscriber
	{
		//constructor
		public ProceduralGasGiantLoader ()
		{
			material = new Material (Shaders.ProceduralGasGiant);
			material.name = "ProceduralGasGiant_" + Guid.NewGuid ().ToString ();

			//set default values
			material.SetFloat ("_StormDistortion", 0f);
		}

		private Material material;
		private bool _hasStorms = true;
		private bool _animate = true;
		private float _cloudSpeed = 2f;
		private int _seed = 0;

		[ParserTarget("rampTexture", allowMerge = false, optional = true)]
		public Texture2DParser rampTex
		{
			set
			{
				material.SetTexture ("_MainTex", value.value);
			}
		}

		[ParserTarget("rampTextureGradient", allowMerge = false, optional = true)]
		public Kopernicus.Configuration.Gradient rampTexGradient
		{
			set
			{
				Texture2D ramp = new Texture2D(2048, 1, TextureFormat.RGB24, false);
				Color[] colors = ramp.GetPixels (0);
				for (int i = 0; i < colors.Length; i++)
				{
					float k = ((float)i) / ((float)colors.Length);
					colors [i] = value.ColorAt (k);
				}
				ramp.SetPixels (colors, 0);
				ramp.Apply ();

				material.SetTexture ("_MainTex", ramp);
			}
		}

		[ParserTarget("generateRampFromScaledTexture", optional = true)]
		public Texture2DParser generateFromPrev
		{
			set
			{
				try
				{
					Texture2D prevTex = value.value;
					Texture2D newTex = new Texture2D (prevTex.height, 1, TextureFormat.RGB24, false);

					for(int i = 0; i < prevTex.height; i++)
					{
						newTex.SetPixel(i, 0, prevTex.GetPixel(0, i));
					}
					newTex.Apply();

					material.SetTexture ("_MainTex", newTex);
				}
				catch(Exception exception)
				{
					Logger.Active.LogException (exception);
				}
			}
		}

		[ParserTarget("stormMap", optional = true)]
		public Texture2DParser stormMap
		{
			set
			{
				material.SetTexture ("_StormMap", value.value);
			}
		}

		[ParserTarget("seed", optional = true)]
		public NumericParser<int> seed
		{
			set
			{
				_seed = Math.Max(0, value.value);
			}
		}

		[ParserTarget("animate", optional = true)]
		public NumericParser<bool> animate
		{
			set
			{
				_animate = value.value;
			}
		}

		[ParserTarget("cloudSpeed", optional = true)]
		public NumericParser<float> cloudSpeed
		{
			set
			{
				_cloudSpeed = Mathf.Max(0f, value.value);
			}
		}

		[PreApply]
		[ParserTarget("hasStorms", optional = true)]
		public NumericParser<bool> hasStorms
		{
			set
			{
				_hasStorms = value.value;
			}
		}

		[ParserTarget("distortion", optional = true)]
		public NumericParser<float> distortion
		{
			set
			{
				material.SetFloat ("_Distortion", Mathf.Clamp (value.value, 0f, 0.05f));
			}
		}

		[ParserTarget("frequency", optional = true)]
		public NumericParser<float> frequency
		{
			set
			{
				material.SetFloat ("_MainFrequency", Mathf.Max (0f, value.value));
			}
		}

		[ParserTarget("lacunarity", optional = true)]
		public NumericParser<float> lacunarity
		{
			set
			{
				material.SetFloat ("_Lacunarity", Mathf.Max (0f, value.value));
			}
		}

		[ParserTarget("gain", optional = true)]
		public NumericParser<float> gain
		{
			set
			{
				material.SetFloat ("_Gain", Mathf.Max (0f, value.value));
			}
		}

		[ParserTarget("stormFrequency", optional = true)]
		public NumericParser<float> stormFrequency
		{
			set
			{
				if(_hasStorms)
					material.SetFloat ("_StormFrequency", Mathf.Max (0f, value.value));
				else
					material.SetFloat ("_StormFrequency", 0f);
			}
		}

		[ParserTarget("stormDistortion", optional = true)]
		public NumericParser<float> stormThreshold
		{
			set
			{
				if(_hasStorms)
					material.SetFloat ("_StormDistortion", Mathf.Max (0f, value.value));
				else
					material.SetFloat ("_StormDistortion", 2f);
			}
		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{
			if (!Settings.AllowGasGiants)
			{
				Logger.Active.Log ("Not applying effect because procedural gas giants are disallowed in the settings");
				return;
			}

			Renderer scaledRenderer = generatedBody.scaledVersion.renderer;
			scaledRenderer.sharedMaterial = material;

			var gasGiantComponent = generatedBody.scaledVersion.AddComponent<ProceduralGasGiant> ();
			gasGiantComponent.speed = _cloudSpeed / 10000f;
			gasGiantComponent.doAnimate = _animate;
			gasGiantComponent.seed = _seed;
			gasGiantComponent.Init ();
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class ProceduralGasGiant : MonoBehaviour
	{
		private const float MaxTime = 10000;

		public int seed = 0;
		public float speed = 0.002f;
		public bool doAnimate = true;

		private ImprovedPerlinNoise noise;

		public void Init()
		{
			DontDestroyOnLoad (this);

			noise = new ImprovedPerlinNoise (seed);
			noise.LoadResourcesFor3DNoise ();
			renderer.material.SetTexture ("_PermTable2D", noise.GetPermutationTable2D ());
			renderer.material.SetTexture ("_Gradient3D", noise.GetGradient3D ());
			currentTime = 0;
			renderer.material.SetFloat ("_Evolution", currentTime);
		}

		private float currentTime = 0f;
		void LateUpdate()
		{
			if(doAnimate && Settings.AllowGasGiantAnimation)
			{
				//will only speed animation up to 5000x timewarp speed
				currentTime += Time.deltaTime * Mathf.Min(TimeWarp.CurrentRate, 5000f) * speed;
				if (currentTime >= MaxTime)
					currentTime = 0;

				renderer.material.SetFloat ("_Evolution", currentTime);
			}
		}
	}
}

namespace KopernicusExpansion.Editors
{
	[IngameEditor("Gas Giant Editor")]
	public class ProceduralGasGiantEditor : IngameEditor
	{
		Rect windowRect = new Rect (250, 200, 450, 350);

		GameObject targetPlanetScaled;

		void OnGUI()
		{
			if(IsWindowOpen)
				windowRect = GUILayout.Window ("ProceduralGasGiantEditor".GetHashCode (), windowRect, Window, "Procedural Gas Giant Editor");
		}
		void Update()
		{
			if (!IsWindowOpen)
				return;
				
			var mapObj = PlanetariumCamera.fetch.target;
			if (mapObj.celestialBody != null &&
			    mapObj.celestialBody.scaledBody != null &&
			    mapObj.celestialBody.scaledBody.renderer != null &&
				mapObj.celestialBody.scaledBody.renderer.sharedMaterial.shader.name == "ProceduralGasGiant")
			{
				targetPlanetScaled = mapObj.celestialBody.scaledBody;
			}
			else
				targetPlanetScaled = null;
		}

		private void Window (int id)
		{
			if (targetPlanetScaled == null)
			{
				GUILayout.Label ("<b><color=red>No procedural gas giant selected.</color></b>");
				GUI.DragWindow ();
				return;
			}

			GUILayout.Label("<b><color=orange>" + targetPlanetScaled.name + ":</color></b>");
			GUILayout.Space (20f);

			GUILayout.Label ("<b>Main Pattern:</b>");

			try
			{
				targetPlanetScaled.renderer.material.SetFloat("_Distortion", slider (targetPlanetScaled.renderer.material.GetFloat ("_Distortion"), "distortion", 0f, 0.15f));
				targetPlanetScaled.renderer.material.SetFloat("_MainFrequency", slider (targetPlanetScaled.renderer.material.GetFloat ("_MainFrequency"), "frequency", 0.01f, 50f));
				targetPlanetScaled.renderer.material.SetFloat("_Lacunarity", slider (targetPlanetScaled.renderer.material.GetFloat ("_Lacunarity"), "lacunarity", 0f, 9f));
				targetPlanetScaled.renderer.material.SetFloat("_Gain", slider (targetPlanetScaled.renderer.material.GetFloat ("_Gain"), "gain", 0f, 3f));
				GUILayout.Space (8f);
				GUILayout.Label ("<b>Storms:</b>");
				targetPlanetScaled.renderer.material.SetFloat("_StormFrequency", slider (targetPlanetScaled.renderer.material.GetFloat ("_StormFrequency"), "stormFrequency", 0.01f, 8f));
				targetPlanetScaled.renderer.material.SetFloat("_StormDistortion", slider (targetPlanetScaled.renderer.material.GetFloat ("_StormDistortion"), "stormDistortion", 0f, 1.1f));
			}
			catch
			{
				GUILayout.Label ("<color=red>ERROR!</color>");
			}

			//TODO: export button

			GUI.DragWindow ();
		}

		float slider(float value, string name, float min, float max)
		{
			float returnValue = value;
			GUILayout.BeginHorizontal ();
			GUILayout.Label (name + ":  ", GUILayout.ExpandWidth(false));
			GUILayout.Label ("<color=white>" + returnValue.ToString ("00.000") + "</color>", GUILayout.ExpandWidth(false));
			returnValue = GUILayout.HorizontalSlider (value, min, max, GUILayout.ExpandWidth(true));
			GUILayout.EndHorizontal ();
			return returnValue;
		}
	}
}

#pragma warning restore 0414