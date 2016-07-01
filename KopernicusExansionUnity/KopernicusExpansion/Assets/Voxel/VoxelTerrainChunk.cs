using UnityEngine;
using System.Collections;
using System.Diagnostics;
using Debug = UnityEngine.Debug;

public class VoxelTerrainChunk : MonoBehaviour
{
	public float Smoothing = 1f;
	public float Threshold = 0.5f;
	public float Frequency = 0.025f;
	public Vector3 ChunkPosition;
	public float Scale = 1f;
	public float HillChaosFactor = 0.25f;

	public bool Override = false;

	public SurfaceNetsMesh snMesh;
	[HideInInspector]
	public Mesh mesh;

	[ContextMenu("Generate")]
	public void GenerateMesh()
	{
		MeshFilter mf = GetComponent<MeshFilter> ();
		MeshCollider mc = GetComponent<MeshCollider> ();
		Stopwatch stopwatch = new Stopwatch ();

		stopwatch.Reset ();
		stopwatch.Start ();
		float[] data = new float[(SurfaceNets.CHUNK_SIZE + 1) * (SurfaceNets.CHUNK_SIZE + 1) * (SurfaceNets.CHUNK_SIZE + 1)];
		PopulateData (data);
		stopwatch.Stop ();
		Debug.Log ("Data generated in " + stopwatch.GetElapsedNanoseconds () + "μs");

		snMesh = SurfaceNets.Mesh (data, new int[]{(SurfaceNets.CHUNK_SIZE + 1), (SurfaceNets.CHUNK_SIZE + 1), (SurfaceNets.CHUNK_SIZE + 1)}, Smoothing, stopwatch);

		stopwatch.Reset ();
		stopwatch.Start ();
		mesh = new Mesh ();
		mesh.vertices = snMesh.vertices;
		mesh.triangles = snMesh.triangles;
		mesh.RecalculateBounds ();
		mesh.RecalculateNormals ();
		snMesh.normals = mesh.normals;
		stopwatch.Stop ();
		Debug.Log ("Unity mesh generated in " + stopwatch.GetElapsedNanoseconds () + "μs");

		stopwatch.Reset ();
		stopwatch.Start ();
		Color[] colors = new Color[mesh.vertexCount];
		for (int i = 0; i < colors.Length; i++)
		{
			colors [i] = Color.white;
		}
		Color[] rankColors = new Color[] {
			Color.white,
			Color.green,
			Color.yellow,
			Color.red
		};
		for(int i = 0; i < 6; i++)
		{
			for(int j = 0; j < snMesh.edgeData[i].Length; j++)
			{
				int x;
				int y;
				int z;
				int vI;
				SurfaceNets.UnpackEdgeData (snMesh.edgeData [i] [j], out x, out y, out z, out vI);
				int rank = 0;
				if (x == 0 || x == (SurfaceNets.CHUNK_SIZE - 1))
					rank += 1;
				if (y == 0 || y == (SurfaceNets.CHUNK_SIZE - 1))
					rank += 1;
				if (z == 0 || z == (SurfaceNets.CHUNK_SIZE - 1))
					rank += 1;
				colors [vI] = rankColors [rank];
			}
		}
		//mesh.colors = colors;
		stopwatch.Stop ();
		Debug.Log ("Mesh edge colors generated in " + stopwatch.GetElapsedNanoseconds () + "μs");

		if(Override)
		{
			stopwatch.Reset ();
			stopwatch.Start ();
			mf.sharedMesh = mesh;
			stopwatch.Stop ();
			Debug.Log ("Mesh assigned in " + stopwatch.GetElapsedNanoseconds () + "μs");
			stopwatch.Reset ();
			stopwatch.Start ();
			if (mc != null)
				mc.sharedMesh = mesh;
			stopwatch.Stop ();
			Debug.Log ("Collidion mesh generated in " + stopwatch.GetElapsedNanoseconds () + "μs");
		}
	}
	private void PopulateData(float[] data)
	{
		var ChunkSize = SurfaceNets.CHUNK_SIZE + 1;
		for (int x = 0; x < ChunkSize; x++)
		{
			for (int y = 0; y < ChunkSize; y++)
			{
				for (int z = 0; z < ChunkSize; z++)
				{
					int index = x + ChunkSize * (y + ChunkSize * z);

					var sampleX = (x + ChunkPosition.x) * Frequency * Scale;
					//var sampleY = (y + ChunkPosition.y) * Frequency * Scale;
					var sampleZ = (z + ChunkPosition.z) * Frequency * Scale;
					float noise = 0f;
					float ampl = 1f;
					float freq = 1f;
					float totalAmpl = 0f;
					for (int i = 0; i < 2; i++)
					{
						totalAmpl += ampl;
						//noise += SimplexNoise.Noise (sampleX * freq, sampleY * freq, sampleZ * freq) * ampl;
						noise += Mathf.PerlinNoise(sampleX * freq, sampleZ * freq) * ampl; //temporary use of built in function
						freq *= 3f;
						ampl *= 0.333f;
					}
					noise /= totalAmpl;
					float sub = ((((float)y + ChunkPosition.y)/* - (float)ChunkSize*/) / ((float)ChunkSize * HillChaosFactor));
					data [index] = noise - sub;
//					data[index] = (sampleY <= ChunkSize / 2) ? 1f : 0f;
					//float sX = Mathf.Abs (((float)x + ChunkPosition.x) - (float)(ChunkSize - 2));
					//float sY = Mathf.Abs (((float)y + ChunkPosition.y) - (float)(ChunkSize - 2));
					//float sZ = Mathf.Abs (((float)z + ChunkPosition.z) - (float)(ChunkSize - 2));
					//Vector3 pos = new Vector3 (sX, sY, sZ);
					//data [index] = sY + sX + sZ >= 32f ? 0f : 1f;
					//data[index] = sY >= 0.1f ? 0f : 1f;
					//data[index] = (Mathf.Clamp01 (pos.sqrMagnitude - 22f * 22f) * -1f) + 1f;
				}
			}
		}
	}
}
