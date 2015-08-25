using System;
using System.Collections.Generic;
using UnityEngine;

namespace KopernicusExpansion
{
	public static class Utils
	{
		public static List<PSystemBody> GetBodies()
		{
			return GetBodiesRecursive (PSystemManager.Instance.systemPrefab.rootBody);
		}
		private static List<PSystemBody> GetBodiesRecursive(PSystemBody body)
		{
			List<PSystemBody> bodies = new List<PSystemBody> ();
			bodies.Add (body);
			foreach (var child in body.children)
			{
				bodies.AddRange(GetBodiesRecursive (child));
			}
			return bodies;
		}

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

