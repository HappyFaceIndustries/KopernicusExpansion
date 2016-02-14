using System;
using System.IO;
using System.Linq;
using System.Collections;
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

		public static List<CelestialBody> GetBodies()
		{
			return FlightGlobals.Bodies;
		}
		public static GameObject GetScaled(string name)
		{
			if (ScaledSpace.Instance.transform.FindChild (name) != null)
			{
				var scaledTrns = ScaledSpace.Instance.transform.FindChild (name);
				return scaledTrns.gameObject;
			}
			return null;
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

		public static Texture2D[] BuildMaps(CelestialBody body, Texture2D specularMap, int resolution, float normalStrength, bool writeFiles, bool generateSpecFromOcean, bool colorFromOcean, Color oceanColor, bool updateScaled)
		{
			if (body.pqsController == null)
			{
				Utils.LogError ("Body has no PQS");
				return null;
			}
			var scaled = GetScaled (body.name);
			if (scaled == null && updateScaled)
			{
				Utils.LogError ("Body has no ScaledVersion");
				return null;
			}

			var pqs = body.pqsController;

			if (resolution % 2 != 0)
			{
				Utils.LogError ("Resolution not divisible by 2!");
				return null;
			}
			var yResolution = (resolution / 2);

			var colorMap = new Texture2D (resolution, yResolution, TextureFormat.ARGB32, true);
			var heightMap = new Texture2D (resolution, yResolution, TextureFormat.RGB24, false);
			var normalMap = new Texture2D (resolution, yResolution, TextureFormat.ARGB32, true);
			if (generateSpecFromOcean && specularMap == null)
			{
				specularMap = new Texture2D (resolution, yResolution, TextureFormat.RGB24, false);
			}

			pqs.SetupExternalRender ();

			var modVertexHeightMethod = typeof(PQS).GetMethod ("Mod_OnVertexBuildHeight", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);
			var modVertexMethod = typeof(PQS).GetMethod ("Mod_OnVertexBuild", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic);

			double[,] heightScalarField = new double[resolution, yResolution];
			for (int x = 0; x < resolution; x++)
			{
				for (int y = 0; y < yResolution; y++)
				{
					//get height and color data from PQS
					var data = new PQS.VertexBuildData ();
					data.directionFromCenter = (QuaternionD.AngleAxis((360d / resolution) * x, Vector3d.up) * QuaternionD.AngleAxis(90d - (180d / yResolution) * y, Vector3d.right)) * Vector3d.forward;
					data.vertHeight = pqs.radius;

					modVertexHeightMethod.Invoke (pqs, new object[]{ data });
					modVertexMethod.Invoke (pqs, new object[]{ data });

					//write height to the scalar field
					var height = data.vertHeight - pqs.radius;
					heightScalarField [x, y] = height;

					//calculate color
					var color = data.vertColor;
					if (colorFromOcean && body.ocean && height <= 0f)
					{
						color = oceanColor;
					}

					//calculate specularity
					float spec = 1f;
					if (!generateSpecFromOcean && specularMap != null)
					{
						spec = specularMap.GetPixelBilinear ((float)x / (float)resolution, (float)y / (float)yResolution).grayscale;
					}
					//generate ocean specularity if requested
					if (generateSpecFromOcean && specularMap != null && body.ocean)
					{
						if (height <= 0)
						{
							specularMap.SetPixel (x, y, Color.white);
							spec = 1f;
						}
						else
						{
							specularMap.SetPixel (x, y, Color.black);
							spec = 0f;
						}
					}

					//write color/spec into colormap
					colorMap.SetPixel (x, y, new Color (color.r, color.g, color.b, spec));
				}
			}

			pqs.CloseExternalRender ();

			//finish color/spec maps
			colorMap.Apply ();
			if (generateSpecFromOcean && specularMap != null)
			{
				specularMap.Apply ();
			}

			//calculate highest and lowest heights
			double lowestHeight = double.MaxValue;
			double highestHeight = double.MinValue;
			for (int x = 0; x < resolution; x++)
			{
				for (int y = 0; y < yResolution; y++)
				{
					var height = heightScalarField [x, y];
					if (height < lowestHeight)
						lowestHeight = height;
					if (height > highestHeight)
						highestHeight = height;
				}
			}

			//fill with grey if the surface is completely flat
			if(highestHeight == lowestHeight)
			{
				for (int x = 0; x < resolution; x++)
				{
					for (int y = 0; y < yResolution; y++)
					{
						heightMap.SetPixel (x, y, new Color (0.5f, 0.5f, 0.5f));
					}
				}
			}
			//otherwise write an actual height map
			else
			{
				for (int x = 0; x < resolution; x++)
				{
					for (int y = 0; y < yResolution; y++)
					{
						var height = heightScalarField [x, y];
						//center to 0 -> 1
						height -= lowestHeight;
						height /= highestHeight - lowestHeight;

						heightMap.SetPixel (x, y, new Color ((float)height, (float)height, (float)height));
					}
				}
			}
			heightMap.Apply ();

			//generate normal map from height map
			BumpToNormal (heightMap, normalMap, normalStrength);

			//write files if requested
			if (writeFiles)
			{
				string path = KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansion/Exports/";
				Directory.CreateDirectory (path);
				File.WriteAllBytes (path + body.bodyName + "_Color.png", colorMap.EncodeToPNG ());
				File.WriteAllBytes (path + body.bodyName + "_Height.png", heightMap.EncodeToPNG ());
				File.WriteAllBytes (path + body.bodyName + "_Normal.png", normalMap.EncodeToPNG ());
				if(generateSpecFromOcean && specularMap != null)
				{
					File.WriteAllBytes (path + body.bodyName + "_Spec.png", specularMap.EncodeToPNG ());
				}
			}

			//update scaled if requested
			if (updateScaled)
			{
				scaled.renderer.sharedMaterial.SetTexture ("_MainTex", colorMap);
				scaled.renderer.sharedMaterial.SetTexture ("_BumpMap", normalMap);
			}

			return new Texture2D[]{ colorMap, heightMap, specularMap, normalMap };
		}

		//taken from Kopernicus.Utility.cs, originally written by Kragrathea.
		//only change was removing the arbitrary limit on normal strength
		public static void BumpToNormal(Texture2D bump, Texture2D normal, float strength)
		{
			strength = Mathf.Abs (strength);
			for (int by = 0; by < normal.height; by++)
			{
				for (var bx = 0; bx < normal.width; bx++)
				{
					var xLeft = bump.GetPixel(bx - 1, by).grayscale * strength;
					var xRight = bump.GetPixel(bx + 1, by).grayscale * strength;
					var yUp = bump.GetPixel(bx, by - 1).grayscale * strength;
					var yDown = bump.GetPixel(bx, by + 1).grayscale * strength;
					var xDelta = ((xLeft - xRight) + 1) * 0.5f;
					var yDelta = ((yUp - yDown) + 1) * 0.5f;
					normal.SetPixel(bx, by, new Color(yDelta, yDelta, yDelta, xDelta));
				}
			}
			normal.Apply();
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

