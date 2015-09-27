using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Creatures.AI;

using UnityEngine;

namespace KopernicusExpansion.Creatures
{
	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class CreatureSpawning : MonoBehaviour
	{
		void Update()
		{
			if (Input.GetKey (KeyCode.LeftAlt) && Input.GetKeyDown (KeyCode.B))
			{
				SpawnCreature (FlightGlobals.upAxis.normalized * 18, CreatureLoader.LoadedCreatures[0]);
			}
		}

		private void SpawnCreature(Vector3 position, Creature creature)
		{
			//spawn in creature vessel
			var vessel = Creature.Create (creature, position);

			//orient up
			vessel.ReferenceTransform.up = FlightGlobals.upAxis.normalized;
		}
	}
}

