using UnityEngine;
using System.Collections;

public class VoxelTerrainParent : MonoBehaviour
{
	public Vector3 Chunks = Vector3.one;
	public float Smoothing = 1f;
	public float Threshold = 0.5f;
	public float Frequency = 0.025f;
	public float Scale = 1f;
	public float HillChaosFactor = 0.25f;
	public bool SmoothNormals = true;
	public Material Material;

	[ContextMenu("Generate Chunks")]
	public void GenerateChunks()
	{
		ClearChunks ();

		VoxelTerrainChunk[,,] chunkMap = new VoxelTerrainChunk[Mathf.FloorToInt (Chunks.x), Mathf.FloorToInt (Chunks.y), Mathf.FloorToInt (Chunks.z)];

		for (int x = 0; x < Chunks.x; x++)
		{
			for (int y = 0; y < Chunks.y; y++)
			{
				for (int z = 0; z < Chunks.z; z++)
				{
					var ChunkSize = (SurfaceNets.CHUNK_SIZE + 1);
					GameObject chunk = new GameObject ("Chunk");
					chunk.transform.parent = transform;
					chunk.transform.localPosition = new Vector3 ((float)x, (float)y, (float)z) * ChunkSize * ((ChunkSize - 2f) / ChunkSize);
					chunk.AddComponent<MeshFilter> ();
					chunk.AddComponent<MeshCollider> ();
					var mr = chunk.AddComponent<MeshRenderer> ();
					mr.sharedMaterial = Material;
					var vm3 = chunk.AddComponent<VoxelTerrainChunk> ();
					vm3.ChunkPosition = new Vector3 ((float)x, (float)y, (float)z) * ChunkSize * ((ChunkSize - 2f) / ChunkSize);
					vm3.Smoothing = Smoothing;
					vm3.Scale = Scale;
					vm3.Frequency = Frequency;
					vm3.Threshold = Threshold;
					vm3.HillChaosFactor = HillChaosFactor;
					vm3.GenerateMesh ();

					chunkMap [x, y, z] = vm3;
				}
			}
		}

		for (int x = 0; x < Chunks.x; x++)
		{
			for (int y = 0; y < Chunks.y; y++)
			{
				for (int z = 0; z < Chunks.z; z++)
				{
					var moore = GetMooreNeighborhood (chunkMap, x, y, z);
					var chunk = moore [1, 1, 1];

					for (int i = 0; i < 6; i++)
					{
						var currEdgeData = chunk.edgeData [i];
						for(int j = 0; j < currEdgeData.Length; j++)
						{
							int xP;
							int yP;
							int zP;
							int vI;
							SurfaceNets.UnpackEdgeData (currEdgeData [j], out xP, out yP, out zP, out vI);

							int oppIndex;
							var opp = GetOppositeChunk (i, moore, out oppIndex);
							if (opp != null)
							{
								var oppEdgeData = opp.edgeData [oppIndex];
								for (int k = 0; k < oppEdgeData.Length; k++)
								{
									int xP2;
									int yP2;
									int zP2;
									int vI2;
									SurfaceNets.UnpackEdgeData (oppEdgeData [k], out xP2, out yP2, out zP2, out vI2);
									int rank2 = 0;
									if (xP2 == xP)
										rank2++;
									if (yP2 == yP)
										rank2++;
									if (zP2 == zP)
										rank2++;
									if (rank2 == 2)
									{
										var averageNormal = chunk.normals [vI] + opp.normals [vI2];
										averageNormal /= 2;
										chunk.normals [vI] = averageNormal;
										opp.normals [vI2] = averageNormal;
									}
								}
							}
						}
					}
				}
			}
		}

//		for (int x = 0; x < Chunks.x; x++)
//		{
//			for (int y = 0; y < Chunks.y; y++)
//			{
//				for (int z = 0; z < Chunks.z; z++)
//				{
//					var chunk = chunkMap [x, y, z];
//					for(int i = 0; i < 6; i += 3)
//					{
//						var edgeData = chunk.snMesh.edgeData [i];
//						for (int j = 0; j < edgeData.Length; j++)
//						{
//							int xP;
//							int yP;
//							int zP;
//							int vI;
//							SurfaceNets.UnpackEdgeData (edgeData [j], out xP, out yP, out zP, out vI);
//							if (xP % 2 == 0)
//								xP -= 1;
//							if (yP % 2 == 0)
//								yP -= 1;
//							if (zP % 2 == 0)
//								zP -= 1;
//							chunk.snMesh.vertices [vI] = new Vector3 (xP, yP, zP);
//						}
//					}
//				}
//			}
//		}

		foreach (var chunk in chunkMap)
		{
			if(SmoothNormals)
				chunk.mesh.normals = chunk.snMesh.normals;
//			chunk.mesh.vertices = chunk.snMesh.vertices;
			MeshFilter mf = chunk.GetComponent<MeshFilter> ();
			MeshCollider mc = chunk.GetComponent<MeshCollider> ();
			mf.sharedMesh = chunk.mesh;
			mc.sharedMesh = chunk.mesh;
		}
	}

	private SurfaceNetsMesh GetOppositeChunk(int sideIndex, SurfaceNetsMesh[,,] moore, out int oppositeIndex)
	{
		oppositeIndex = sideIndex;
		if (sideIndex >= 3)
			oppositeIndex %= 3;
		else
			oppositeIndex += 3;
		SurfaceNetsMesh opp = null;
		switch (sideIndex)
		{
		case 0:
			opp = moore [0, 1, 1];
			break;
		case 1:
			opp = moore [1, 0, 1];
			break;
		case 2:
			opp = moore [1, 1, 0];
			break;
		case 3:
			opp = moore [2, 1, 1];
			break;
		case 4:
			opp = moore [1, 2, 1];
			break;
		case 5:
			opp = moore [1, 1, 2];
			break;
		default:
			break;
		}
		return opp;
	}
	private SurfaceNetsMesh[,,] GetMooreNeighborhood(VoxelTerrainChunk[,,] chunkMap, int x, int y, int z)
	{
		var chunk = chunkMap [x, y, z].snMesh;
		//generate moore map
		SurfaceNetsMesh[,,] moore = new SurfaceNetsMesh[3, 3, 3];
		moore [1, 1, 1] = chunk;
		for (int x2 = -1; x2 <= 1; x2++)
		{
			for (int y2 = -1; y2 <= 1; y2++)
			{
				for (int z2 = -1; z2 <= 1; z2++)
				{
					//skip middle
					if (x2 + y2 + z2 == 0)
						continue;

					SurfaceNetsMesh neighborChunk = null;
					try
					{
						neighborChunk = chunkMap [x + x2, y + y2, z + z2].snMesh;
					}
					//silent catch
					catch{}
					moore [x2 + 1, y2 + 1, z2 + 1] = neighborChunk;
				}
			}
		}
		return moore;
	}

	[ContextMenu("Clear Chunks")]
	public void ClearChunks()
	{
		foreach (var chunk in GetComponentsInChildren<VoxelTerrainChunk>())
		{
			DestroyImmediate (chunk.gameObject);
		}
	}
}
