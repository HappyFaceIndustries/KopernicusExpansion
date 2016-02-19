using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;

using Kopernicus;

namespace KopernicusExpansion.Creatures
{
	[KopernicusExpansionLoader]
	public class CreatureLoader : LoadingSystem
	{
		public static List<Creature> LoadedCreatures = new List<Creature>();

		private string currentCreatureName = "Creature";
		private int creatureLoadCounter = 0;
		private int totalCreatures = 0;
		private bool isDone = false;

		public override float ProgressFraction ()
		{
			if(totalCreatures > 0)
				return (float)creatureLoadCounter / (float)totalCreatures;
			else
				return 1f;
		}
		public override bool IsReady ()
		{
			return isDone;
		}
		public override string ProgressTitle ()
		{
			return currentCreatureName;
		}
		public override void StartLoad ()
		{
			Utils.Log ("Starting CreatureLoader!");
			StartCoroutine (LoadCreatures());
		}

		private IEnumerator<YieldInstruction> LoadCreatures()
		{
			ConfigNode[] creatures = GameDatabase.Instance.GetConfigNodes ("CREATURE");
			totalCreatures = creatures.Length;

			foreach (var node in creatures)
			{
				try
				{
					if(node.HasValue("name"))
					{
						var name = node.GetValue ("name");

						var creatureLogger = new KopernicusExpansionLogger (name + ".Creature");
						creatureLogger.SetAsActive ();

						var creature = Creature.Load (node);
						currentCreatureName = creature.name;
						LoadedCreatures.Add (creature);

						//log it
						Logger.Active.Log ("Creature " + creature.name + " loaded");

						creatureLogger.Flush ();
						creatureLogger.Close ();
					}
				}
				catch(Exception e)
				{
					Utils.LogError ("Error loading creature:");
					Debug.LogException (e);
				}
				creatureLoadCounter++;

				//wait for next frame
				yield return null;
			}

			creatureLoadCounter = totalCreatures;
			isDone = true;

			Utils.Log ("CreatureLoader done!");
		}
	}
}

