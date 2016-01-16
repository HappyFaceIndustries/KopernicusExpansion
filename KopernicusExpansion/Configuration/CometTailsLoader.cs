using System;
using System.Linq;
using System.Collections.Generic;

using KopernicusExpansion.Editors;
using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Resources;
using KopernicusExpansion.Utility.Noise;
using KopernicusExpansion.Utility.Geometry;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using UnityEngine;

#pragma warning disable 0414

namespace KopernicusExpansion.Configuration
{
	[IngameEditor(typeof(Editors.CometTailEditor), "Comet Tail Editor", GameScenes.TRACKSTATION, GameScenes.FLIGHT)]
	[ExternalParserTarget("CometTails")]
	public class CometTailsLoader : ExternalParserTargetLoader, IParserEventSubscriber
	{
		[ParserTargetCollection("Tails", optional = true, nameSignificance = NameSignificance.None)]
		public List<CometTailLoader> tails = new List<CometTailLoader>();

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{
			foreach(var tail in tails)
			{
				var cometTail = tail.tail;
				CometTail.AddCometTail (generatedBody, cometTail);
				Logger.Active.Log ("Added CometTail to body " + generatedBody.name);
			}
		}
	}

	[RequireConfigType(ConfigType.Node)]
	public class CometTailLoader : IParserEventSubscriber
	{
		//contructor
		public CometTailLoader()
		{
			tail = new CometTail ();
		}

		public CometTail tail;

		[PreApply]
		[ParserTarget("type", optional = false)]
		public EnumParser<CometTailType> type
		{
			set
			{
				tail.type = value.value;
			}
		}

		[ParserTarget("color", optional = true)]
		public ColorParser color
		{
			set
			{
				tail.color = value.value;
			}
		}
		[ParserTarget("rimPower", optional = true)]
		public NumericParser<float> rimPower
		{
			set
			{
				tail.rimPower = value.value;
			}
		}
		[ParserTarget("distortion", optional = true)]
		public NumericParser<float> distortion
		{
			set
			{
				tail.distortion = value.value;
			}
		}
		[ParserTarget("alphaDistortion", optional = true)]
		public NumericParser<float> alphaDistortion
		{
			set
			{
				tail.alphaDistortion = value.value;
			}
		}
		[ParserTarget("zDistortion", optional = true)]
		public NumericParser<float> zDistortion
		{
			set
			{
				tail.zDistortion = value.value;
			}
		}
		[ParserTarget("frequency", optional = true)]
		public NumericParser<float> frequency
		{
			set
			{
				tail.frequency = value.value;
			}
		}
		[ParserTarget("lacunarity", optional = true)]
		public NumericParser<float> lacunarity
		{
			set
			{
				tail.lacunarity = value.value;
			}
		}
		[ParserTarget("gain", optional = true)]
		public NumericParser<float> gain
		{
			set
			{
				tail.gain = value.value;
			}
		}


		[ParserTarget("radius", optional = true)]
		public NumericParser<float> radius
		{
			set
			{
				tail.radius = value.value;
			}
		}

		[ParserTarget("length", optional = true)]
		public NumericParser<float> maxLength
		{
			set
			{
				tail.length = value.value;
			}
		}

		[ParserTarget("opacityCurve", optional = true)]
		public FloatCurveParser opacityCurve
		{
			set
			{
				tail.opacityCurve = value.curve;
			}
		}
			
		[ParserTarget("brightnessCurve", optional = true)]
		public FloatCurveParser brightnessCurve
		{
			set
			{
				tail.brightnessCurve = value.curve;
			}
		}

