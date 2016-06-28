using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;

using KopernicusExpansion.Utility.Noise;
using KopernicusExpansion.Utility.Geometry;

namespace KopernicusExpansion
{
	[ExecuteInEditMode]
	[AddComponentMenu("KopernicusExpansion/Procedural Gas Giant/Controller")]
	[RequireComponent(typeof(MeshFilter)), RequireComponent(typeof(MeshRenderer))]
	public class ProceduralGasGiant : MonoBehaviour
	{
		public const float MAX_EVOLUTION = 10000f;

		public float GasGiantRadius = 1f;
		public float TimeScale = 1f;
		public int Seed = 0;

		[SerializeField]
		private Material material;
		[SerializeField]
		private float currentTime = 0f;
		[SerializeField]
		private float currentTimeX = 0f;
		[SerializeField]
		private float currentTimeY = 0f;
		[SerializeField]
		private float currentTimeZ = 0f;

		private void LateUpdate()
		{
			if(material == null)
			{
				return;
			}

			currentTime += Time.deltaTime * TimeScale;
			if (currentTime > MAX_EVOLUTION)
			{
				currentTime = 0f;
			}
			currentTimeX = Mathf.Sin (currentTime);
			currentTimeY = Mathf.Sin (currentTime + 120f);
			currentTimeZ = Mathf.Sin (currentTime + 240f);
			//currentTimeX = currentTime;
			//currentTimeY = currentTime;
			//currentTimeZ = currentTime;
			material.SetVector ("_Evolution", new Vector4 (currentTimeX, currentTimeY, currentTimeZ, 0f));
		}

		[ContextMenu("(Re)Generate")]
		public void GenerateMesh()
		{
			Debug.Log ("Generated ProceduralGasGiant mesh");

			var mf = GetComponent<MeshFilter> ();
			mf.sharedMesh = new UVSphere (GasGiantRadius, 90, 135);

			var noise = new ImprovedPerlinNoise (Seed);
			var mr = GetComponent<MeshRenderer> ();
			material = mr.sharedMaterial;
			noise.LoadResourcesFor3DNoise ();
			material.SetTexture ("_PermTable2D", noise.GetPermutationTable2D ());
			material.SetTexture ("_Gradient3D", noise.GetGradient3D ());
			currentTime = 0f;
			material.SetFloat ("_Evolution", currentTime);
		}
	}
}
