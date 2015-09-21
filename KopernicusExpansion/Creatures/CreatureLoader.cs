using System;
using System.Linq;
using System.Collections.Generic;
using UnityEngine;

using Kopernicus;

namespace KopernicusExpansion.Creatures
{
	[KSPAddon(KSPAddon.Startup.MainMenu, false)]
	public class CreatureLoader : MonoBehaviour
	{
		private void Start()
		{
			StartLoad ();
			DontDestroyOnLoad (this);
		}
		private void OnGUI()
		{
			if (!isDone)
				GUI.Label (new Rect (6f, 6f, 200f, 30f), "<color=white>" + currentCreatureName + "</color><color=" + guiColor + "> - " + (ProgressFraction () * 100f).ToString ("##0.0##") + "%</color>");
			else if(displayText)
				GUI.Label (new Rect (6f, 6f, 200f, 30f), "<color=" + guiColor + ">Done loading creatures</color>");
		}
		private void OnLevelWasLoaded()
		{
			if (isDone)
				Destroy (this);
		}

		private static string guiColor = "#69b5ff";
		public static List<Creature> LoadedCreatures = new List<Creature>();

		//load creatures at 10fps
		private float loadSpeed = 1f / 10f;

		private string currentCreatureName = "Creature";
		private int creatureLoadCounter = 0;
		private int totalCreatures = 0;
		private bool isDone = false;
		private float displayTextDelay = 5f;
		private bool displayText = true;

		public float ProgressFraction ()
		{
			if(totalCreatures > 0)
				return (float)creatureLoadCounter / (float)totalCreatures;
			else
				return 1f;
		}
		public void StartLoad ()
		{
			StartCoroutine (LoadCreatures());
		}

		private IEnumerator<YieldInstruction> LoadCreatures()
		{
			ConfigNode[] creatures = GameDatabase.Instance.GetConfigNodes ("CREATURE");
			totalCreatures = creatures.Length;

			Logger creatureLogger = new Logger ("Creatures");
			creatureLogger.SetAsActive ();

			foreach (var node in creatures)
			{
				try
				{
					var creature = Creature.Load (node);
					currentCreatureName = creature.name;
					LoadedCreatures.Add (creature);

					//log it
					Logger.Active.Log ("Creature " + creature.name + " loaded");
				}
				catch(Exception e)
				{
					Logger.Active.Log ("Error loading creature:");
					Logger.Active.LogException (e);
				}
				creatureLoadCounter++;
				yield return new WaitForSeconds(loadSpeed);
			}

			creatureLogger.Flush ();
			creatureLogger.Close ();

			creatureLoadCounter = totalCreatures;
			isDone = true;

			yield return new WaitForSeconds(displayTextDelay);

			displayText = false;
		}
	}
}

