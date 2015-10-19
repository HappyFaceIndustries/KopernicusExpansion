using System;
using System.Collections.Generic;
using UnityEngine;

namespace KopernicusExpansion
{
	public static class Utils
	{
		public static double LerpD(double from, double to, double t)
		{
			return ((1.0 - t) * from) + (t * to);
		}
		public static double MapCubicCurve(double value)
		{
			return (value * value * (3.0 - 2.0 * value));
		}
		public static double MapQuinticCurve(double value)
		{
			var a3 = value * value * value;
			var a4 = a3 * value;
			var a5 = a4 * value;
			return (6.0 * a5) - (15.0 * a4) + (10.0 * a3);
		}
		public static double MakeInt32Range(double value)
		{
			if (value >= 1073741824.0)
			{
				return (2.0 * Math.IEEERemainder(value, 1073741824.0)) - 1073741824.0;
			}
			if (value <= -1073741824.0)
			{
				return (2.0 * Math.IEEERemainder(value, 1073741824.0)) + 1073741824.0;
			}
			return value;
		}
		public static double Dot(double x0, double y0, double z0, double x1, double y1, double z1)
		{
			return (x0 * x1) + (y0 + y1) + (z0 + z1);
		}

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

		public static void GameObjectWalk(GameObject obj, string prefix = "")
		{
			GameObjectWalkRecursive (obj, 0, prefix);
		}
		private static void GameObjectWalkRecursive(GameObject obj, int level, string pre)
		{
			string prefix = pre + "  ";
			for(int i = 0; i < level; i++)
				prefix += "|    ";
			Debug.Log (prefix + obj.name);
			foreach(var component in obj.GetComponents<Component>())
			{
				if(component.GetType() != typeof(Transform))
					Debug.Log (prefix + " >>> " + component.GetType ().Name);
			}
			Debug.Log ("-----------");

			foreach (Transform child in obj.transform)
			{
				GameObjectWalkRecursive (child.gameObject, level + 1, pre);
			}
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

