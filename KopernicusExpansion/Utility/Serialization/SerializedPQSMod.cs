using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using UnityEngine;

namespace KopernicusExpansion.Utility.Serialization
{
	[Serializable]
	public class SerializedPQSMod : PQSMod
	{
		//static values
		private static Dictionary<string, Dictionary<string, object>> _properties = new Dictionary<string, Dictionary<string, object>>();

		public static string NewSerializationID()
		{
			return Guid.NewGuid ().ToString ();
		}

		//this is because SerializationID is not public
		[SerializeField]
		public string SerializationID;

		//Properties
		private Dictionary<string, object> Properties
		{
			get
			{
				//return null if our ID is null
				if (string.IsNullOrEmpty (SerializationID))
				{
					Debug.LogError ("SerializationID is null");
					return null;
				}
				//if there is no entry, add it
				if (!_properties.ContainsKey (this.SerializationID))
				{
					_properties.Add (SerializationID, new Dictionary<string, object> ());
				}
				return _properties [SerializationID];
			}
		}
		public void SetProperty(string name, object value)
		{
			if (!Properties.ContainsKey (name))
				Properties.Add (name, value);
			else
				Properties [name] = value;
		}
		public object GetProperty(string name)
		{
			if (!Properties.ContainsKey (name))
				return null;
			else
				return Properties [name];
		}
	}
}

