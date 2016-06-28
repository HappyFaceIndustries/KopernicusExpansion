using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;

namespace KopernicusExpansion
{
	[ExecuteInEditMode]
	[AddComponentMenu("KopernicusExpansion/Subsurface Scattering/Replacement Shader Effect")]
	public class ReplacementShaderEffect : MonoBehaviour
	{
		public Shader ReplacementShader;
		public new Camera camera;

		private void OnEnable()
		{
			if (camera == null)
			{
				camera = GetComponent<Camera> ();
			}
			if (camera == null)
			{
				Debug.LogError ("ReplacementShaderEffect requires a camera to be specified");
				return;
			}
			camera.SetReplacementShader (ReplacementShader, "");
		}
		private void OnDisable()
		{
			if (camera == null)
			{
				camera = GetComponent<Camera> ();
			}
			if (camera == null)
			{
				Debug.LogError ("ReplacementShaderEffect requires a camera to be specified");
				return;
			}
			camera.ResetReplacementShader ();
		}
	}
}

