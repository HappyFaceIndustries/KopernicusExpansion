using System;
using System.Linq;
using System.Diagnostics;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;
using Debug = UnityEngine.Debug;

/**
 * This is a modified C# port of Mikola Lysenko's "SurfaceNets in JavaScript"
 * Original JavaScript version written by Mikola Lysenko under an MIT license:
 * https://github.com/mikolalysenko/mikolalysenko.github.com/blob/master/Isosurface/js/surfacenets.js
 * Based on S.F. Gibson, "Constrained Elastic Surface Nets". (1998) MERL Tech Report.
 * http://www.merl.com/publications/docs/TR99-24.pdf
 **/
public class SurfaceNetsMesh
{
	public Vector3[] vertices;
	public Vector3[] normals;
	public int[] triangles;

	//edge data is organized into many arrays, one for each face of the cube.
	//x faces have all the corners and 4 edges. z faces have 2 edges each going perpendicular to the y axis. y faces have no edges/corners.
	//0 is xNeg, 1 is yNeg, 2 is zNeg, 3 is xPos, 4 is yPos, 5 is zPos
	public uint[][] edgeData = new uint[6][];
}
public static class SurfaceNets
{
	public const int CHUNK_SIZE = 32;

	//edge data packing
	/**
	 * Edge data is packed as follows:
	 * 0|11111|11111|11111|1111111111111111
	 * empty, z, y, x, vertex index
	 **/
	public static void PackEdgeData(out uint edgeDataEntry, int xPos, int yPos, int zPos, int vertexIndex)
	{
		edgeDataEntry = 0;
		uint index = (uint)(vertexIndex & 0x0000ffff); //prune index to just first 16 bits
		edgeDataEntry |= index; //add index to entry, goes in empty first 16 bits
		uint x = (uint)xPos;
		uint y = (uint)yPos;
		uint z = (uint)zPos;
		x &= 0x1f; //prune x to the first 5 bits. 0x1f == 00011111
		y &= 0x1f; //do same for y
		z &= 0x1f; //do same for z
		x <<= 16; //shift over 16 bits (16 bit vertex index)
		y <<= 21; //shift over 21 bits (16 bit vertex index + 5 bit x)
		z <<= 26; //shift over 26 bits (16 bit vertex index + 5 bit x + 5 bit y)
		edgeDataEntry |= x;
		edgeDataEntry |= y;
		edgeDataEntry |= z;
	}
	public static void UnpackEdgeData(uint edgeDataEntry, out int xPos, out int yPos, out int zPos, out int vertexIndex)
	{
		vertexIndex = (int)edgeDataEntry & 0x0000ffff;
		xPos = (int)(edgeDataEntry >> 16) & 0x1f;
		yPos = (int)(edgeDataEntry >> 21) & 0x1f;
		zPos = (int)(edgeDataEntry >> 26) & 0x1f;
	}

	private static int[] cubeEdges = new int[24];
	private static int[] edgeTable = new int[256];
	private static bool tablesInitialized = false;
	private static void PopulateTables()
	{
		//init cubeEdges table
		int k = 0;
		for (int i = 0; i < 8; i++)
		{
			for (int j = 1; j <= 4; j <<= 1)
			{
				var p = i ^ j;
				if (i <= p)
				{
					cubeEdges [k++] = i;
					cubeEdges [k++] = p;
				}
			}
		}

		//init intersection table (edgeTable)
		for (var i = 0; i < 256; i++)
		{
			var em = 0;
			for (var j = 0; j < 24; j += 2)
			{
				var a = ((i & (1 << cubeEdges [j])) == 0 ? false : true);
				var b = ((i & (1 << cubeEdges [j + 1])) == 0 ? false : true);
				em |= a != b ? (1 << (j >> 1)) : 0;
			}
			edgeTable [i] = em;
		}
	}

