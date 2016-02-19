using System;

using Kopernicus.Configuration;

using KopernicusExpansion.Utility.Noise;

using UnityEngine;

using LibNoise.Unity;
using LibNoise.Unity.Operator;
using LibNoise.Unity.Generator;

namespace KopernicusExpansion.Configuration
{
	//generic noise configurator
	[RequireConfigType(ConfigType.Node)]
	public class NoiseLoader : IParserEventSubscriber
	{
		[ParserTarget("name", optional = true)]
		public string name;

		[ParserTarget("type", optional = false)]
		private EnumParser<NoiseType> noiseTypeParser
		{
			set
			{
				type = value.value;
			}
		}
		[ParserTarget("seed", optional = true)]
		private string seedParser
		{
			set
			{
				if (!int.TryParse (value, out seed))
				{
					//if it can't parse the seed into an int, use the string's hashcode
					seed = value.GetHashCode ();
				}
			}
		}
		[ParserTarget("octaves", optional = true)]
		private NumericParser<int> octavesParser
		{
			set
			{
				octaves = value.value;
			}
		}
		[ParserTarget("frequency", optional = true)]
		private NumericParser<double> frequencyParser
		{
			set
			{
				frequency = value.value;
			}
		}
		[ParserTarget("persistence", optional = true)]
		private NumericParser<double> persistenceParser
		{
			set
			{
				persistence = value.value;
			}
		}
		[ParserTarget("lacunarity", optional = true)]
		private NumericParser<double> lacunarityParser
		{
			set
			{
				lacunarity = value.value;
			}
		}
		[ParserTarget("mu", optional = true)]
		private NumericParser<double> muParser
		{
			set
			{
				mu = value.value;
			}
		}
		[ParserTarget("displacement", optional = true)]
		private NumericParser<double> displacementParser
		{
			set
			{
				displacement = value.value;
			}
		}
		[ParserTarget("voronoiUseDistance", optional = true)]
		private NumericParser<bool> voronoiUseDistanceParser
		{
			set
			{
				voronoiUseDistance = value.value;
			}
		}
		[ParserTarget("constantValue", optional = true)]
		private NumericParser<double> constantValueParser
		{
			set
			{
				constantValue = value.value;
			}
		}

		public ModuleBase Module;

		public NoiseType type = NoiseType.Perlin;
		private int seed = 0;
		private int octaves = 4;
		private double frequency = 1;
		private double persistence = 0.5;
		private double lacunarity = 1.5;
		private double mu = 1.0146;
		private double displacement = 0;
		private bool voronoiUseDistance = true;
		private double constantValue = 0;

		public void Apply(ConfigNode node)
		{
		}
		public void PostApply(ConfigNode node)
		{
			switch (type)
			{
			case NoiseType.Perlin:
				var perlin = new Perlin ();
				perlin.Quality = QualityMode.High;
				perlin.Seed = seed;
				perlin.OctaveCount = octaves;
				perlin.Frequency = frequency;
				perlin.Lacunarity = lacunarity;
				perlin.Persistence = persistence;
				Module = perlin;
				break;
			case NoiseType.ExDistPerlin:
				var exDistPerlin = new ExDistPerlin ();
				exDistPerlin.Quality = QualityMode.High;
				exDistPerlin.Seed = seed;
				exDistPerlin.OctaveCount = octaves;
				exDistPerlin.Frequency = frequency;
				exDistPerlin.Lacunarity = lacunarity;
				exDistPerlin.Persistence = persistence;
				exDistPerlin.Mu = mu;
				Module = exDistPerlin;
				break;
			case NoiseType.Billow:
				var billow = new Billow ();
				billow.Quality = QualityMode.High;
				billow.Seed = seed;
				billow.OctaveCount = octaves;
				billow.Frequency = frequency;
				billow.Lacunarity = lacunarity;
				billow.Persistence = persistence;
				Module = billow;
				break;
			case NoiseType.RidgedMultiFractal:
				var ridgedMultiFractal = new RiggedMultifractal ();
				ridgedMultiFractal.Quality = QualityMode.High;
				ridgedMultiFractal.Seed = seed;
				ridgedMultiFractal.OctaveCount = octaves;
				ridgedMultiFractal.Frequency = frequency;
				ridgedMultiFractal.Lacunarity = lacunarity;
				Module = ridgedMultiFractal;
				break;
			case NoiseType.Voronoi:
				var voronoi = new Voronoi ();
				voronoi.Seed = seed;
				voronoi.UseDistance = voronoiUseDistance;
				voronoi.Displacement = displacement;
				voronoi.Frequency = frequency;
				Module = voronoi;
				break;
			case NoiseType.Const:
				var constant = new Const ();
				constant.Value = constantValue;
				Module = constant;
				break;
			}
		}
	}
	public enum NoiseType
	{
		Perlin,
		ExDistPerlin,
		Billow,
		RidgedMultiFractal,
		Voronoi,
		Const
	}
}

