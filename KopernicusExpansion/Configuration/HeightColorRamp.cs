using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Configuration;

using UnityEngine;

using Gradient = Kopernicus.Configuration.Gradient;

namespace KopernicusExpansion.Configuration
{
	[RequireConfigType(ConfigType.Node)]
	public class HeightColorRamp : ModLoader, IParserEventSubscriber
	{
		public HeightColorRamp ()
		{
			_mod = new GameObject ("HeightColorRamp").AddComponent<PQSMod_SubsurfaceOceans> ();
			_mod.transform.parent = Kopernicus.Utility.Deactivator;
			base.mod = _mod;
			_mod.simplex = new Simplex (0, 3, 0.5, 20);
			_mod.Ramp = new Gradient ();
			_mod.Ramp.Add (0f, Color.white);
			_mod.NoiseRamp = new Gradient ();
			_mod.NoiseRamp.Add (0f, Color.white);
		}

		private PQSMod_HeightColorRamp _mod;

		[ParserTarget("ColorRamp", optional = false)]
		public Gradient ColorRamp
		{
			set
			{
				_mod.Ramp = value;
			}
		}
		[ParserTarget("NoiseColorRamp", optional = false)]
		public Gradient NoiseColorRamp
		{
			set
			{
				_mod.NoiseRamp = value;
			}
		}
		[ParserTarget("blend", optional = true)]
		public NumericParser<float> blend
		{
			set
			{
				_mod.blend = value.value;
			}
		}
		[ParserTarget("BaseColorBias", optional = true)]
		public NumericParser<float> BaseColorBias
		{
			set
			{
				_mod.BaseColorBias = value.value;
			}
		}

		[PreApply]
		[ParserTarget("seed", optional = true)]
		public NumericParser<int> seed
		{
			set
			{
				_mod.simplex.seed = value.value;
			}
		}
		[ParserTarget("frequency", optional = true)]
		public NumericParser<double> frequency
		{
			set
			{
				_mod.simplex.frequency = value.value;
			}
		}
		[ParserTarget("persistence", optional = true)]
		public NumericParser<double> persistence
		{
			set
			{
				_mod.simplex.persistence = value.value;
			}
		}
		[ParserTarget("octaves", optional = true)]
		public NumericParser<int> octaves
		{
			set
			{
				_mod.simplex.octaves = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{

		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_HeightColorRamp : PQSMod
	{
		public Gradient Ramp;
		public Gradient NoiseRamp;
		public Simplex simplex;
		public float BaseColorBias = 0.2f;
		public float blend = 1.0f;

		public override void OnSetup ()
		{
			requirements = PQS.ModiferRequirements.MeshColorChannel;
		}

		public override void OnVertexBuild (PQS.VertexBuildData data)
		{
			float height = (float)(data.vertHeight - sphere.radius);

			var color = Ramp.ColorAt (height);
			var noiseColor = Ramp.ColorAt (height);

			double noise = simplex.noiseNormalized (data.directionFromCenter);
			float noiseAmount = Mathf.Clamp01 ((float)noise - BaseColorBias);

			data.vertColor = Color.Lerp (data.vertColor, Color.Lerp (color, noiseColor, noiseAmount), blend);
		}
	}
}