	public static SurfaceNetsMesh Mesh(float[] data, int[] dims, float smoothing = 1f, Stopwatch stopwatch = null)
	{
		long generationTime = 0;
		if (stopwatch != null)
		{
			stopwatch.Reset ();
			stopwatch.Start ();
		}

		if (!tablesInitialized)
		{
			PopulateTables ();
			tablesInitialized = true;
		}

		if (stopwatch != null)
		{
			stopwatch.Stop ();
			Debug.Log ("Table population completed in " + stopwatch.GetElapsedNanoseconds () + "μs");
			generationTime += stopwatch.GetElapsedNanoseconds ();
			stopwatch.Reset ();
			stopwatch.Start ();
		}

		List<Vector3> verts = new List<Vector3> ();
		List<int> tris = new List<int> ();
		int n = 0;
		int[] R = new int[]{ 1, (dims [0] + 1), (dims [0] + 1) * (dims [1] + 1) };
		float[] grid = new float[8];
		int bufferNumber = 1;
		var buffer = new int[R [2] * 2];

		smoothing = Mathf.Clamp01 (smoothing);

		List<uint>[] edgeData = new List<uint>[6];
		for(int i = 0; i < 6; i++)
		{
			edgeData [i] = new List<uint> ();
		}

		if (stopwatch != null)
		{
			stopwatch.Stop ();
			Debug.Log ("Variable initialization completed in " + stopwatch.GetElapsedNanoseconds () + "μs");
			generationTime += stopwatch.GetElapsedNanoseconds ();
			stopwatch.Reset ();
			stopwatch.Start ();
		}

		//iterate over voxels
		int[] x = new int[3];
		for (x [2] = 0; x [2] < dims [2] - 1; x [2]++, n += dims [0], bufferNumber ^= 1, R [2] = -R [2])
		{
			//m is the pointer into the buffer, our current position inside the buffer.
			var m = 1 + (dims [0] + 1) * (1 + bufferNumber * (dims [1] + 1));

			for (x [1] = 0; x [1] < dims [1] - 1; x [1]++, n++, m += 2)
			{
				for (x [0] = 0; x [0] < dims [0] - 1; x [0]++, n++, m++)
				{
					//read in 8 values around this vertex and store them
					//also calculate mask
					int mask = 0;
					int g = 0;
					int idx = n;
					for (int k = 0; k < 2; k++, idx += dims [0] * (dims [1] - 2))
					{
						for (int j = 0; j < 2; j++, idx += dims [0] - 2)
						{
							for (int i = 0; i < 2; i++, g++, idx++)
							{
								var p = data [idx];
								grid [g] = p;
								mask |= (p <= 0) ? (1 << g) : 0;
							}
						}
					}

					//terminate if cell does not intersect boundary
					if (mask == 0 || mask == 0xff)
					{
						continue;
					}

					//get edge mask and create empty vertex
					var edgeMask = edgeTable[mask];
					Vector3 vert = Vector3.zero;
					int edgeCount = 0;

					//smoothing
					if(smoothing > 0f)
					{
						//calculate for all 12 edges of cube
						for (int i = 0; i < 12; i++)
						{
							//skip if it is not crossed
							if ((edgeMask & (1 << i)) == 0)
							{
								continue;
							}

							//if it is crossed, increment number of edges
							edgeCount++;

							//find point of intersecion
							int e0 = cubeEdges[i << 1];
							int e1 = cubeEdges [(i << 1) + 1];
							float g0 = grid [e0];
							float g1 = grid [e1];
							float t = g0 - g1;

							if (Mathf.Abs (t) > 1e-6)
							{
								t = g0 / t;
							}
							else
							{
								continue;
							}

							for (int j = 0, k = 1; j < 3; j++, k <<= 1)
							{
								var a = e0 & k;
								var b = e1 & k;
								if (a != b)
								{
									vert [j] += (a != 0 ? (1f - t) : t);
								}
								else
								{
									vert [j] += (a != 0 ? 1f : 0f);
								}
							}
						}
					}

					//calculate which faces of the chunk this voxel is on and put it in a flag
					int chunkEdgeFlag = 0;
					for (int i = 0, cm1 = 0x01, cm2 = 0x10; i < 3; i++, cm1 <<= 1, cm2 <<= 1) 
					{
						if (x [i] <= 0)
						{
							chunkEdgeFlag |= cm1;
						}
						else if (x [i] >= dims [i] - 2)
						{
							chunkEdgeFlag |= cm2;
						}
					}

					//if this voxel is on a face, add it's coordinate/vertex data to the edgeData array
					if (chunkEdgeFlag != 0)
					{
						uint edgeDataEntry;
						PackEdgeData (out edgeDataEntry, x [0], x [1], x [2], verts.Count);
						for (int i = 0; i < 3; i++) 
						{
							if (x [i] <= 0)
							{
								edgeData [i].Add (edgeDataEntry);
								//break;
							}
							else if (x [i] >= dims [i] - 2)
							{
								edgeData [i + 3].Add (edgeDataEntry);
								//break;
							}
						}
					}

					//average edge intersections and add to vert
					float s = ((edgeCount <= 0) ? 0f : (1f / (float)edgeCount));
					s *= smoothing;
					for (int i = 0; i < 3; i++)
					{
						vert [i] = (float)x [i] + (s * vert [i]);
					}
					
					//add vert index to buffer, add vert to verts
					buffer[m] = verts.Count;
					verts.Add (vert);

					//compute triangles
					for(int i = 0; i < 3; i++)
					{
						//skip uneccesary edge faces
						var cm = 0x10 << i;
						if ((chunkEdgeFlag & cm) == cm)
						{
							continue;
						}

						if ((edgeMask & (1 << i)) == 0)
						{
							continue;
						}

						var iu = (i + 1) % 3;
						var iv = (i + 2) % 3;

						if (x [iu] == 0 || x [iv] == 0)
						{
							continue;
						}

						var du = R [iu];
						var dv = R [iv];

						if ((mask & 1) == 0)
						{
							//push quad as two triangles
							tris.Add (buffer [m]);
							tris.Add (buffer [m - du]);
							tris.Add (buffer [m - du - dv]);
							tris.Add (buffer [m]);
							tris.Add (buffer [m - du - dv]);
							tris.Add (buffer [m - dv]);
						}
						else
						{
							//push reversed quad as two triangles
							tris.Add (buffer [m]);
							tris.Add (buffer [m - dv]);
							tris.Add (buffer [m - du - dv]);
							tris.Add (buffer [m]);
							tris.Add (buffer [m - du - dv]);
							tris.Add (buffer [m - du]);
						}
					}
				}
			}
		}

		if (stopwatch != null)
		{
			stopwatch.Stop ();
			Debug.Log ("Meshing completed in " + stopwatch.GetElapsedNanoseconds () + "μs");
			generationTime += stopwatch.GetElapsedNanoseconds ();
			stopwatch.Reset ();
			stopwatch.Start ();
		}

		SurfaceNetsMesh mesh = new SurfaceNetsMesh ();
		mesh.vertices = verts.ToArray ();
		mesh.triangles = tris.ToArray ();
		mesh.edgeData[0] = edgeData[0].ToArray ();
		mesh.edgeData[1] = edgeData[1].ToArray ();
		mesh.edgeData[2] = edgeData[2].ToArray ();
		mesh.edgeData[3] = edgeData[3].ToArray ();
		mesh.edgeData[4] = edgeData[4].ToArray ();
		mesh.edgeData[5] = edgeData[5].ToArray ();

		if (stopwatch != null)
		{
			stopwatch.Stop ();
			Debug.Log ("Array conversion completed in " + stopwatch.GetElapsedNanoseconds () + "μs");
			generationTime += stopwatch.GetElapsedNanoseconds ();
			stopwatch.Reset ();

			Debug.Log ("SurfaceNets mesh generated in " + generationTime + "μs total with " + mesh.triangles.Length + " tris and " + mesh.vertices.Length + " vertices");
		}


		return mesh;
	}
}
