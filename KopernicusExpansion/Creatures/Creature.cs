using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Utility;
using KopernicusExpansion.Creatures.AI;
using KopernicusExpansion.Creatures.AI.Configuration;

using UnityEngine;

namespace KopernicusExpansion.Creatures
{
	[RequireConfigType(ConfigType.Node)]
	public class Creature : IParserEventSubscriber
	{
		private static Dictionary<string, Type> AILoaderTypes = new Dictionary<string, Type> ();

		//constructor
		public Creature()
		{
		}

		private const string AINodeName = "AI";

		//fields
		[ParserTarget("name", optional = false)]
		public string name;

		[ParserTarget("part", optional = false)]
		public string part;

		[ParserTarget("Gore", optional = true)]
		public CreatureGoreSettings Gore = new CreatureGoreSettings ();

		public List<AIModuleLoaderGeneric> AIModules;

		//apply/postApply
		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{
			AIModules = new List<AIModuleLoaderGeneric> ();

			//parse the ai modules
			if (node.HasNode (AINodeName))
			{
				ConfigNode aiNode = node.GetNode (AINodeName);

				foreach(var aiModuleNode in aiNode.GetNodes())
				{
					//get the loader type
					Type loaderType = null;

					if (AILoaderTypes.ContainsKey (aiModuleNode.name))
						loaderType = AILoaderTypes [aiModuleNode.name];
					else
					{
						foreach (var assembly in AssemblyLoader.loadedAssemblies)
						{
							foreach (var type in assembly.assembly.GetTypes())
							{
								AILoaderType typeAttribute = null;

								foreach (var attr in Attribute.GetCustomAttributes(type))
								{
									if (attr is AILoaderType)
										typeAttribute = (AILoaderType)attr;
								}

								if (typeAttribute != null)
								{
									AILoaderTypes.Add (type.Name, typeAttribute.loaderType);
									loaderType = typeAttribute.loaderType;
								}
							}
						}
					}

					//parse the object
					if (loaderType != null)
					{
						var loader = Parser.CreateObjectFromConfigNode (loaderType, aiModuleNode);
						if(loader is AIModuleLoaderGeneric)
							AIModules.Add ((AIModuleLoaderGeneric)loader);
					}
				}
			}

			//sort the list by priority
			AIModules.Sort (delegate(AIModuleLoaderGeneric a, AIModuleLoaderGeneric b) {
				return a.priority.CompareTo(b.priority);
			});

			for(int i = 0; i < AIModules.Count; i++)
			{
				var m = AIModules [i];
				Logger.Active.Log (i + ": " + m.GetType().Name + " => " + m.priority);
			}
		}

		//loading
		public static Creature Load(ConfigNode node)
		{
			var creature = new Creature ();
			Parser.LoadObjectFromConfigurationNode (creature, node);
			return creature;
		}

		//creation
		public static Vessel Create(Creature creature, Vector3 positionOffset)
		{
			try
			{
				AvailablePart partInfo = PartLoader.LoadedPartsList.First(ap => ap.name == creature.part);
				Part referencePart = FlightGlobals.ActiveVessel.rootPart;

				Part part = (Part)UnityEngine.Object.Instantiate (partInfo.partPrefab);
				part.gameObject.SetActive(true);
				part.gameObject.name = partInfo.name;
				part.partInfo = partInfo;
				part.SetMirror(Vector3.one);

				ShipConstruct sc = new ShipConstruct();
				sc.Add(part);
				sc.SaveShip();
				sc.shipName = creature.name;

				Vessel vessel = sc.parts[0].localRoot.gameObject.AddComponent<Vessel>();
				vessel.id = Guid.NewGuid();
				vessel.vesselName = sc.shipName;
				vessel.vesselType = VesselType.Unknown;
				//vessel.DiscoveryInfo.Load(ProtoVessel.CreateDiscoveryNode(DiscoveryLevels.Unowned, UntrackedObjectClass.A, 10000, 10000));
				vessel.ctrlState = new FlightCtrlState();
				vessel.ctrlState.NeutralizeAll();
				vessel.Initialize(false);
				vessel.Landed = false;
				vessel.SetPosition(referencePart.transform.position + positionOffset);
				vessel.SetRotation(Quaternion.identity);

				//manually remove orbit renderer
				UnityEngine.Object.Destroy(vessel.orbitDriver.Renderer);

				CreaturePart cp = (CreaturePart)vessel.rootPart;
				cp.creature = creature;
				cp.flightID = ShipConstruction.GetUniqueFlightID(HighLogic.CurrentGame.flightState);
				cp.missionID = referencePart.missionID;
				cp.flagURL = referencePart.flagURL;

				FlightLogger.eventLog.Add(Utils.FormatTime(referencePart.vessel.missionTime) + "A " + creature.name + " was seen.");

				return vessel;
			}
			catch(Exception e)
			{
				Utils.LogError ("Error encountered while spawning part");
				if(e != null)
					Debug.LogException (e);
			}

			return null;
		}

		[RequireConfigType(ConfigType.Node)]
		public class CreatureGoreSettings
		{
			//constructor
			public CreatureGoreSettings()
			{
			}

			public bool enabled = true;
			public Color bloodColor = Color.red;
			public Color skinColor = Color.white;
			public float bloodSphereSize = 2f;
			public float bloodVelocityMultiplier = 1f;

			[ParserTarget("enabled", optional = true)]
			public NumericParser<bool> enabledParser
			{
				set
				{
					enabled = value.value;
				}
			}
			[ParserTarget("bloodColor", optional = true)]
			public ColorParser bloodColorParser
			{
				set
				{
					bloodColor = value.value;
				}
			}
			[ParserTarget("skinColor", optional = true)]
			public ColorParser skinColorParser
			{
				set
				{
					skinColor = value.value;
				}
			}
			[ParserTarget("bloodSphereSize", optional = true)]
			public NumericParser<float> bloodSphereSizeParser
			{
				set
				{
					bloodSphereSize = value.value;
				}
			}
			[ParserTarget("bloodVelocityMultiplier", optional = true)]
			public NumericParser<float> bloodVelocityMultiplierParser
			{
				set
				{
					bloodVelocityMultiplier = value.value;
				}
			}
		}
	}
}

