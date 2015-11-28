using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;

using UnityEngine;

namespace KopernicusExpansion.Utility
{
	public class ObjectPool : MonoBehaviour
	{
		public int Size
		{get; private set;}
		public bool CanGrow
		{get; set;}

		public GameObject Prefab
		{get; private set;}

		private Queue<GameObject> Pool;

		public void Initialize()
		{
			Pool = new Queue<GameObject> (Size);
			for (int i = 0; i < Size; i++)
			{
				GameObject obj = (GameObject)Instantiate (Prefab);
				obj.transform.SetParent (transform);
				obj.SetActive (false);
				Pool.Enqueue (obj);
			}
		}

		public GameObject GetObject()
		{
			foreach(var obj in Pool)
			{
				if(!obj.activeInHierarchy)
				{
					obj.SetActive (true);
					return obj;
				}
			}

			if(CanGrow)
			{
				if(!Prefab)
				{
					Debug.LogWarning("Tried to instantiate a pool object but prefab is missing! ("+name+")");
				}
				GameObject obj = (GameObject)Instantiate(Prefab);
				obj.transform.SetParent(transform);
				obj.SetActive(false);
				Pool.Enqueue(obj);
				Size++;

				obj.SetActive (true);
				return obj;
			}

			return null;
		}
		public bool ContainsObject(GameObject obj)
		{
			return Pool.Contains (obj);
		}
		public bool DisableObject(GameObject obj)
		{
			if (!Pool.Contains (obj))
				return false;

			obj.SetActive(false);
			obj.transform.parent = transform;
			return true;
		}

		public void SetSize(int size)
		{
			Size = size;
		}
		public void SetPrefab(GameObject prefab)
		{
			Prefab = prefab;
		}
		public void SetCanGrow(bool canGrow)
		{
			CanGrow = canGrow;
		}
		public void SetPoolName(string value)
		{
			name = value;
		}
	}
}

