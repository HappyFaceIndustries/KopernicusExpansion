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
	[AddComponentMenu("KopernicusExpansion/Comet Tails/Controller")]
	[RequireComponent(typeof(MeshFilter)), RequireComponent(typeof(MeshRenderer))]
	public class CometTail : MonoBehaviour
	{
		public const float MAX_EVOLUTION = 10000f;

		public float TailRadius = 1.5f;
		public float TailLength = 10f;
		public float TimeScale = 1f;
		public int Seed = 0;

		[SerializeField]
		private Material material;
		[SerializeField]
		private float currentTime;

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
			material.SetFloat ("_Evolution", currentTime);
		}

		[ContextMenu("(Re)Generate")]
		public void GenerateMesh()
		{
			var mf = GetComponent<MeshFilter> ();
			mf.sharedMesh = new Teardrop (TailRadius, TailLength, 60, 90);

			var noise = new ImprovedPerlinNoise (Seed);
			var mr = GetComponent<MeshRenderer> ();
			material = mr.sharedMaterial;
			noise.LoadResourcesFor3DNoise ();
			material.SetTexture ("_PermTable2D", noise.GetPermutationTable2D ());
			material.SetTexture ("_Gradient3D", noise.GetGradient3D ());
			currentTime = 0f;
			material.SetFloat ("_Evolution", currentTime);
			material.renderQueue = 3100;
		}
	}
}
