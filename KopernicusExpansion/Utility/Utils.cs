using System;
using System.Collections.Generic;
using UnityEngine;

namespace KopernicusExpansion
{
	public static class Utils
	{
		private static Material _lineMat;
		public static Material LineMaterial
		{
			get
			{
				if (_lineMat == null)
				{
					var shader = Shader.Find ("Particles/Additive");
					_lineMat = new Material (shader);
					//_lineMat.hideFlags = HideFlags.HideAndDontSave;

					//turn on alpha blending
					//_lineMat.SetInt ("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
					//_lineMat.SetInt ("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);

					//turn off culling and depth writes
					_lineMat.SetInt ("_Cull", (int)UnityEngine.Rendering.CullMode.Off);
					_lineMat.SetInt ("_ZWrite", 0);
				}
				return _lineMat;
			}
		}

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

		public static string FormatTime(double time)
		{
			int iTime = (int) time % 3600;
			int seconds = iTime % 60;
			int minutes = (iTime / 60) % 60;
			int hours = (iTime / 3600);
			return "[" + hours.ToString ("D2") 
				+ ":" + minutes.ToString ("D2") + ":" + seconds.ToString ("D2") + "]: ";
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

