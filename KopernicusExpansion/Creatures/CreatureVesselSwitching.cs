using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using UnityEngine;

namespace KopernicusExpansion.Creatures
{
	//this class is so that vessel switching using the [ and ] keys does not switch to creatures
	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class CreatureVesselSwitching : MonoBehaviour
	{
		private List<Vessel> vesselList = new List<Vessel> ();
		private Vessel currentVessel;
		private int currentIndex = 0;

		private void Start()
		{

		}

		private void Awake()
		{
		}

		private void Update()
		{
			//destroy the old one
			VesselSwitching vesselSwitching = UnityEngine.Object.FindObjectOfType<VesselSwitching> ();
			if (vesselSwitching != null)
			{
				Destroy (vesselSwitching);
				Utils.Log ("vesselSwitching destroyed.");
			}

			if (!MapView.MapIsEnabled)
			{
				if (!InputLockManager.IsLocked (ControlTypes.VESSEL_SWITCHING))
				{
					if (!FlightDriver.Pause)
					{
						currentIndex = -1;
						if (GameSettings.FOCUS_PREV_VESSEL.GetKeyDown ())
						{
							if (HighLogic.CurrentGame != null && !HighLogic.CurrentGame.Parameters.Flight.CanSwitchVesselsNear)
							{
								PostMessage ("Cannot switch vessels because it is disabled");
								return;
							}
							if (HighLogic.LoadedSceneIsFlight)
							{
								CameraManager.Instance.SetCameraFlight ();
							}
							this.vesselList.Clear ();
							currentIndex = FlightGlobals.Vessels.IndexOf (FlightGlobals.ActiveVessel);
							do
							{
								currentIndex--;
								if (currentIndex < 0)
									currentIndex += FlightGlobals.Vessels.Count;

								currentVessel = FlightGlobals.Vessels [currentIndex];
								if (currentVessel.loaded && currentVessel != FlightGlobals.ActiveVessel)
								{
									//only allow switching to non-creature vessels
									if (!(currentVessel.rootPart is CreaturePart))
									{
										this.vesselList.Add (currentVessel);
									}
								}
							}
							while(currentVessel != FlightGlobals.ActiveVessel);
						}
						if (GameSettings.FOCUS_NEXT_VESSEL.GetKeyDown ())
						{
							if (HighLogic.CurrentGame != null && !HighLogic.CurrentGame.Parameters.Flight.CanSwitchVesselsNear)
							{
								PostMessage ("Cannot switch vessels because it is disabled");
								return;
							}
							if (HighLogic.LoadedSceneIsFlight)
							{
								CameraManager.Instance.SetCameraFlight ();
							}
							this.vesselList.Clear ();
							currentIndex = FlightGlobals.Vessels.IndexOf (FlightGlobals.ActiveVessel);
							do
							{
								currentIndex++;
								if (currentIndex >= FlightGlobals.Vessels.Count)
									currentIndex = 0;

								currentVessel = FlightGlobals.Vessels [currentIndex];
								if (currentVessel.loaded && currentVessel != FlightGlobals.ActiveVessel)
								{
									//only allow switching to non-creature vessels
									if (!(currentVessel.rootPart is CreaturePart))
									{
										this.vesselList.Add (currentVessel);
									}
								}
							}
							while(currentVessel != FlightGlobals.ActiveVessel);
						}
						if (currentIndex != -1)
						{
							if (vesselList.Count <= 0)
							{
								PostMessage ("No nearby objects to focus. Use the Map View to select distant ones.");
							}
							else
							{
								ClearToSaveStatus status = FlightGlobals.ClearToSave ();
								foreach (var vessel in vesselList)
								{
									if (vessel.packed)
									{
										if (status != ClearToSaveStatus.CLEAR)
											continue;
									}
									FlightGlobals.ForceSetActiveVessel (vessel);
									FlightInputHandler.ResumeVesselCtrlState (vessel);
									return;
								}
							}
						}
					}
				}
			}
		}
		private void PostMessage(string message)
		{
			ScreenMessages.PostScreenMessage (new ScreenMessage (message, 5f, ScreenMessageStyle.UPPER_CENTER));
		}
	}
}

