using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;

namespace KopernicusExpansion.Creatures
{
	[KSPAddon(KSPAddon.Startup.EveryScene, false)]
	public class CreatureVesselHandler : MonoBehaviour
	{
		List<MapObject> mapObjsToRemove = new List<MapObject>();

		void Start()
		{
			//only run on flight/spacecenter/trackingstation
			if (!(HighLogic.LoadedScene == GameScenes.FLIGHT || HighLogic.LoadedScene == GameScenes.SPACECENTER || HighLogic.LoadedScene == GameScenes.TRACKSTATION))
				return;

			foreach (var vessel in FlightGlobals.Vessels)
			{
				try
				{
					var firstPart = vessel.protoVessel.protoPartSnapshots [0];
					if (firstPart.partInfo.partPrefab is CreaturePart)
					{
						//remove orbit renderer
						if(vessel.orbitDriver.Renderer != null)
						{
							Destroy (vessel.orbitDriver.Renderer);
						}

						//make it not appear in tracking station sidebar
						if (HighLogic.LoadedScene == GameScenes.TRACKSTATION)
						{
							vessel.DiscoveryInfo.SetLevel (DiscoveryLevels.None);
						}

						//remove map targets
						foreach(var mapObj in PlanetariumCamera.fetch.targets)
						{
							if(mapObj.type == MapObject.MapObjectType.VESSEL && mapObj.vessel == vessel)
								mapObjsToRemove.Add (mapObj);
						}
						foreach (var mapObj in mapObjsToRemove)
						{
							PlanetariumCamera.fetch.RemoveTarget (mapObj);
						}
					}
				}
				catch(Exception e)
				{
					Utils.LogError ("Error initializing creature vessel");
					Debug.LogException (e);
				}
			}

			//refresh the tracking station sidebar
			if (HighLogic.LoadedScene == GameScenes.TRACKSTATION)
			{
				var spaceTracking = UnityEngine.Object.FindObjectOfType<SpaceTracking> ();
				try
				{
					if (spaceTracking != null)
					{
						var buildVesselsListMethod = spaceTracking.GetType ().GetMethod ("buildVesselsList", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
						buildVesselsListMethod.Invoke (spaceTracking, new object[]{});
					}
					else
						Utils.LogWarning ("couldn't find SpaceTracking object");
				}
				catch(Exception e)
				{
					Utils.LogError ("failed to rebuild trackingstation vessel list:");
					Debug.LogException (e);
				}
			}
		}
	}
}

