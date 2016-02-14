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
		public float GrassSizeMin = 1f;
		public float GrassSizeMax = 1f;
		public float GrassDensity = 2f;

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
			var psystem = (ParticleEmitter)prefab.AddComponent ("MeshParticleEmitter");
			var psrenderer = prefab.AddComponent<ParticleRenderer> ();

			psystem.angularVelocity = 0f;
			psystem.emit = false;
			psystem.emitterVelocityScale = 0f;
			psystem.enabled = true;
			psystem.localVelocity = Vector3.zero;
			psystem.maxEmission = 0f;
			psystem.maxEnergy = float.MaxValue;
			psystem.maxSize = GrassSizeMax;
			psystem.minEmission = 0f;
			psystem.minEnergy = 0f;
			psystem.minSize = GrassSizeMin;
			psystem.rndAngularVelocity = 0f;
			psystem.rndRotation = false;
			psystem.rndVelocity = Vector3.zero;
			psystem.useWorldSpace = false;

			psrenderer.cameraVelocityScale = 1f;
			psrenderer.lengthScale = 1f;
			psrenderer.maxParticleSize = GrassSizeMax;
			//psrenderer.maxPartileSize = GrassSizeMax;
			psrenderer.particleRenderMode = ParticleRenderMode.Billboard;
			psrenderer.velocityScale = 1f;
			psrenderer.castShadows = true;
			psrenderer.receiveShadows = true;
			psrenderer.sharedMaterial = new Material (Shader.Find ("Particles/Alpha Blended"));
			psrenderer.sharedMaterial.SetTexture ("_MainTex", GrassTexture);

			ParticleEmitterPool.SetPrefab (prefab);
			ParticleEmitterPool.Initialize ();
		}

		List<Particle> particles = new List<Particle> ();
		public override void OnQuadBuilt (PQ quad)
		{
			if (!quad.isVisible || quad.subdivision < 3)
				return;

			//add a particlegrass object from the pool
			var particleObj = ParticleEmitterPool.GetObject ();
			particleObj.name = "ParticleGrassEmitterObject";
			particleObj.transform.parent = quad.transform;
			particleObj.transform.localPosition = Vector3.zero;
			particleObj.transform.localRotation = Quaternion.identity;

			particleObj.SetActive (true);
			particleObj.renderer.enabled = true;

			var psystem = particleObj.GetComponent<ParticleEmitter> ();
			var verts = quad.mesh.vertices;
			var colors = quad.mesh.colors;
			particles.Clear ();
			for (int i = 0; i < verts.Length; i++)
			{
				var p = new Particle ();
				p.angularVelocity = 0f;
				p.energy = float.MaxValue;
				p.color = colors [i];
				p.position = verts [i];// + new Vector3 (UnityEngine.Random.Range (-GrassDensity, GrassDensity), 0f, UnityEngine.Random.Range (-GrassDensity, GrassDensity));
				p.rotation = 0f;
				p.size = UnityEngine.Random.Range (GrassSizeMin, GrassSizeMax);
				p.startEnergy = float.MaxValue;
				p.velocity = Vector3.zero;
				particles.Add (p);
			}

			psystem.particles = particles.ToArray ();

			Debug.Log ("Added Particles!");
		}

		public override void OnQuadDestroy (PQ quad)
		{
			//remove particlegrass objects, and cycle it back into the pool
			foreach (Transform trns in quad.transform)
			{
				if (ParticleEmitterPool.ContainsObject (trns.gameObject))
				{
					var psystem = trns.GetComponent<ParticleEmitter> ();
					psystem.ClearParticles ();
					ParticleEmitterPool.DisableObject (trns.gameObject);
				}
			}

			Debug.Log ("Removed Particles!");
		}
	}
}

