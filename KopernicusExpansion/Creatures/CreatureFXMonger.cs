using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Resources;
using KopernicusExpansion.Creatures.AI;

using UnityEngine;

namespace KopernicusExpansion.Creatures
{
	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class CreatureFXMonger : MonoBehaviour
	{
		public static void CreateCreatureExplosion(CreaturePart part)
		{
			Instance.CreateCreatureExplosion (part.creature, part);
		}

		public static CreatureFXMonger Instance { get; private set;}
		private void Awake()
		{
			Instance = this;
		}

		private void Start()
		{
			FXMonger monger = UnityEngine.Object.FindObjectOfType<FXMonger> ();
			foreach(var explosion in monger.explosions)
			{
				if (explosion.GetComponent<IgnoreCreatureExplosions> () == null)
				{
					explosion.AddComponent<IgnoreCreatureExplosions> ();
				}
			}
		}

		private void CreateCreatureExplosion(Creature creature, CreaturePart part)
		{
			IgnoreCreatureExplosions.LastWasCreature = true;

			GameObject obj = new GameObject ("CreatureExplosionFX");
			obj.transform.position = part.transform.position;

			KSPParticleEmitter particles = obj.AddComponent<KSPParticleEmitter> ();
			CreateKSPParticleEmitter (particles);

			particles.color = creature.Gore.bloodColor;
			particles.doesAnimateColor = true;
			particles.colorAnimation = new Color[5];
			particles.colorAnimation [0] = creature.Gore.bloodColor;
			particles.colorAnimation [1] = creature.Gore.bloodColor.A (0.8f);
			particles.colorAnimation [2] = creature.Gore.bloodColor.A (0.4f);
			particles.colorAnimation [3] = creature.Gore.bloodColor.A (0.2f);
			particles.colorAnimation [4] = creature.Gore.bloodColor.A (0f);

			Texture2D bloodParticleTexture = new Texture2D (4, 4);
			bloodParticleTexture.LoadImage (Textures.CreatureBloodExplosionParticle);
			particles.material.SetTexture ("_MainTex", bloodParticleTexture);

			particles.maxEmission = 1000;
			particles.maxEnergy = 1.5f;
			particles.maxParticleSize = 2.5f;
			particles.maxSize = 3.5f;
			particles.minEmission = 1000;
			particles.minEnergy = 0.5f;
			particles.minSize = 2f;

			particles.damping = 0.8f;
			particles.force = FlightGlobals.getGeeForceAtPosition (obj.transform.position) * 0.66;
			particles.rndAngularVelocity = 0f;
			particles.rndRotation = true;
			particles.rndForce = Vector3.one * 4f * creature.Gore.bloodVelocityMultiplier;
			particles.rndVelocity = Vector3.one * 8f * creature.Gore.bloodVelocityMultiplier;
			particles.shape3D = Vector3.one * creature.Gore.bloodSphereSize;

			CreatureExplosion creatureExplosion = obj.AddComponent<CreatureExplosion> ();
			creatureExplosion.particles = particles;
		}

		private void CreateKSPParticleEmitter(KSPParticleEmitter particles)
		{
			particles.angularVelocity = 0f;
			particles.castShadows = false;
			particles.color = Color.magenta;
			particles.colorAnimation = new Color[5];
			particles.damping = 1f;
			particles.doesAnimateColor = false;
			particles.emit = true;
			particles.emitterVelocityScale = 1f;
			particles.force = Vector3.zero;
			particles.lengthScale = 1f;
			particles.localRotationAxis = Vector3.up;
			particles.localVelocity = Vector3.zero;
			particles.material = new Material(Shader.Find("Particles/Alpha Blended"));
			particles.maxEmission = 250;
			particles.maxEnergy = 1f;
			particles.maxParticleSize = 1f;
			particles.maxSize = 1f;
			particles.minEmission = 0;
			particles.minEnergy = 0.1f;
			particles.minSize = 1f;
			particles.particleRenderMode = ParticleRenderMode.Billboard;
			particles.recieveShadows = false;
			particles.rndAngularVelocity = 0f;
			particles.rndForce = Vector3.one;
			particles.rndRotation = true;
			particles.rndVelocity = Vector3.one;
			particles.shape = KSPParticleEmitter.EmissionShape.Sphere;
			particles.shape1D = 1f;
			particles.shape2D = Vector2.one;
			particles.shape3D = Vector3.one;
			particles.sizeGrow = 1f;
			particles.useWorldSpace = false;
			particles.velocityScale = 1f;
			particles.worldRotationAxis = FlightGlobals.upAxis;
			particles.worldVelocity = Vector3.zero;
		}

		public class CreatureExplosion : MonoBehaviour
		{
			public KSPParticleEmitter particles;

			private void Start()
			{
				StartCoroutine (StopEmissionAfterSeconds (0.2f, particles.maxEnergy + 0.3f));
			}

			private IEnumerator<YieldInstruction> StopEmissionAfterSeconds(float secondsToEmit, float secondsToDie)
			{
				yield return new WaitForSeconds (secondsToEmit);
				particles.emit = false;
				yield return new WaitForSeconds (Mathf.Max(0f, secondsToDie - secondsToEmit));
				Destroy (gameObject);
			}
		}
		public class IgnoreCreatureExplosions : MonoBehaviour
		{
			public static bool LastWasCreature = false;


			//this appears to be unstable
			//TODO: fix creature explosions
			private void Update()
			{
				if (LastWasCreature && gameObject.activeSelf)
				{
					Utils.Log ("Removing explosion effect from Creature explosion");
					gameObject.SetActive (false);
					LastWasCreature = false;
				}
			}
		}
	}
}

