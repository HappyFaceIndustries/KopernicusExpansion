using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Resources;
using KopernicusExpansion.Configuration;
using KopernicusExpansion.Utility.Geometry;

using UnityEngine;

namespace KopernicusExpansion.Configuration
{
	[RequireConfigType(ConfigType.Node)]
	public class ParticleGrass : ModLoader<PQSMod_ParticleGrass>, IParserEventSubscriber
	{
		public override void Create ()
		{
			base.Create ();

			mod.GrassTexture = Texture2D.whiteTexture;
		}

		[ParserTarget("grassTexture", optional = false)]
		private Texture2DParser GrassTexture
		{
			set
			{
				mod.GrassTexture = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{

		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_ParticleGrass : PQSMod
	{
		public uint GrassSeed = 0;
		public Texture2D GrassTexture;
		public float GrassSizeMin = 200f;
		public float GrassSizeMax = 260f;
		public float GrassDensity = 3f;

		protected ObjectPool ParticleEmitterPool;

		public override void OnSetup ()
		{
			GameObject poolObj = new GameObject ("ParticleEmitterPool");
			poolObj.transform.parent = sphere.transform.parent;
			poolObj.transform.localPosition = Vector3.zero;

			ParticleEmitterPool = poolObj.AddComponent<ObjectPool> ();
			ParticleEmitterPool.SetCanGrow (true);
			ParticleEmitterPool.SetPoolName ("ParticleGrassObject");
			ParticleEmitterPool.SetSize (100);

			GameObject prefab = new GameObject ("ParticleGrass");
			var psystem = prefab.AddComponent<ParticleSystem> ();
			var prenderer = prefab.GetComponent<ParticleSystemRenderer> (); //auto-added by addind system

			//TODO: set up particlesystem(renderer)
			psystem.emissionRate = 0f;
			psystem.enableEmission = false;
			psystem.gravityModifier = 0f;
			psystem.loop = false;
			psystem.maxParticles = (int)(100f * GrassDensity);
			psystem.playbackSpeed = 0f;
			psystem.playOnAwake = false;
			psystem.randomSeed = GrassSeed;
			psystem.simulationSpace = ParticleSystemSimulationSpace.Local;

			prenderer.maxParticleSize = GrassSizeMax;
			prenderer.renderMode = ParticleSystemRenderMode.VerticalBillboard;
			prenderer.castShadows = true;
			prenderer.receiveShadows = true;
			prenderer.sharedMaterial = new Material (Shader.Find ("Particles/Alpha Blended"));
			prenderer.sharedMaterial.SetTexture ("_MainTex", GrassTexture);

			ParticleEmitterPool.SetPrefab (prefab);
			ParticleEmitterPool.Initialize ();
		}

		List<ParticleSystem.Particle> particles = new List<ParticleSystem.Particle> ();
		public override void OnQuadBuilt (PQ quad)
		{
			//add a particlegrass object from the pool
			var particleObj = ParticleEmitterPool.GetObject ();
			particleObj.name = "ParticleGrassEmitterObject";
			particleObj.transform.parent = quad.transform;
			particleObj.transform.localPosition = Vector3.zero;
			particleObj.transform.localRotation = Quaternion.identity;

			particleObj.SetActive (true);
			particleObj.renderer.enabled = true;

			var psystem = particleObj.GetComponent<ParticleSystem> ();
			var verts = quad.mesh.vertices;
			var colors = quad.mesh.colors;
			particles.Clear ();
			for (int i = 0; i < verts.Length; i++)
			{
				var p = new ParticleSystem.Particle ();
				p.angularVelocity = 0f;
				p.axisOfRotation = Vector3.up;
				p.color = colors [i];
				p.lifetime = float.MaxValue;
				p.position = verts [i];
				p.rotation = 0f;
				p.size = UnityEngine.Random.Range (GrassSizeMin, GrassSizeMax);
				p.startLifetime = 0f;
				p.velocity = Vector3.zero;
				particles.Add (p);
			}

			psystem.SetParticles (particles.ToArray (), particles.Count);

			Debug.Log ("Added Particles!");
		}

		public override void OnQuadDestroy (PQ quad)
		{
			//remove particlegrass objects, and cycle it back into the pool
			foreach (Transform trns in quad.transform)
			{
				if (ParticleEmitterPool.ContainsObject (trns.gameObject))
				{
					var psystem = trns.GetComponent<ParticleSystem> ();
					psystem.Clear ();
					ParticleEmitterPool.DisableObject (trns.gameObject);
				}
			}

			Debug.Log ("Removed Particles!");
		}
	}
}

