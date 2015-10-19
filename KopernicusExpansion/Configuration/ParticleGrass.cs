using System;
using System.Linq;
using System.Linq.Expressions;
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
	public class ParticleGrass : ModLoader, IParserEventSubscriber
	{
		private const string ParticalMaterialShaderName = "KSP/Particles/Alpha Blended";

		//constructor
		public ParticleGrass ()
		{
			_mod = new GameObject ("ParticleGrass").AddComponent<PQSMod_ParticleGrass> ();
			_mod.transform.parent = Kopernicus.Utility.Deactivator;
			base.mod = _mod;
		}

		private PQSMod_ParticleGrass _mod;

		[ParserTarget("grassTexture", optional = false)]
		public Texture2DParser grassTexture
		{
			set
			{
				_mod.particleMaterial.SetTexture ("_MainTex", value.value);
			}
		}
		[ParserTarget("grassCastShadows", optional = true)]
		public NumericParser<bool> grassCastShadows
		{
			set
			{
				_mod.grassCastShadows = value.value;
			}
		}
		[ParserTarget("grassRecieveShadows", optional = true)]
		public NumericParser<bool> grassRecieveShadows
		{
			set
			{
				_mod.grassRecieveShadows = value.value;
			}
		}
		[ParserTarget("particleMinSize", optional = true)]
		public NumericParser<float> particleMinSize
		{
			set
			{
				_mod.particleMinSize = value.value;
			}
		}
		[ParserTarget("particleMaxSize", optional = true)]
		public NumericParser<float> particleMaxSize
		{
			set
			{
				_mod.particleMaxSize = value.value;
			}
		}
		[ParserTarget("seed", optional = true)]
		public NumericParser<uint> seed
		{
			set
			{
				_mod.seed = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{
			_mod.particleMaterial = new Material (Shader.Find (ParticalMaterialShaderName));
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
		public Material particleMaterial;
		public bool grassCastShadows = false;
		public bool grassRecieveShadows = true;
		public float particleMaxSize = 10f;
		public float particleMinSize = 5f;
		public uint seed = 1;

		public GameObject particleObj = null;
//		public ParticleEmitter pe;
//		public ParticleRenderer pr;
		public ParticleSystem system;
		public new ParticleSystemRenderer renderer;

		public override void OnSetup ()
		{
			if (particleObj != null)
				return;

			particleObj = new GameObject ("PQSMod_ParticleGrass_Emitter");
			//particleObj.transform.parent = sphere.transform;
			particleObj.transform.position = Vector3.zero;
			particleObj.layer = GameLayers.LocalSpace;
			particleObj.SetActive (false);

			if(particleObj.GetComponent<ParticleSystem>() != null)
				system = particleObj.GetComponent<ParticleSystem> ();
			else
				system = particleObj.AddComponent<ParticleSystem> ();
			if(particleObj.GetComponent<ParticleSystemRenderer>() != null)
				renderer = particleObj.GetComponent<ParticleSystemRenderer> ();
			else
				renderer = particleObj.AddComponent<ParticleSystemRenderer> ();

			system.emissionRate = 0f;
			system.enableEmission = false;
			system.gravityModifier = 0f;
			system.loop = false;
			system.maxParticles = 6000;
			system.playbackSpeed = 1f;
			system.playOnAwake = false;
			system.randomSeed = seed;
			system.simulationSpace = ParticleSystemSimulationSpace.Local;
			system.startColor = Color.white;
			system.startDelay = 0f;
			system.startLifetime = float.MaxValue;
			system.startRotation = 0f;
			system.startSize = particleMaxSize;
			system.startSpeed = 0f;
			system.time = 0f;

			renderer.cameraVelocityScale = 0f;
			renderer.lengthScale = 0f;
			renderer.maxParticleSize = 100f;
			renderer.renderMode = ParticleSystemRenderMode.Billboard;
			renderer.velocityScale = 0f;
			//TODO: make use of the mesh property and Mesh rendering mode
			renderer.sharedMaterial = particleMaterial;
			renderer.castShadows = grassCastShadows;
			renderer.receiveShadows = grassRecieveShadows;
			renderer.enabled = true;

//			pe = (ParticleEmitter)particleObj.AddComponent ("MeshParticleEmitter");
//			pr = particleObj.AddComponent<ParticleRenderer> ();
//
//			pe.angularVelocity = 0f;
//			pe.emit = true;
//			pe.emitterVelocityScale = 0f;
//			pe.localVelocity = Vector3.zero;
//			pe.maxEmission = 1f;
//			pe.maxEnergy = float.MaxValue;
//			pe.maxSize = particleMaxSize;
//			pe.minEmission = 0f;
//			pe.minEnergy = float.MaxValue;
//			pe.minSize = particleMinSize;
//			pe.rndAngularVelocity = 0f;
//			pe.rndRotation = false;
//			pe.rndVelocity = Vector3.zero;
//			pe.useWorldSpace = true;
//			pe.worldVelocity = Vector3.zero;
//
//			pr.enabled = true;
//			pr.castShadows = grassCastShadows;
//			pr.receiveShadows = grassRecieveShadows;
//			pr.sharedMaterial = particleMaterial;
//			pr.cameraVelocityScale = 1f;
//			pr.lengthScale = 0f;
//			pr.maxParticleSize = 1000f;
//			pr.maxPartileSize = 1000f;
//			pr.particleRenderMode = ParticleRenderMode.Billboard;
//			pr.velocityScale = 0f;
		}

		public override void OnSphereActive ()
		{
			particleObj.SetActive (true);
		}
		public override void OnSphereInactive ()
		{
			particleObj.SetActive (false);

			system.Clear ();
			//pe.ClearParticles ();
			particleParents.Clear ();
		}

		private Dictionary<ParticleSystem.Particle, PQ> particleParents = new Dictionary<ParticleSystem.Particle, PQ> ();
		//private Dictionary<Particle, PQ> particleParents = new Dictionary<Particle, PQ> ();

		private bool isSpawningParticles = false;
		private PQ currentQuad;
		private List<ParticleSystem.Particle> newParticles = new List<ParticleSystem.Particle> ();
		//private ParticleSystem.Particle[] outputParticles;
		private List<ParticleSystem.Particle> particles = new List<ParticleSystem.Particle>();
		//private List<Particle> newParticles = new List<Particle> ();

		public override void OnQuadPreBuild (PQ quad)
		{
			currentQuad = quad;

			if (currentQuad.isVisible && currentQuad.subdivision >= sphere.maxLevel)
			{
				Debug.Log ("Spawning particles...");
				isSpawningParticles = true;
				newParticles.Clear ();
			}
		}
		public override void OnVertexBuild (PQS.VertexBuildData data)
		{
			if (!isSpawningParticles)
				return;
			if (currentQuad == null)
				return;
			if (currentQuad.subdivision < sphere.maxLevel)
				return;

			var particle = new ParticleSystem.Particle ();
			//var particle = new Particle ();

			//position
			//var vert1 = (Vector3)(data.directionFromCenter * (data.vertHeight + sphere.radius));
			//var vert2 = currentQuad.sphereRoot.transform.TransformPoint (vert1);
			//particle.position = currentQuad.transform.InverseTransformPoint (vert2);
			particle.position = data.directionFromCenter.normalized * 100f;



			//other data
			particle.angularVelocity = 0f;
			particle.color = data.vertColor;
			//particle.energy = float.MaxValue;
			particle.lifetime = float.MaxValue;
			//particle.rotation = 0f;
			particle.size = UnityEngine.Random.Range (particleMinSize, particleMaxSize);
			//particle.startEnergy = 0f;
			particle.startLifetime = 0f;
			particle.velocity = Vector3.zero;

			particle.axisOfRotation = data.directionFromCenter.normalized;
			particle.rotation = UnityEngine.Random.Range(0f, 360f);

			newParticles.Add (particle);
			particleParents.Add (particle, currentQuad);
		}
		public override void OnQuadBuilt (PQ quad)
		{
			if (isSpawningParticles)
			{
				//var particles = pe.particles;
				//system.GetParticles (outputParticles);
				//particles.ToList ().AddRange (newParticles);
				//pe.particles = particles;

				particles.AddRange (newParticles);
				system.SetParticles (particles.ToArray(), particles.Count);
				Debug.Log ("Particles spawned: " + newParticles.Count + " : " + particles.Count);

				isSpawningParticles = false;
			}
		}
		public override void OnQuadDestroy (PQ quad)
		{
			//remove particles
			var toRemove = particleParents.Where (kvp => kvp.Value == quad).Select(kvp => kvp.Key).ToArray();

			//var particles = pe.particles;
			//system.GetParticles (outputParticles);
			//particles.ToList ().RemoveAll (p => toRemove.Contains (p));

			particles.RemoveAll (p => toRemove.Contains (p));
			system.SetParticles (particles.ToArray(), particles.Count);
			//pe.particles = particles;

			particleParents.ToList ().RemoveAll (kvp => toRemove.Contains (kvp.Key));

			//TODO: fix this monstrosity
		}
	}
}

