using System;
using UnityEngine;

namespace KopernicusExpansion.Utility
{
	public class WireframeViewer : MonoBehaviour
	{
		public Color color = Color.green;
		private Mesh mesh;

		private void Start()
		{
			var mf = GetComponent<MeshFilter> ();
			if (mf != null)
				mesh = mf.sharedMesh;
		}

		private bool IsHoveredOver = false;
		private void OnMouseEnter()
		{
			IsHoveredOver = true;
		}
		private void OnMouseExit()
		{
			IsHoveredOver = false;
		}
		private void OnRenderObject()
		{
			if (mesh != null && !IsHoveredOver && Settings.AllowEditors)
				return;

			GL.PushMatrix ();
			Utils.LineMaterial.SetPass (0);
			GL.MultMatrix (transform.localToWorldMatrix);

			GL.Begin (GL.LINES);
			GL.Color (color);

			var verts = mesh.vertices;
			var trigs = mesh.triangles;

			for (int t = 0; t < trigs.Length / 3; t++)
			{
				GL.Vertex (verts [trigs[t * 3]]);
				GL.Vertex (verts [trigs[t * 3 + 1]]);

				GL.Vertex (verts [trigs[t * 3 + 1]]);
				GL.Vertex (verts [trigs[t * 3 + 2]]);

				GL.Vertex (verts [trigs[t * 3 + 2]]);
				GL.Vertex (verts [trigs[t * 3]]);
			}

			GL.End ();
			GL.PopMatrix ();
		}
	}
}

