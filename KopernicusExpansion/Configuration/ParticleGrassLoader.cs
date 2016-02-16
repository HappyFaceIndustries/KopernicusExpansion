//using System;
//using System.Linq;
//using System.Reflection;
//using System.Collections.Generic;
//
//using Kopernicus;
//using Kopernicus.Constants;
//using Kopernicus.Configuration;
//using Kopernicus.Configuration.ModLoader;
//
//using KopernicusExpansion.Effects;
//using KopernicusExpansion.Utility;
//using KopernicusExpansion.Resources;
//using KopernicusExpansion.Configuration;
//using KopernicusExpansion.Utility.Geometry;
//
//using UnityEngine;
//
//namespace KopernicusExpansion.Configuration
//{
//	[RequireConfigType(ConfigType.Node)]
//	public class ParticleGrass : ModLoader<PQSMod_ParticleGrass>, IParserEventSubscriber
//	{
//		public override void Create ()
//		{
//			base.Create ();
//
//			mod.GrassTexture = Texture2D.whiteTexture;
//		}
//
//		[ParserTarget("grassTexture", optional = false)]
//		private Texture2DParser GrassTexture
//		{
//			set
//			{
//				mod.GrassTexture = value.value;
//			}
//		}
//
//		public void Apply(ConfigNode node)
//		{
//
//		}
//		public void PostApply(ConfigNode node)
//		{
//
//		}
//	}
//}
//
//namespace KopernicusExpansion.Effects
//{
//	public class PQSMod_ParticleGrass : PQSMod
//	{
//		public uint GrassSeed = 0;
//		public Texture2D GrassTexture;
//		public float GrassSizeMin = 100f;
//		public float GrassSizeMax = 200f;
//		public float GrassDensity = 0.35f;
//		public float GrassRandomness = 2f;
//
//		protected ObjectPool ParticleEmitterPool;
//
//		public override void OnSetup ()
//		{
//			GameObject poolObj = new GameObject ("ParticleEmitterPool");
//			poolObj.transform.parent = sphere.transform.parent;
//			poolObj.transform.localPosition = Vector3.zero;
//
//			ParticleEmitterPool = poolObj.AddComponent<ObjectPool> ();
//			ParticleEmitterPool.SetCanGrow (true);
//			ParticleEmitterPool.SetPoolName ("ParticleGrassObject");
//			ParticleEmitterPool.SetSize (200);
//
//			GameObject prefab = new GameObject ("ParticleGrass");
//			var psystem = prefab.AddComponent<ParticleSystem> ();
//			var prenderer = prefab.GetComponent<ParticleSystemRenderer> (); //auto-added by adding system
//			prefab.AddComponent<DisableFrustumCulling> ();
//			Mesh mesh = ObjImporter.ImportFile (KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansionExamples/Data/GrassMesh.obj");
//
//			//TODO: set up particlesystem(renderer)
//			psystem.emissionRate = 0f;
//			psystem.enableEmission = false;
//			psystem.gravityModifier = 0f;
//			psystem.loop = false;
//			psystem.maxParticles = 200;
//			psystem.playbackSpeed = 0f;
//			psystem.playOnAwake = false;
//			psystem.randomSeed = GrassSeed;
//			psystem.simulationSpace = ParticleSystemSimulationSpace.Local;
//
//			prenderer.maxParticleSize = GrassSizeMax;
//			prenderer.renderMode = ParticleSystemRenderMode.Mesh;
//			prenderer.mesh = mesh;
//			prenderer.castShadows = true;
//			prenderer.receiveShadows = true;
//			prenderer.sharedMaterial = new Material (Shader.Find ("KSP/Particles/Alpha Blended"));
//			prenderer.sharedMaterial.SetTexture ("_MainTex", GrassTexture);
//
//			ParticleEmitterPool.SetPrefab (prefab);
//			ParticleEmitterPool.Initialize ();
//		}
//
//		List<ParticleSystem.Particle> particles = new List<ParticleSystem.Particle> ();
//		public override void OnQuadBuilt (PQ quad)
//		{
//			//add a particlegrass object from the pool
//			var particleObj = ParticleEmitterPool.GetObject ();
//			particleObj.name = "ParticleGrassEmitterObject";
//			particleObj.layer = quad.gameObject.layer;
//			particleObj.transform.parent = quad.transform;
//			particleObj.transform.localPosition = Vector3.zero;
//			particleObj.transform.localRotation = Quaternion.identity;
//
//			particleObj.SetActive (true);
//			particleObj.renderer.enabled = true;
//
//			var psystem = particleObj.GetComponent<ParticleSystem> ();
//			var verts = quad.mesh.vertices;
//			var colors = quad.mesh.colors;
//			particles.Clear ();
//			for (int i = 0; i < verts.Length; i++)
//			{
//				var rand = UnityEngine.Random.Range (0f, 1f);
//				if (rand > GrassDensity)
//					continue;
//
//				var p = new ParticleSystem.Particle ();
//				p.angularVelocity = 0f;
//				p.color = Color.green;
//				p.lifetime = float.MaxValue;
//				p.size = UnityEngine.Random.Range (GrassSizeMin, GrassSizeMax);
//				p.position = verts [i] + new Vector3(UnityEngine.Random.Range (-GrassRandomness, GrassRandomness), 0.45f * p.size, UnityEngine.Random.Range (-GrassRandomness, GrassRandomness));
//				p.rotation = 0f;
//				p.startLifetime = 0f;
//				p.velocity = Vector3.zero;
//				particles.Add (p);
//			}
//
//			Debug.Log ("Spawned Particles!");
//
//			psystem.SetParticles (particles.ToArray (), particles.Count);
//		}
//
//		public override void OnQuadDestroy (PQ quad)
//		{
//			//remove particlegrass objects, and cycle it back into the pool
//			foreach (Transform trns in quad.transform)
//			{
//				if (ParticleEmitterPool.ContainsObject (trns.gameObject))
//				{
//					var psystem = trns.GetComponent<ParticleSystem> ();
//					psystem.Clear ();
//					ParticleEmitterPool.DisableObject (trns.gameObject);
//				}
//			}
//		}
//	}
//
//	public class DisableFrustumCulling : MonoBehaviour
//	{
//		public static bool Enabled = false;
//
//		private new Renderer renderer;
//
//		private void Start()
//		{
//			renderer = GetComponent<Renderer> ();
//		}
//		private void OnRenderObject()
//		{
//			if (Enabled && renderer != null && renderer.material != null && !renderer.isVisible)
//			{
//				renderer.material.SetPass (0);
//				renderer.Render (0);
//			}
//		}
//	}
//}
