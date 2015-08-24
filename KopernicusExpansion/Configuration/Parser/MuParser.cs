using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus.Configuration;

using UnityEngine;

namespace KopernicusExpansion.Configuration
{
	[RequireConfigType(ConfigType.Value)]
	public class MuParser : IParsable
	{
		public GameObject value;

		public void SetFromString (string s)
		{
			// If there's a model, import it
			if (GameDatabase.Instance.ExistsModel (s))
			{
				value = GameDatabase.Instance.GetModel (s);
				return;
			}

			// Otherwise, set the value to null
			value = null;
		}

		// Default constructor
		public MuParser()
		{
		}

		// Initializing constructor
		public MuParser(GameObject value)
		{
			this.value = value;
		}
	}
}

