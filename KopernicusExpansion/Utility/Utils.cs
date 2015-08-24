using System;
using UnityEngine;

namespace KopernicusExpansion
{
	public static class Utils
	{
		public static void Log(object message)
		{
			Debug.Log ("[KopernicusExpansion]: " + message.ToString ());
		}
		public static void LogError(object message)
		{
			Debug.LogError ("[KopernicusExpansion ERROR]: " + message.ToString ());
		}
		public static void LogWarning(object message)
		{
			Debug.LogWarning ("[KopernicusExpansion WARNING]: " + message.ToString ());
		}
	}
}