		public void Apply(ConfigNode node)
		{
			//set default curves
			tail.opacityCurve = new FloatCurve ();
			tail.opacityCurve.Add (0f, 0.6f);
			tail.opacityCurve.Add (5e9f, 0.45f);
			tail.opacityCurve.Add (1.25e10f, 0.1f);
			tail.opacityCurve.Add (2e10f, 0.0075f);
			tail.opacityCurve.Add (3e10f, 0f);
			tail.opacityCurve.Add (float.MaxValue, 0f);

			if (tail.type == CometTailType.Ion)
			{
				tail.brightnessCurve = new FloatCurve ();
				tail.brightnessCurve.Add (0f, 1f);
				tail.brightnessCurve.Add (5e9f, 0.4f);
				tail.brightnessCurve.Add (1.25e10f, 0.09f);
				tail.brightnessCurve.Add (2e10f, 0.0075f);
				tail.brightnessCurve.Add (3e10f, 0f);
				tail.brightnessCurve.Add (float.MaxValue, 0f);
			}
			else
			{
				tail.brightnessCurve = new FloatCurve ();
				tail.brightnessCurve.Add (0f, 1f);
				tail.brightnessCurve.Add (5e9f, 0.53f);
				tail.brightnessCurve.Add (1.25e10f, 0.1f);
				tail.brightnessCurve.Add (2e10f, 0.008f);
				tail.brightnessCurve.Add (3e10f, 0f);
				tail.brightnessCurve.Add (float.MaxValue, 0f);
			}
		}
		public void PostApply(ConfigNode node)
		{
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class CometTail
	{
		public CometTailType type;

		public Color color = Color.white;
		public float rimPower = 1.41f;
		public float distortion = 0.143f;
		public float alphaDistortion = 0.262f;
		public float zDistortion = 0.12f;
		public float frequency = 1.547f;
		public float lacunarity = 1.518f;
		public float gain = 0.734f;

		public float radius = 2000f;
		public float length = 16000f;
		public FloatCurve opacityCurve;
		public FloatCurve brightnessCurve;

		private const string FallbackShader = "Particles/Alpha Blended";

		public static void AddCometTail(PSystemBody body, CometTail tail)
		{
			if (body.orbitDriver == null)
			{
				return;
			}

			Transform scaledVersion = body.scaledVersion.transform;

			GameObject obj = new GameObject ("CometTail");
			obj.layer = GameLayers.ScaledSpace;
			obj.transform.parent = Kopernicus.Utility.Deactivator;

			var mr = obj.AddComponent<MeshRenderer> ();
			var mf = obj.AddComponent<MeshFilter> ();

			var teardrop = new Teardrop (1f, (tail.length / tail.radius), 60, 90);
			mf.mesh = teardrop;

			if (Settings.AllowAdvancedCometShader)
			{
				mr.sharedMaterial = new Material (Shaders.CometTail);

				//set default material values
				mr.sharedMaterial.SetColor ("_TintColor", new Color(tail.color.r, tail.color.g, tail.color.b, 0.5f));

				mr.sharedMaterial.SetFloat ("_RimPower", tail.rimPower);
				mr.sharedMaterial.SetFloat ("_Distortion", tail.distortion);
				mr.sharedMaterial.SetFloat ("_AlphaDistortion", tail.alphaDistortion);
				mr.sharedMaterial.SetFloat ("_ZDistortion", tail.zDistortion);
				mr.sharedMaterial.SetFloat ("_VertexDistortion", 0f);
				mr.sharedMaterial.SetFloat ("_Frequency", tail.frequency);
				mr.sharedMaterial.SetFloat ("_Lacunarity", tail.lacunarity);
				mr.sharedMaterial.SetFloat ("_Gain", tail.gain);
			}
			else
			{
				mr.sharedMaterial = new Material (Shader.Find(FallbackShader));

				//set default material values
				mr.sharedMaterial.SetColor ("_TintColor", new Color(tail.color.r, tail.color.g, tail.color.b, 0.3f));
			}

			mr.castShadows = false;
			mr.receiveShadows = false;

			var cometController = obj.AddComponent<CometTailController> ();
			cometController.targetBodyName = body.orbitDriver.referenceBody.bodyName;
			cometController.parentBodyName = body.celestialBody.bodyName;
			cometController.usingAdvancedShader = Settings.AllowAdvancedCometShader;
			cometController.type = tail.type;
			cometController.color = tail.color;
			cometController.opacityCurve = tail.opacityCurve;
			cometController.brightnessCurve = tail.brightnessCurve;

			obj.transform.parent = scaledVersion;
			obj.transform.localPosition = Vector3.zero;
			obj.transform.localScale = (Vector3.one * tail.length);
			obj.SetActive (true);
			obj.layer = GameLayers.ScaledSpace;

			//initialize comet
			cometController.Init ();
		}

	}

	public enum CometTailType
	{
		Ion,
		Dust
	}

	public class CometTailController : MonoBehaviour
	{
		private const float MaxTime = 10000;

		public CometTailType type;
		public string targetBodyName;
		public string parentBodyName;
		public Color color;

		public FloatCurve opacityCurve;
		public FloatCurve brightnessCurve;

		private Transform target;
		//private Orbit parentOrbit;
		private Quaternion rotation;
		
		private float currentTime = 0f;
		public int seed = 0;
		public float speed = 0.05f;
		public bool doAnimate = true;
		public bool usingAdvancedShader = true;

		private ImprovedPerlinNoise noise;

		public void Init()
		{
			DontDestroyOnLoad (this);

			if (usingAdvancedShader)
			{
				noise = new ImprovedPerlinNoise (seed);
				noise.LoadResourcesFor3DNoise ();
				renderer.material.SetTexture ("_PermTable2D", noise.GetPermutationTable2D ());
				renderer.material.SetTexture ("_Gradient3D", noise.GetGradient3D ());
				currentTime = 0;
				renderer.material.SetFloat ("_Evolution", currentTime);
			}
		}

		void GetTargets()
		{
			var psystemBodyTarget = Utils.GetBodies ().First (p => p != null && p.celestialBody != null && p.celestialBody.bodyName == targetBodyName);
			if (psystemBodyTarget != null)
			{
				target = psystemBodyTarget.scaledVersion.transform;
			}
			//var psystemBodyParent = Utils.GetBodies ().First (p => p != null && p.celestialBody != null && p.celestialBody.bodyName == parentBodyName);
			//if (psystemBodyParent != null)
			//{
			//	parentOrbit = psystemBodyParent.orbitDriver.orbit;
			//}
		}

		void Update()
		{
			if (HighLogic.LoadedScene != GameScenes.FLIGHT && HighLogic.LoadedScene != GameScenes.SPACECENTER && HighLogic.LoadedScene != GameScenes.TRACKSTATION)
				return;

			if (target == null/* || parentOrbit == null*/)
			{
				GetTargets ();
			}


			//if (parentOrbit == null)
			//	Debug.LogError ("parentOrbit");

			//look at target
			if (type == CometTailType.Dust)
			{
				//Vector3 orbitVector = (parentOrbit.getPositionAtUT(Planetarium.GetUniversalTime() + 1) - parentOrbit.getPositionAtUT(Planetarium.GetUniversalTime())) * 0.00001f;
				//Vector3 orbitVector = parentOrbit.vel * 0.00001f;
				//var velocity = orbitVector.magnitude;
				//Vector3 lookVector = Vector3.Normalize(orbitVector - (Vector3.Normalize(transform.position - target.position) * 0.5f));
				//var forwards = (transform.position - (transform.position + lookVector)).normalized;
				//rotation = Quaternion.LookRotation (forwards);
				transform.rotation = Quaternion.LookRotation ((target.position - transform.position).normalized);
			}
			else
			{
				transform.rotation = Quaternion.LookRotation ((target.position - transform.position).normalized);
			}
		}
		void OnPreRender()
		{
			//transform.rotation = rotation;
		}

		void LateUpdate()
		{
			if (HighLogic.LoadedScene != GameScenes.FLIGHT && HighLogic.LoadedScene != GameScenes.SPACECENTER && HighLogic.LoadedScene != GameScenes.TRACKSTATION)
				return;

			if (target != null)
			{
				//getting data
				float distance = Vector3.Distance (target.position, transform.position);
				float opacity = opacityCurve.Evaluate (distance * ScaledSpace.ScaleFactor);
				float brightness = brightnessCurve.Evaluate (distance * ScaledSpace.ScaleFactor);

				//clamping
				if (opacity < 0.0075f)
					opacity = 0f;
				if (brightness < 0.0075f)
					brightness = 0f;

				//set color
				Color calculatedColor = Color.Lerp (color, Color.white, brightness);
				calculatedColor.a = opacity;
				if (usingAdvancedShader)
				{
					renderer.material.SetColor ("_TintColor", calculatedColor);
					renderer.material.SetFloat ("_AlphaDistortion", brightness * 0.6f);

					if (doAnimate && Settings.AllowCometAnimation)
					{
						//will only speed animation up to 250x timewarp speed
						currentTime += Time.deltaTime * Mathf.Min (TimeWarp.CurrentRate, 250f) * speed;
						if (currentTime >= MaxTime)
							currentTime = 0;

						renderer.material.SetFloat ("_Evolution", currentTime);
					}
				}
				else
				{
					calculatedColor.a *= 0.4f;
					renderer.material.SetColor ("_TintColor", calculatedColor);
				}
			}
		}
	}
}

namespace KopernicusExpansion.Editors
{
	public class CometTailEditor : MonoBehaviour
	{
		Rect windowRect = new Rect (250, 200, 450, 350);
		bool windowOpen = false;
		Vector2 scroll;

