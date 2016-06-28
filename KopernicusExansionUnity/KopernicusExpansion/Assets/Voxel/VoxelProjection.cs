using UnityEngine;
using System.Collections;

public class VoxelProjection : MonoBehaviour
{
	public bool Project = false;

	public Matrix4x4 ProjectionMatrix = Matrix4x4.identity;

	public float scale = 10f;
	public float near = 0.005f;
	public float far = 100f;
	public float left = -50f;
	public float right = 50f;
	public float top = 50f;
	public float bottom = -50f;

	[ContextMenu("Update Projection Matrix")]
	public void UpdateProjection()
	{
		ProjectionMatrix.m00 = ((2f * near) / (right - left)); ProjectionMatrix.m01 = 0f; ProjectionMatrix.m02 = 0f; ProjectionMatrix.m03 = 0f;
		ProjectionMatrix.m10 = 0f; ProjectionMatrix.m11 = ((2f * near) / (top - bottom)); ProjectionMatrix.m12 = 0f; ProjectionMatrix.m13 = 0f;
		ProjectionMatrix.m20 = ((right + left) / (right - left)); ProjectionMatrix.m21 = ((top + bottom) / (top - bottom)); ProjectionMatrix.m22 = -1f * ((far + near) / (far - near)); ProjectionMatrix.m23 = -1f;
		ProjectionMatrix.m30 = 0f; ProjectionMatrix.m31 = 0f; ProjectionMatrix.m32 = -1f * ((2f * far * near) / (far - near)); ProjectionMatrix.m33 = 0f;
		ProjectionMatrix = ProjectionMatrix.transpose;
	}

	public void OnDrawGizmos()
	{
		UpdateProjection ();
		if (Project)
		{
			for (float x = -3f; x <= 3f; x++)
			{
				for (float y = -3f; y <= 3f; y++)
				{
					for (float z = 0f; z <= 7f; z++)
					{
						Gizmos.color = Color.red;
						var pos = ProjectionMatrix.MultiplyPoint (new Vector3 (x, y, z) * 2f);
						//pos.z = z;
						Gizmos.DrawSphere (pos * scale, 0.025f * scale);
					}
				}
			}
		}
		else
		{
			for (float x = -3f; x <= 3f; x++)
			{
				for (float y = -3f; y <= 3f; y++)
				{
					for (float z = 0f; z <= 7f; z++)
					{
						Gizmos.color = Color.green;
						Gizmos.DrawSphere (new Vector3 (x, y, z) * 2f * scale, 0.125f * scale);
					}
				}
			}
		}
	}
}
