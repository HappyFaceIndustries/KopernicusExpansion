using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Configuration;
using KopernicusExpansion.Utility.Geometry;

using UnityEngine;

namespace Kopernicus.Configuration.ModLoader
{
	[RequireConfigType(ConfigType.Node)]
	public class SubsurfaceOceans : ModLoader, IParserEventSubscriber
	{
		public SubsurfaceOceans()
		{
			_mod = new GameObject ("SubsurfaceOceansMod").AddComponent<PQSMod_SubsurfaceOceans> ();
			_mod.transform.parent = Kopernicus.Utility.Deactivator;
			base.mod = _mod;
		}

		private PQSMod_SubsurfaceOceans _mod;

		public void Apply(ConfigNode node)
		{
		}
		public void PostApply(ConfigNode node)
		{
		}
	}

	[RequireConfigType(ConfigType.Node)]
	public class RemoveTrianglesBelowAltitude : ModLoader, IParserEventSubscriber
	{
		public RemoveTrianglesBelowAltitude()
		{
			_mod = new GameObject ("RemoveTrianglesBelowAltitudeMod").AddComponent<PQSMod_RemoveTrianglesBelowAltitude> ();
			_mod.transform.parent = Kopernicus.Utility.Deactivator;
			base.mod = _mod;
		}

		private PQSMod_RemoveTrianglesBelowAltitude _mod;

