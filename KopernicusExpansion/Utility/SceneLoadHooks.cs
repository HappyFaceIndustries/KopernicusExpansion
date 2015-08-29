using System;
using UnityEngine;

namespace KopernicusExpansion.Utility
{
	[KSPAddon(KSPAddon.Startup.EveryScene, false)]
	public class SceneLoadHooks : MonoBehaviour
	{
		public static EventData<GameScenes> OnEverySceneLoaded = new EventData<GameScenes>("OnEverySceneLoaded");
		public static EventVoid OnMenuLoaded = new EventVoid("OnMenuLoaded");
		public static EventVoid OnSpaceCenterLoaded = new EventVoid("OnSpaceCenterLoaded");
		public static EventVoid OnTrackingStationLoaded = new EventVoid("OnTrackingStationLoaded");
		public static EventVoid OnFlightLoaded = new EventVoid("OnFlightLoaded");

		private void Start()
		{
			OnEverySceneLoaded.Fire (HighLogic.LoadedScene);
			switch (HighLogic.LoadedScene)
			{
			case GameScenes.MAINMENU:
				OnMenuLoaded.Fire ();
				break;
			case GameScenes.SPACECENTER:
				OnSpaceCenterLoaded.Fire ();
				break;
			case GameScenes.TRACKSTATION:
				OnTrackingStationLoaded.Fire ();
				break;
			case GameScenes.FLIGHT:
				OnFlightLoaded.Fire ();
				break;
			}
		}
	}
}

