using System;
using System.Linq;
using System.Collections.Generic;

using KopernicusExpansion;
using KopernicusExpansion.Effects;
using KopernicusExpansion.Resources;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using UnityEngine;

#pragma warning disable 0414

namespace KopernicusExpansion.Configuration
{
	[ExternalParserTarget("RefractiveAtmosphere", parentNodeName = "Atmosphere")]
	public class RefractiveAtmosphereLoader : ExternalParserTargetLoader, IParserEventSubscriber
	{
		//constructor
		public RefractiveAtmosphereLoader ()
		{
			profile = new RefractiveAtmosphereProfile ();
		}

		private RefractiveAtmosphereProfile profile;

		[ParserTarget("speed", optional = true)]
		public NumericParser<float> speed
		{
			set
			{
				profile.flickerSpeed = value.value;
			}
		}

		[ParserTarget("refractionStrengthCurve", optional = false)]
		public FloatCurveParser strength
		{
			set{ profile.strengthCurve = value.curve; }
		}

		public void PostApply(ConfigNode node)
		{
			if (!Settings.AllowRefractiveAtmospheres)
			{
				Logger.Active.Log ("Not applying effect because refractive atmospheres are disallowed in the settings");
				return;
			}

			profile.bodyName = generatedBody.celestialBody.bodyName;
			RefractiveAtmosphereSpawner.Profiles.Add (profile);
		}

		//not used
		public void Apply(ConfigNode node)
		{

		}
	}
}

namespace KopernicusExpansion.Effects
{
	//TODO: make a EffectLoader system, like the one from NewKerbol
	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class RefractiveAtmosphereSpawner : MonoBehaviour
	{
		public static List<RefractiveAtmosphereProfile> Profiles = new List<RefractiveAtmosphereProfile> ();

		private GameObject prefabAtmosphere = null;
		public void CreatePrefab()
		{
			if (prefabAtmosphere == null)
			{
				prefabAtmosphere = new GameObject ("RefractiveAtmosphere");
				prefabAtmosphere.SetActive (false);
				var mf = prefabAtmosphere.AddComponent<MeshFilter> ();
				var mr = prefabAtmosphere.AddComponent<MeshRenderer> ();
				mr.castShadows = false;
				mr.receiveShadows = false;

				var material = new Material (Shaders.RefractiveAtmosphere);
				var _normals = new Texture2D (4, 4, TextureFormat.ARGB32, false);
				_normals.LoadImage (Textures.RefractiveAtmosphereNormals);
				material.SetTexture ("_BumpMap", _normals);
				material.SetTextureScale ("_BumpMap", new Vector2 (4f, 4f));
				material.SetVector ("_BumpMapOffset", new Vector4 (0, 0, 1, 0));

				mr.sharedMaterial = material;

				var sphere = GameObject.CreatePrimitive (PrimitiveType.Sphere);
				var sphereMesh = sphere.GetComponent<MeshFilter> ().mesh;
				DestroyImmediate (sphere);
				mf.sharedMesh = sphereMesh;

				var behaviour = prefabAtmosphere.AddComponent<RefractiveAtmosphere> ();

				prefabAtmosphere.transform.localScale = Vector3.one * 1250f;

				DontDestroyOnLoad (prefabAtmosphere);
			}
		}

		void Start()
		{
			if (!Settings.AllowRefractiveAtmospheres)
			{
				DestroyImmediate (this);
				return;
			}

			CreatePrefab ();
			Spawn ();
		}

		public void Spawn()
		{
			if (!HighLogic.LoadedSceneIsFlight)
				return;

			var atmosphere = (GameObject)UnityEngine.Object.Instantiate (prefabAtmosphere);
			atmosphere.name = "RefractiveAtmosphereSphere";
			var behaviour = atmosphere.GetComponent<RefractiveAtmosphere> ();
			atmosphere.transform.parent = FlightCamera.fetch.cameras[0].transform;
			atmosphere.SetActive (true);
		}

		//embedded types
		public class RefractiveAtmosphereProfile
		{
			public string bodyName = null;
			public float flickerSpeed = 10f;
			public FloatCurve strengthCurve;

			public RefractiveAtmosphereProfile()
			{

			}
		}
		public class RefractiveAtmosphere : MonoBehaviour
		{
			public RefractiveAtmosphereProfile CurrentProfile;

			private MeshRenderer meshRenderer;
			private Vector4 vector;
			void Start()
			{
				meshRenderer = GetComponent<MeshRenderer> ();
			}

			void LateUpdate()
			{
				if (!HighLogic.LoadedSceneIsFlight)
					Destroy (this);
				if (FlightGlobals.fetch == null || FlightGlobals.ActiveVessel == null)
					return;
				if (CurrentProfile == null || CurrentProfile.strengthCurve == null)
					return;

				meshRenderer.material.SetFloat ("_BumpAmt", CurrentProfile.strengthCurve.Evaluate((float)FlightGlobals.ActiveVessel.altitude - FlightGlobals.ActiveVessel.pqsAltitude));

				vector.x += Time.deltaTime * Mathf.Min(TimeWarp.CurrentRate, 75f) * CurrentProfile.flickerSpeed * 0.4f;
				vector.y += Time.deltaTime * Mathf.Min(TimeWarp.CurrentRate, 75f) * CurrentProfile.flickerSpeed;
				vector.z = 1f;
				meshRenderer.material.SetVector ("_BumpMapOffset", vector);
			}

			void Update()
			{
				if (!HighLogic.LoadedSceneIsFlight)
					Destroy (this);
				if (FlightGlobals.fetch == null || FlightGlobals.ActiveVessel == null)
					return;

				var currentBody = FlightGlobals.currentMainBody;
				var profile = RefractiveAtmosphereSpawner.Profiles.Find (p => p.bodyName == currentBody.bodyName);
				if (profile != null && CurrentProfile != profile)
				{
					CurrentProfile = profile;
				}
				else
					CurrentProfile = null;

				if (CurrentProfile == null || CurrentProfile.strengthCurve == null || CurrentProfile.strengthCurve.Evaluate ((float)FlightGlobals.ActiveVessel.altitude) < 0.01f)
					meshRenderer.enabled = false;
				else
					meshRenderer.enabled = true;
			}
		}
	}
}

#pragma warning restore 0414