		[ParserTarget("altitude", optional = true)]
		public NumericParser<double> altitude
		{
			set
			{
				_mod.altitude = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{
		}
		public void PostApply(ConfigNode node)
		{
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_RemoveTrianglesBelowAltitude : PQSMod
	{
		public double altitude = 0;
		private double sphereAltitude = 0;

		private double[] vertHeights;

		public override void OnSetup ()
		{
			sphereAltitude = altitude + sphere.radius;
		}

		public override void OnQuadPreBuild (PQ quad)
		{
			vertHeights = new double[PQS.cacheVertCount];
		}
		static bool hasRun = false;
		public override void OnQuadBuilt (PQ quad)
		{
			try
			{
				if (!hasRun)
					Debug.Log ("0");

				bool shouldRemoveTris = false;
				bool shouldRemovePQ = false;

				double maxAlt = double.MinValue;
				foreach (var alt in vertHeights)
				{
					if (alt > maxAlt)
						maxAlt = alt;

					if (alt < sphereAltitude)
						shouldRemoveTris = true;
				}

				if (!hasRun)
					Debug.Log ("1");

				//if all triangles are below threshold, just remove quad
				if (maxAlt < sphereAltitude)
				{
					shouldRemoveTris = false;
					shouldRemovePQ = true;
				}

				if (!hasRun)
					Debug.Log ("2");

				if(shouldRemoveTris)
				{
					if (!hasRun)
						Debug.Log ("2.5");

					//TODO: try disabling meshRenderer/Collider in the Update function
					if(quad.meshRenderer != null)
						quad.meshRenderer.enabled = false;
					else
					{
						var pqmr = quad.GetComponent<MeshRenderer>();
						if(pqmr != null)
							pqmr.enabled = false;
					}
					if(quad.meshCollider != null)
						quad.meshCollider.enabled = false;
					else
					{
						var pqmc = quad.GetComponent<MeshCollider>();
						if(pqmc != null)
							pqmc.enabled = false;
					}

					if (!hasRun)
						Debug.Log ("3");

					GameObject obj = new GameObject ("PQ_TrianglesRemoved");
					obj.transform.parent = quad.transform;
					obj.transform.localPosition = Vector3.zero;
					obj.transform.rotation = quad.transform.rotation;
					obj.SetActive (true);
					obj.layer = GameLayers.LocalSpace;

					if (!hasRun)
						Debug.Log ("4");

					var mf = obj.AddComponent<MeshFilter> ();
					var mr = obj.AddComponent<MeshRenderer> ();
					var mc = obj.AddComponent<MeshCollider> ();

					if (!hasRun)
						Debug.Log ("5");

					mf.mesh = new CopyMesh (quad.mesh);

					if (!hasRun)
						Debug.Log ("6");

					mr.sharedMaterial = quad.meshRenderer.sharedMaterial;
					mr.receiveShadows = true;
					mr.castShadows = true;

					if (!hasRun)
						Debug.Log ("7");

					mc.convex = false;
					mc.sharedMesh = mf.sharedMesh;
					mc.smoothSphereCollisions = true;

					if (!hasRun)
						Debug.Log ("8");

					var mesh = mf.sharedMesh;
					var tris = mesh.triangles;
					if (!hasRun)
						Debug.Log ("9");
					for (int i = 0; i < tris.Length; i += 3)
					{
						int t1 = tris [i];
						int t2 = tris [i + 1];
						int t3 = tris [i + 2];

						if (vertHeights [t1] < sphereAltitude || vertHeights [t2] < sphereAltitude || vertHeights [t3] < sphereAltitude)
						{
							tris [i] = 0;
							tris [i + 1] = 0;
							tris [i + 2] = 0;
						}
					}
					if (!hasRun)
						Debug.Log ("10");
					mesh.triangles = tris;
					if (!hasRun)
						Debug.Log ("11");

					quad.gameObject.AddComponent<WireframeViewer> ();

					if (!hasRun)
						Debug.Log ("12");
				}
				else if(shouldRemovePQ)
				{
					if (!hasRun)
						Debug.Log ("13");

					if(quad.meshRenderer != null)
						quad.meshRenderer.enabled = false;
					else
					{
						var pqmr = quad.GetComponent<MeshRenderer>();
						if(pqmr != null)
							pqmr.enabled = false;
					}
					if(quad.meshCollider != null)
						quad.meshCollider.enabled = false;
					else
					{
						var pqmc = quad.GetComponent<MeshCollider>();
						if(pqmc != null)
							pqmc.enabled = false;
					}

					if (!hasRun)
						Debug.Log ("14");
				}

				hasRun = true;
			}
			catch(Exception e){Debug.LogException (e); hasRun = true;}
		}
		public override void OnVertexBuildHeight (PQS.VertexBuildData data)
		{
			if (data.buildQuad == null)
				return;

			vertHeights [data.vertIndex] = data.vertHeight;
		}

		public override void OnQuadDestroy (PQ quad)
		{
			var removeTris = quad.transform.FindChild ("PQ_TrianglesRemoved");
			if (removeTris != null)
			{
				Destroy (removeTris.gameObject);
			}
		}
	}
	public class PQSMod_SubsurfaceOceans : PQSMod
	{
		private PQ_Underside currentUnderside;
		public override void OnQuadPreBuild (PQ quad)
		{
			var obj = new GameObject ("PQ_Underside_" + quad.name);
			obj.transform.parent = quad.transform;
			obj.transform.localPosition = Vector3.zero;
			obj.transform.localRotation = Quaternion.identity;

			currentUnderside = obj.AddComponent<PQ_Underside> ();

			currentUnderside.dirs = new Vector3d[PQS.cacheVertCount];
		}
		public override void OnQuadBuilt (PQ quad)
		{
			currentUnderside.Create (quad);
		}
		public override void OnVertexBuildHeight (PQS.VertexBuildData data)
		{
			if (data.buildQuad == null)
				return;

			if(currentUnderside != null && currentUnderside.dirs != null)
				currentUnderside.dirs [data.vertIndex] = data.directionFromCenter;
		}
		public override void OnQuadDestroy (PQ quad)
		{
			var underside = quad.gameObject.GetComponentInChildren<PQ_Underside> ();
			if (underside != null)
				Destroy (underside.gameObject);
		}
	}

	public class PQ_Underside : MonoBehaviour
	{
		public Vector3d[] dirs;
		public PQ quad;
		public Mesh mesh;
		public MeshFilter meshFilter;
		public MeshRenderer meshRenderer;
		public MeshCollider meshCollider;

		public Simplex simplex;

		public void Create(PQ pq)
		{
			quad = pq;

			simplex = new Simplex (0, 3, 0.6, 35);
			mesh = CreateMesh ();

			meshFilter = gameObject.AddComponent<MeshFilter> ();
			meshRenderer = gameObject.AddComponent<MeshRenderer> ();
			meshCollider = gameObject.AddComponent<MeshCollider> ();

			meshFilter.sharedMesh = mesh;

			meshRenderer.castShadows = true;
			meshRenderer.receiveShadows = true;
			meshRenderer.sharedMaterial = quad.meshRenderer.sharedMaterial;

			meshCollider.convex = false;
			meshCollider.sharedMesh = mesh;
			meshCollider.smoothSphereCollisions = true;
		}
		public Mesh CreateMesh()
		{
			//copy the mesh
			Mesh mMesh = new CopyMesh (quad.mesh);

			//adjust the mesh
			var verts = mMesh.vertices;
			var colors = mMesh.colors;
			for (int i = 0; i < verts.Length; i++)
			{
				var dirFromCenter = dirs [i];
				double vertHeight = quad.sphereRoot.radius + 15000;

				double noise = simplex.noiseNormalized (dirFromCenter);
				colors [i] = new Color ((float)noise, (float)noise, (float)noise);
				if (noise > 0.7)
				{
					noise -= 0.7;
					noise *= 5;
					noise += 0.7;
				}
				vertHeight -= noise * 1000;

				var vert1 = dirFromCenter * vertHeight;
				var vert2 = quad.sphereRoot.transform.TransformPoint (vert1);
				verts [i] = quad.transform.InverseTransformPoint (vert2);
			}
			mMesh.vertices = verts;
			mMesh.colors = colors;

			//reverse the mesh
			mMesh = new ReverseMesh (mMesh);
			//update the mesh
			mMesh.RecalculateBounds ();
			mMesh.RecalculateNormals ();
			mMesh.Optimize ();
			//name and return
			mMesh.name = "PQ_Underside_" + quad.mesh.name;
			return mMesh;
		}
	}

//	[KSPAddon(KSPAddon.Startup.Flight, false)]
//	public class SubsurfaceOceanDebugging : MonoBehaviour
//	{
//		void Update()
//		{
//			if (Input.GetKey (KeyCode.LeftAlt) && Input.GetKeyDown (KeyCode.P))
//			{
//				Debug.Log ("FPS: " + (1f / Time.deltaTime));
//			}
//		}
//		void LateUpdate()
//		{
//			RenderSettings.ambientLight = Color.white * 0.2f;
//		}
//	}
}

