using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Configuration;

using UnityEngine;

namespace KopernicusExpansion.Configuration
{
	[ExternalParserTarget("ChildSpheres")]
	public class ChildSphereLoader : ExternalParserTargetLoader, IParserEventSubscriber
	{
		public ChildSphereLoader ()
		{

		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{
			List<ChildSpherePQSLoader> pqses = null;

			//load pqses from nodes
			foreach (var childNode in node.GetNodes())
			{
				try
				{
					var pqs = Parser.CreateObjectFromConfigNode<ChildSpherePQSLoader> (childNode);
					pqses.Add (pqs);
				}
				catch(Exception e)
				{
					Logger.Active.LogException (e);
				}
			}

			int i = 0;
			foreach (var pqsLoader in pqses)
			{
				//set parent
				pqsLoader.pqsVersion.transform.parent = generatedBody.pqsVersion.transform;

				//set name
				pqsLoader.pqsVersion.name = generatedBody.pqsVersion.name + "ChildSphere" + i;
				pqsLoader.pqsVersion.gameObject.name = generatedBody.pqsVersion.name + "ChildSphere" + i;
				pqsLoader.pqsVersion.transform.name = generatedBody.pqsVersion.name + "ChildSphere" + i;

				//set radius
				if (pqsLoader.radius < 0)
					pqsLoader.pqsVersion.radius = generatedBody.celestialBody.Radius;
				else
					pqsLoader.pqsVersion.radius = pqsLoader.radius;

				//add to secondary renderers
				var cbTransform = generatedBody.GetComponentsInChildren<PQSMod_CelestialBodyTransform> (true).Where (mod => mod.transform.parent == generatedBody.pqsVersion.transform).FirstOrDefault ();
				cbTransform.planetFade.secondaryRenderers.Add (pqsLoader.pqsVersion.gameObject);

				i++;
			}
		}
	}

	public class ChildSpherePQSLoader : PQSLoader
	{
		public ChildSpherePQSLoader() : base()
		{
		}

		[ParserTarget("radius")]
		private NumericParser<double> radiusParser
		{
			set
			{
				radius = value.value;
			}
		}
		public double radius = -1;
	}
}

