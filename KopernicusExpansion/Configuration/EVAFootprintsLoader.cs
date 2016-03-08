using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Resources;
using KopernicusExpansion.Configuration;
using KopernicusExpansion.Utility.Geometry;

using UnityEngine;

namespace KopernicusExpansion.Configuration
{
	[ExternalParserTarget("EVAFootprints", parentNodeName = "PQS")]
	public class KerbalEVAFootprints : ExternalParserTargetLoader, IParserEventSubscriber
	{
		public KerbalEVAFootprints ()
		{

		}

		public void Apply(ConfigNode node)
		{
			KerbalEVAFootprintSpawner.FootprintsAllowed.Add (generatedBody.celestialBody);
		}
		public void PostApply(ConfigNode node)
		{
			var obj = new GameObject ("FootprintRemover");
			obj.transform.parent = Kopernicus.Utility.Deactivator;

			var mod = obj.AddComponent<PQSMod_FootprintRemover> ();
			obj.transform.parent = generatedBody.pqsVersion.transform;
			mod.sphere = generatedBody.pqsVersion;
			mod.modEnabled = true;
			mod.order = 0;
			obj.gameObject.layer = generatedBody.pqsVersion.gameObject.layer;
		}
	}
}

namespace KopernicusExpansion.Effects
{
	//TODO: use ObjectPool for footprints

	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class KerbalEVAFootprintSpawner : MonoBehaviour
	{
		public static List<CelestialBody> FootprintsAllowed = new List<CelestialBody> ();

		public static GameObject footprintPrefab
		{ get; private set; }
		private static void SetupFootprintPrefab()
		{
			footprintPrefab = new GameObject ("KerbalEVAFootprint");
			footprintPrefab.layer = GameLayers.LocalSpace;
			footprintPrefab.SetActive (false);

			var mf = footprintPrefab.AddComponent<MeshFilter> ();
			var mr = footprintPrefab.AddComponent<MeshRenderer> ();

			mf.mesh = new Quad (0.15f, 0.3f, true);

			var material = new Material (Shaders.Footprint);
			var footprintMask = new Texture2D (4, 4);
			footprintMask.LoadImage (Textures.KerbalEVAFootprintMask);
			material.SetTexture ("_MainTex", footprintMask);
			material.SetFloat ("_Opacity", 0.8f);
			material.SetColor ("_Color", Color.black);
			mr.material = material;
			mr.castShadows = false;

			footprintPrefab.AddComponent<KerbalEVAFootprint> ();

			Utils.Log ("Footprint prefab created");
		}
		public static int TotalFootprints
		{
			get
			{
				if (footprints == null)
					return 0;
				return footprints.Count;
			}
		}
		private static Queue<KerbalEVAFootprint> footprints;
		public static void AddFootprint(KerbalEVAFootprint footprint)
		{
			if (Settings.MaximumFootprints < 4)
				return;

			if (TotalFootprints >= Settings.MaximumFootprints && TotalFootprints > 0)
			{
				var footprintToDie = footprints.Dequeue ();
				footprintToDie.DestroyFootprint ();
			}

			if (footprints != null)
				footprints.Enqueue (footprint);
			else
				Utils.LogError ("Footprints queue is null");
		}

		private void Start()
		{
			if (!Settings.AllowFootprints)
			{
				DestroyImmediate (this);
				return;
			}

			if (footprintPrefab == null)
			{
				SetupFootprintPrefab ();
			}

			footprints = new Queue<KerbalEVAFootprint> (Settings.MaximumFootprints);

			GameEvents.onPartUnpack.Add (AddFootprinter);
			GameEvents.onCrewOnEva.Add (OnCrewOnEVA);
		}
		private void OnDestroy()
		{
			GameEvents.onPartUnpack.Remove (AddFootprinter);
			GameEvents.onCrewOnEva.Remove (OnCrewOnEVA);
		}

		private void OnCrewOnEVA(GameEvents.FromToAction<Part, Part> fromto)
		{
			AddFootprinter (fromto.to);
		}
		private void AddFootprinter (Part part)
		{
			if (part.GetComponent<KerbalEVA>() != null)
			{
				var footprinter = part.gameObject.AddComponent<KerbalEVAFootprinter> ();
				footprinter.eva = part.GetComponent<KerbalEVA> ();
				footprinter.part = part;

				Utils.Log ("Footprinter added to " + part.name + " of vessel " + part.vessel.vesselName);
			}
		}


		//embeded types
		#region embedded types
		public class KerbalEVAFootprinter : MonoBehaviour
		{
			public KerbalEVA eva;
			public Part part;

			private static readonly string[] WalkingStates = new string[]{
				"Walk (Arcade)",
				"Walk (FPS)",
			};
			private static readonly string[] RunningStates = new string[]{
				"Run (Arcade)",
				"Run (FPS)"
			};
			private static readonly string[] BoundingStates = new string[]{
				"Low G Bound (Grounded - Arcade)",
				"Low G Bound (Grounded - FPS)"
			};

			private void Start()
			{
				StartCoroutine (UpdateCoroutine ());
			}
			private IEnumerator<YieldInstruction> UpdateCoroutine()
			{
				while (true)
				{
					//don't footprint non-footprintable bodies
					if (!FootprintsAllowed.Contains (FlightGlobals.currentMainBody))
						yield return null;

					var state = eva.fsm.CurrentState.name;

					if (WalkingStates.Contains (state))
					{
						SpawnFootprint ();
						leftOrRight *= -1f;
						yield return new WaitForSeconds (0.4f);
					}
					else if(RunningStates.Contains(state))
					{
						SpawnFootprint ();
						leftOrRight *= -1f;
						yield return new WaitForSeconds (0.15f);
					}
					else if (BoundingStates.Contains (state))
					{
						SpawnFootprint ();
						leftOrRight *= -1f;
						yield return new WaitForSeconds (0.4f);
					}

					yield return null;
				}
			}

			private float leftOrRight = 1f;

			private void SpawnFootprint()
			{
				RaycastHit hit;
				Ray ray = new Ray (transform.position, FlightGlobals.getGeeForceAtPosition (part.vessel.GetWorldPos3D ()).normalized);
				if (Physics.Raycast (ray, out  hit, 0.25f, (1 << GameLayers.LocalSpace)))
				{
					//don't add footprints to non-terrain features
					if (hit.transform.GetComponent<PQ> () == null)
						return;

					var obj = (GameObject)Instantiate (KerbalEVAFootprintSpawner.footprintPrefab);
					obj.SetActive (true);

					var hitNormal = hit.normal;
					var right = transform.right;
					var cross = Vector3.Cross (right, hitNormal);

					obj.transform.position = hit.point + (hitNormal * 0.015f);
					obj.transform.rotation = Quaternion.LookRotation (cross, hitNormal); //vector math is fun :D
					obj.transform.Translate (Vector3.right * 0.1f * leftOrRight);
					obj.transform.localScale = new Vector3 (leftOrRight, 1f, 1f);

					//parent to PQS so that we can avoid the Krakensbane/FloatingOrigin
					obj.transform.parent = obj.transform;
				}
			}
		}

		public class KerbalEVAFootprint : MonoBehaviour
		{
			public float FadeTime = 2f;

			private void Start()
			{
				KerbalEVAFootprintSpawner.AddFootprint (this);
			}

			public void DestroyFootprint()
			{
				StartCoroutine (DestructionRoutine ());
			}
			private IEnumerator<YieldInstruction> DestructionRoutine()
			{
				if (FadeTime <= 0f)
				{
					Destroy (gameObject);
					yield break;
				}

				float startingOpacity = renderer.material.GetFloat ("_Opacity");
				float time = FadeTime;
				while (time > 0f)
				{
					time -= Time.deltaTime;
					renderer.material.SetFloat ("_Opacity", (time / FadeTime) * startingOpacity);

					yield return null;
				}

				Destroy (gameObject);
			}

			private void OnLevelWasLoaded(int level)
			{
				Destroy (gameObject);
			}
		}
		#endregion
	}

	//a PQSMod to remove all footprints when the quad is recycled
	public class PQSMod_FootprintRemover : PQSMod
	{
		public override void OnQuadDestroy (PQ quad)
		{
			foreach(var footprint in quad.GetComponentsInChildren<KerbalEVAFootprintSpawner.KerbalEVAFootprint>(true))
			{
				Destroy (footprint.gameObject);
			}
		}
	}
}

