using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;

using KopernicusExpansion.Utility.Noise;

namespace KopernicusExpansion
{
	[AddComponentMenu("KopernicusExpansion/Particle Grass/Spawner")]
	public class ParticleGrassSpawner : MonoBehaviour
	{
		public const float MAX_EVOLUTION = 10000f;

		public int GrassPlaneXSize = 16;
		public int GrassPlaneZSize = 16;
		public float GrassSpacing = 1f;
		public float GrassRandomSpacing = 0.85f;
		public float GrassVerticalPos = 0.33f;

		public float MaxGrassSize = 2f;
		public float MinGrassSize = 1f;
		public int Seed = 0;

		public Material GrassMaterial;
		public Color32 GrassColor1;
		public Color32 GrassColor2;

		public bool UseMesh = false;
		public Mesh GrassMesh;

		public float WindTimeScale = 1f;

		[SerializeField]
		private ParticleSystem psystem;
		public bool ShowParticleSystem = false;
		[SerializeField]
		private ParticleSystemRenderer prenderer;
		[SerializeField]
		private float currentTime;

		private void LateUpdate()
		{
			if(GrassMaterial == null)
			{
				return;
			}

			currentTime += Time.deltaTime * WindTimeScale;
			if (currentTime > MAX_EVOLUTION)
			{
				currentTime = 0f;
			}
			GrassMaterial.SetFloat ("_Evolution", currentTime);
		}

		private void Start()
		{
			SpawnParticles ();
		}
		private void OnValidate()
		{
			if(ShowParticleSystem)
			{
				psystem.hideFlags = HideFlags.None;
			}
			else
			{
				psystem.hideFlags = HideFlags.HideInInspector | HideFlags.NotEditable;
			}
		}

		[ContextMenu("Spawn Particles")]
		public void SpawnParticles()
		{
			if (psystem == null)
			{
				psystem = GetComponent<ParticleSystem> ();
				if(psystem == null)
				{
					psystem = gameObject.AddComponent<ParticleSystem> ();
				}
			}
			if (prenderer == null)
			{
				prenderer = GetComponent<ParticleSystemRenderer> ();
			}

			psystem.Clear ();

			psystem.emissionRate = 0f;
			psystem.enableEmission = false;
			psystem.gravityModifier = 0f;
			psystem.loop = false;
			psystem.maxParticles = 500;
			psystem.playbackSpeed = 0f;
			psystem.playOnAwake = false;
			psystem.randomSeed = (uint)Seed;
			psystem.simulationSpace = ParticleSystemSimulationSpace.Local;

			prenderer.maxParticleSize = MaxGrassSize;
			if(UseMesh && GrassMesh != null)
			{
				prenderer.renderMode = ParticleSystemRenderMode.Mesh;
				prenderer.mesh = GrassMesh;
			}
			else
			{
				prenderer.renderMode = ParticleSystemRenderMode.VerticalBillboard;
			}
			prenderer.shadowCastingMode = UnityEngine.Rendering.ShadowCastingMode.Off;
			prenderer.receiveShadows = true;
			prenderer.sharedMaterial = GrassMaterial;
			//TODO: try out MaterialPropertyBlocks
			//TODO: use MaterialPropertBlocks to set the per-particle vertex scale on the XZ plane
			//TODO: have different materials with different shader keywords for far-away grass that needs a lower quality
			//TODO: use MaterialPropertBlocks to set per-particle textures so different particles can have different textures

			List<ParticleSystem.Particle> particles = new List<ParticleSystem.Particle> ();
			float gpx2 = ((float)GrassPlaneXSize / 2f);
			float gpz2 = ((float)GrassPlaneZSize / 2f);
			UnityEngine.Random.seed = Seed;
			for(int x = 0; x < GrassPlaneXSize; x++)
			{
				for(int z = 0; z < GrassPlaneZSize; z++)
				{
					var particle = new ParticleSystem.Particle ();
					particle.angularVelocity = 0f;
					particle.axisOfRotation = Vector3.up;
					particle.color = Color32.Lerp (GrassColor1, GrassColor2, UnityEngine.Random.Range (0f, 1f));
					particle.lifetime = float.MaxValue;
					particle.size = UnityEngine.Random.Range (MinGrassSize, MaxGrassSize);
					Vector3 randomAdd = new Vector3 (UnityEngine.Random.Range (-GrassRandomSpacing, GrassRandomSpacing), GrassVerticalPos * particle.size, UnityEngine.Random.Range (-GrassRandomSpacing, GrassRandomSpacing));
					particle.position = (new Vector3 ((float)x - gpx2, 0f, (float)z - gpz2) * GrassSpacing) + randomAdd;
					if (UseMesh) 
					{
						particle.rotation = UnityEngine.Random.Range (0f, 360f);
					}
					else
					{
						particle.rotation = 0f;
					}
					particle.startLifetime = 0f;
					particle.velocity = Vector3.zero;
					particles.Add (particle);
				}
			}

			psystem.SetParticles (particles.ToArray (), particles.Count);

			ImprovedPerlinNoise noise = new ImprovedPerlinNoise (Seed);
			noise.LoadResourcesFor3DNoise ();
			GrassMaterial.SetTexture ("_PermTable2D", noise.GetPermutationTable2D ());
			GrassMaterial.SetTexture ("_Gradient3D", noise.GetGradient3D ());
			currentTime = 0f;
			GrassMaterial.SetFloat ("_Evolution", currentTime);
		}
	}
}
			