		GameObject targetPlanetScaled;

		void OnGUI()
		{
			if(windowOpen)
				windowRect = GUILayout.Window ("CometTailEditor".GetHashCode (), windowRect, Window, "Comet Tail Editor");
		}
		void Update()
		{
			if (!windowOpen)
				return;

			var mapObj = PlanetariumCamera.fetch.target;
			if (mapObj.celestialBody != null &&
				mapObj.celestialBody.scaledBody != null &&
				mapObj.celestialBody.scaledBody.GetComponentsInChildren<CometTailController>().Length > 0)
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
				GUILayout.Label ("<b><color=red>No comet selected.</color></b>");
				GUI.DragWindow ();
				return;
			}

			GUILayout.Label("<b><color=orange>" + targetPlanetScaled.name + ":</color></b>");
			GUILayout.Space (20f);

			GUILayout.Label ("<b>Tails:</b>");

			scroll = GUILayout.BeginScrollView (scroll, GUILayout.MaxHeight(700f));
			foreach(var tail in targetPlanetScaled.GetComponentsInChildren<CometTailController>())
			{
				GUILayout.BeginVertical (GUI.skin.box);

				try
				{
					GUILayout.Label ("<b>Distortion:</b>");
					tail.renderer.material.SetFloat("_Distortion", slider (tail.renderer.material.GetFloat ("_Distortion"), "Distortion", 0f, 0.5f));
					tail.renderer.material.SetFloat("_ZDistortion", slider (tail.renderer.material.GetFloat ("_ZDistortion"), "Z Distortion", 0f, 1f));
					tail.renderer.material.SetFloat("_AlphaDistortion", slider (tail.renderer.material.GetFloat ("_AlphaDistortion"), "Alpha Distortion", 0f, 15f));
					tail.renderer.material.SetFloat("_VertexDistortion", slider (tail.renderer.material.GetFloat ("_VertexDistortion"), "Vertex Distortion", 0f, 0.2f));
					GUILayout.Space (8f);

					GUILayout.Label ("<b>Noise:</b>");
					tail.renderer.material.SetFloat("_Frequency", slider (tail.renderer.material.GetFloat ("_Frequency"), "Frequency", 0.01f, 50f));
					tail.renderer.material.SetFloat("_Lacunarity", slider (tail.renderer.material.GetFloat ("_Lacunarity"), "Lacunarity", 0f, 3f));
					tail.renderer.material.SetFloat("_Gain", slider (tail.renderer.material.GetFloat ("_Gain"), "Gain", 0f, 3f));
					GUILayout.Space (8f);

					GUILayout.Label ("<b>Properties:</b>");
					tail.renderer.material.SetFloat("_RimPower", slider (tail.renderer.material.GetFloat ("_RimPower"), "Rim Power", 0f, 4f));
				}
				catch
				{
					GUILayout.Label ("<color=red>ERROR!</color>");
				}

				GUILayout.EndVertical ();
			}
			GUILayout.EndScrollView ();

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