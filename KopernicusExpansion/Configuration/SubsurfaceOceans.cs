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
using KopernicusExpansion.Resources;
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

		private double[] vertHeights;

		public override void OnQuadPreBuild (PQ quad)
		{
			vertHeights = new double[PQS.cacheVertCount];
		}
		public override void OnQuadBuilt (PQ quad)
		{
			var mesh = quad.meshFilter.sharedMesh;
			var tris = mesh.triangles;
			var colors = mesh.colors;

			for (int i = 0; i < tris.Length; i += 3)
			{
				int t1 = tris [i];
				int t2 = tris [i + 1];
				int t3 = tris [i + 2];
				double alt = sphere.radius + altitude;

				if (vertHeights [t1] < alt || vertHeights [t2] < alt || vertHeights [t3] < alt)
				{
					tris [i] = 0;
					tris [i + 1] = 0;
					tris [i + 2] = 0;
					colors [t1] = Color.magenta;
					colors [t2] = Color.magenta;
					colors [t3] = Color.magenta;
				}
			}

			mesh.colors = colors;
			mesh.triangles = tris;
			quad.mesh = mesh;
			quad.meshFilter.sharedMesh = mesh;
		}
		public override void OnVertexBuildHeight (PQS.VertexBuildData data)
		{
			if (data.buildQuad == null)
				return;

			vertHeights [data.vertIndex] = data.vertHeight;
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

	[KSPAddon(KSPAddon.Startup.Flight, false)]
	public class SubsurfaceOceanDebugging : MonoBehaviour
	{
		void Start()
		{
			foreach (var pqs in UnityEngine.Resources.FindObjectsOfTypeAll<PQS>())
			{
				Debug.Log ("PQS: " + pqs.name + " -> surfaceRelativeQuads: " + pqs.surfaceRelativeQuads);
			}
		}
		void Update()
		{
			if (Input.GetKey (KeyCode.LeftAlt) && Input.GetKeyDown (KeyCode.P))
			{
				Debug.Log ("FPS: " + (1f / Time.deltaTime));
			}
		}
		void LateUpdate()
		{
			RenderSettings.ambientLight = Color.white * 0.2f;
		}
	}
}

