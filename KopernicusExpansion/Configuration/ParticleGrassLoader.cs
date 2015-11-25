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
	public class ParticleGrassLoader : ModLoader<PQSMod_ParticleGrass>, IParserEventSubscriber
	{
		public override void Create ()
		{
			base.Create ();

		}


	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_ParticleGrass : PQSMod
	{
		public ObjectPool ParticleEmitterPool;

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
			var prenderer = prefab.AddComponent<ParticleSystemRenderer> ();

			//TODO: set up particlesystem(renderer)

			ParticleEmitterPool.SetPrefab (prefab);
		}

		public override void OnQuadBuilt (PQ quad)
		{
			//add a particlegrass object from the pool
			var particleObj = ParticleEmitterPool.GetObject ();
			particleObj.name = "ParticleGrassEmitterObject";
			//TODO: reinit particle stuff
			particleObj.transform.parent = quad.transform;
			particleObj.transform.localPosition = Vector3.zero;
			particleObj.transform.localRotation = Quaternion.identity;
		}

		public override void OnQuadDestroy (PQ quad)
		{
			//remove particlegrass objects, and cycle it back into the pool
			foreach (Transform trns in quad.transform)
			{
				if (ParticleEmitterPool.ContainsObject (trns.gameObject))
					ParticleEmitterPool.DisableObject (trns.gameObject);
			}
		}
	}
}

