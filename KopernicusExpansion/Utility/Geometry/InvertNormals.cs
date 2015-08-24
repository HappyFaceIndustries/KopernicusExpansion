using System;
using UnityEngine;

namespace KopernicusExpansion.Utility.Geometry
{
	public class InvertNormals
	{
		private Mesh mesh;

		public InvertNormals(Mesh meshToInvert)
		{
			mesh = meshToInvert;

			var normals = mesh.normals;
			for (int i = 0; i < normals.Length; i++)
			{
				normals [i] *= -1f;
			}
		}

		public static implicit operator Mesh(InvertNormals invertNormals)
		{
			return invertNormals.mesh;
		}
	}
}

