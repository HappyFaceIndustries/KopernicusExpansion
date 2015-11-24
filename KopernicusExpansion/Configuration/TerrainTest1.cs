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
using KopernicusExpansion.Configuration;
using KopernicusExpansion.Utility.Geometry;

using UnityEngine;

namespace KopernicusExpansion.Configuration
{
	public class TerrainTest1 : ModLoader<PQSMod_TerrainTest1>, IParserEventSubscriber
	{
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
	public class PQSMod_TerrainTest1 : PQSMod
	{
		public override void OnSetup ()
		{

		}

		public override void OnQuadBuilt (PQ quad)
		{
			//if (quad.meshCollider != null)
				//Destroy (quad.meshCollider);
			if(quad.meshRenderer != null)
				quad.meshRenderer.enabled = false;

			//NOTE: it is very difficult to disable terrain collision :(


		}

		/**   PQS Collision Info
		 * 
		 * Parts only have a CollisionEnhancer, PQS_Colliders, etc., aren't used
		 * 
		 * Non-collider based terrain collision lies in Vessel class's FixedUpdate function
		 * for collision, Vessel uses raycast-based HeightFromTerrain when landed, and PQS-based PQSAltitude otherwise
		 * fixing the PQSAltitude issue is easy enough, just make vertHeight 0 when data.buildQuad is null (would only affect altitude stuff)
		 * Hopefully, the HeightFromTerrain will fix itself because it is raycast based
		 * 		:P
		 **/

		/**   Voxel Information
		 * 
		 * it would suffice to disable mesh renderer, and remove the PQSMod_QuadMeshCollider mod
		 * Then, I could just substitute my own mesh in a child object
		 * 
		 **/

		public override void OnVertexBuildHeight (PQS.VertexBuildData data)
		{
			if (data.buildQuad == null)
				data.vertHeight = 0;
		}
	}

	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class TerrainTestDebugging : MonoBehaviour
	{
		void Update()
		{
			bool isModDown = GameSettings.MODIFIER_KEY.GetKey ();

			if (isModDown && Input.GetKeyDown (KeyCode.Space))
			{
				Utils.Log ("Force activating active vessel...");

				var vessel = FlightGlobals.ActiveVessel;

				vessel.Landed = false;
				vessel.packed = false;
				vessel.MakeActive ();
				vessel.situation = Vessel.Situations.FLYING;
				vessel.state = Vessel.State.ACTIVE;

				foreach (var part in vessel.parts)
				{
					if(part.packed)
						part.Unpack ();
					if(part.State != PartStates.ACTIVE)
						part.force_activate ();
				}
			}
		}
	}
}

