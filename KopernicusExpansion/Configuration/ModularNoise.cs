using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion;
using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Configuration;
using KopernicusExpansion.Configuration.ModularNoise;

using UnityEngine;

using LibNoise.Unity;
using LibNoise.Unity.Operator;
using LibNoise.Unity.Generator;

namespace Kopernicus.Configuration.ModLoader
{
	[RequireConfigType(ConfigType.Node)]
	public class ModularNoise : ModLoader, IParserEventSubscriber
	{
		//constructor
		public ModularNoise()
		{
			_mod = new GameObject ("ModularNoise").AddComponent<PQSMod_ModularNoise> ();
			_mod.transform.parent = Kopernicus.Utility.Deactivator;
			base.mod = _mod;
		}

		private PQSMod_ModularNoise _mod;

		[ParserTarget("Noise", optional = false)]
		public NoiseLoader Noise
		{
			set
			{
				_mod.noise = value.Module;
			}
		}
		[ParserTarget("deformity", optional = true)]
		public NumericParser<double> deformity
		{
			set
			{
				_mod.deformity = value.value;
			}
		}

		[ParserTargetCollection("Operators", optional = true, typePrefix = "KopernicusExpansion.Configuration.MultipurposeNoise.", nameSignificance = NameSignificance.Type)]
		public List<MN_Operator> Operators;

		public void Apply(ConfigNode node)
		{
		}
		public void PostApply(ConfigNode node)
		{
			//sort operators by order
			Operators.Sort (delegate(MN_Operator a, MN_Operator b) {
				return a.order.CompareTo(b.order);
			});

			_mod.Operators = Operators.ToArray ();
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_ModularNoise : PQSMod
	{
		//operators
		public MN_Operator[] Operators;

		//noise
		public ModuleBase noise;
		public double deformity = 0;

		public override void OnVertexBuildHeight (PQS.VertexBuildData data)
		{
			var input = new MN_Operator_InputData (data.directionFromCenter);
			foreach (var op in Operators)
			{
				op.Input (input);
			}

			var noiseValue = noise.GetValue (input.inputVector);

			var height = data.vertHeight - sphere.radius;
			var output = new MN_Operator_OutputData (noiseValue, data.latitude, data.longitude, height);
			foreach (var op in Operators)
			{
				op.Output (output);
			}
			data.vertHeight += output.noiseValue * deformity;
		}
	}
}

namespace KopernicusExpansion.Configuration.ModularNoise
{
	//generic noise configurator
	[RequireConfigType(ConfigType.Node)]
	public class NoiseLoader : IParserEventSubscriber
	{
		[ParserTarget("name", optional = true)]
		public string name;

		[ParserTarget("type", optional = false)]
		public EnumParser<NoiseType> noiseTypeParser
		{
			set
			{
				type = value.value;
			}
		}
		[ParserTarget("seed", optional = true)]
		public NumericParser<int> seedParser
		{
			set
			{
				seed = value.value;
			}
		}
		[ParserTarget("octaves", optional = true)]
		public NumericParser<int> octavesParser
		{
			set
			{
				octaves = value.value;
			}
		}
		[ParserTarget("frequency", optional = true)]
		public NumericParser<double> frequencyParser
		{
			set
			{
				frequency = value.value;
			}
		}
		[ParserTarget("persistence", optional = true)]
		public NumericParser<double> persistenceParser
		{
			set
			{
				persistence = value.value;
			}
		}
		[ParserTarget("lacunarity", optional = true)]
		public NumericParser<double> lacunarityParser
		{
			set
			{
				lacunarity = value.value;
			}
		}
		[ParserTarget("displacement", optional = true)]
		public NumericParser<double> displacementParser
		{
			set
			{
				displacement = value.value;
			}
		}
		[ParserTarget("voronoiUseDistance", optional = true)]
		public NumericParser<bool> voronoiUseDistanceParser
		{
			set
			{
				voronoiUseDistance = value.value;
			}
		}
		[ParserTarget("constantValue", optional = true)]
		public NumericParser<double> constantValueParser
		{
			set
			{
				constantValue = value.value;
			}
		}

		public ModuleBase Module;

		private NoiseType type = NoiseType.Perlin;
		private int seed = 0;
		private int octaves = 4;
		private double frequency = 1;
		private double persistence = 0.5;
		private double lacunarity = 1.5;
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
			case NoiseType.Simplex:
				var simplex = new SimplexMB ();
				simplex.Seed = seed;
				simplex.OctaveCount = octaves;
				simplex.Frequency = frequency;
				simplex.Persistence = persistence;
				Module = simplex;
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
		Billow,
		RidgedMultiFractal,
		Simplex,
		Voronoi,
		Const
	}

	//ModuleBase inheriting wrapper of Simplex class
	public class SimplexMB : ModuleBase
	{
		//constructors
		public SimplexMB() : base(0)
		{
			simplex = new Simplex ();
			simplex.seed = cachedSeed;
		}
		public SimplexMB(double frequency, double persistence, int octaves, int seed) : base(0)
		{
			simplex = new Simplex ();
			Seed = seed;
			Frequency = frequency;
			Persistence = persistence;
			OctaveCount = octaves;
		}

		//properties
		public int Seed
		{
			get
			{
				return cachedSeed;
			}
			set
			{
				simplex.seed = value;
				cachedSeed = value;
			}
		}
		public double OctaveCount
		{
			get
			{
				return simplex.persistence;
			}
			set
			{
				simplex.persistence = Math.Max(0, value);
			}
		}
		public double Frequency
		{
			get
			{
				return simplex.frequency;
			}
			set
			{
				simplex.frequency = Math.Max(0, value);
			}
		}
		public double Persistence
		{
			get
			{
				return simplex.persistence;
			}
			set
			{
				simplex.persistence = Math.Max(0, value);
			}
		}

		private int cachedSeed = 0;
		private Simplex simplex;

		//overridden methods
		public override double GetValue (double x, double y, double z)
		{
			return simplex.noise (x, y, z);
		}
	}

	//base operator class
	public abstract class MN_Operator
	{
		[ParserTarget("order", optional = false)]
		public NumericParser<int> orderParser
		{
			set
			{
				order = value.value;
			}
		}
		public int order = 0;

		public virtual void Input (MN_Operator_InputData data)
		{
		}
		public virtual void Output (MN_Operator_OutputData data)
		{
		}
	}

	public class MN_Operator_InputData
	{
		public Vector3d inputVector;
		public MN_Operator_InputData(Vector3d input)
		{
			this.inputVector = input;
		}
	}
	public class MN_Operator_OutputData
	{
		public double noiseValue;
		public readonly double latitude;
		public readonly double longitude;
		public readonly double vertHeight;
		public MN_Operator_OutputData(double noise, double lat, double lon, double height)
		{
			this.noiseValue = noise;
			this.latitude = lat;
			this.longitude = lon;
			this.vertHeight = height;
		}
	}

	//basic math operators
	[RequireConfigType(ConfigType.Node)]
	public class ADD : MN_Operator
	{
		[ParserTarget("X", optional = false)]
		public NumericParser<double> XParser
		{
			set
			{
				valueToAdd = value.value;
			}
		}
		public double valueToAdd = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue += valueToAdd;
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class MULT : MN_Operator
	{
		[ParserTarget("X", optional = false)]
		public NumericParser<double> XParser
		{
			set
			{
				valueToMult = value.value;
			}
		}
		public double valueToMult = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue *= valueToMult;
		}
	}

	//other math functions
	[RequireConfigType(ConfigType.Node)]
	public class ABS : MN_Operator
	{
		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue = Math.Abs(data.noiseValue);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class CLAMP : MN_Operator
	{
		[ParserTarget("min", optional = false)]
		public NumericParser<double> minParser
		{
			set
			{
				min = value.value;
			}
		}
		[ParserTarget("max", optional = false)]
		public NumericParser<double> maxParser
		{
			set
			{
				max = value.value;
			}
		}
		public double min = 0f;
		public double max = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			if (data.noiseValue < min)
				data.noiseValue = min;
			if (data.noiseValue > max)
				data.noiseValue = max;
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class MIN : MN_Operator
	{
		[ParserTarget("min", optional = false)]
		public NumericParser<double> minParser
		{
			set
			{
				min = value.value;
			}
		}
		public double min = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			if (data.noiseValue < min)
				data.noiseValue = min;
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class MAX : MN_Operator
	{
		[ParserTarget("max", optional = false)]
		public NumericParser<double> minParser
		{
			set
			{
				max = value.value;
			}
		}
		public double max = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			if (data.noiseValue > max)
				data.noiseValue = max;
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class ZEROBASED : MN_Operator
	{
		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue = (data.noiseValue + 1) * 0.5;
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class EXPONENT : MN_Operator
	{
		[ParserTarget("X", optional = false)]
		public NumericParser<double> XParser
		{
			set
			{
				power = value.value;
			}
		}
		public double power = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue = Math.Abs(Math.Pow (data.noiseValue, power)) * Math.Sign(data.noiseValue);
		}
	}

	//curve operators
	[RequireConfigType(ConfigType.Node)]
	public class CURVE : MN_Operator
	{
		[ParserTarget("Curve", optional = false)]
		public FloatCurveParser curveParser
		{
			set
			{
				curve = value.curve;
			}
		}
		public FloatCurve curve;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue *= (double)curve.Evaluate ((float)data.noiseValue);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class DEFORMITYCURVE : MN_Operator
	{
		[ParserTarget("DeformityCurve", optional = false)]
		public FloatCurveParser deformityCurveParser
		{
			set
			{
				deformityCurve = value.curve;
			}
		}
		public FloatCurve deformityCurve;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue *= (double)deformityCurve.Evaluate ((float)data.vertHeight);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class LATITUDECURVE : MN_Operator
	{
		[ParserTarget("LatitudeCurve", optional = false)]
		public FloatCurveParser latitudeCurveParser
		{
			set
			{
				latitudeCurve = value.curve;
			}
		}
		public FloatCurve latitudeCurve;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue *= (double)latitudeCurve.Evaluate ((float)data.latitude);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class LONGITUDECURVE : MN_Operator
	{
		[ParserTarget("LongitudeCurve", optional = false)]
		public FloatCurveParser longitudeCurveParser
		{
			set
			{
				longitudeCurve = value.curve;
			}
		}
		public FloatCurve longitudeCurve;

		public override void Output (MN_Operator_OutputData data)
		{
			data.noiseValue *= (double)longitudeCurve.Evaluate ((float)data.longitude);
		}
	}

	//input operators
	[RequireConfigType(ConfigType.Node)]
	public class SCALE : MN_Operator
	{
		[ParserTarget("XScale", optional = false)]
		public NumericParser<double> XScaleParser
		{
			set
			{
				XScale = value.value;
			}
		}
		[ParserTarget("YScale", optional = false)]
		public NumericParser<double> YScaleParser
		{
			set
			{
				YScale = value.value;
			}
		}
		[ParserTarget("ZScale", optional = false)]
		public NumericParser<double> ZScaleParser
		{
			set
			{
				ZScale = value.value;
			}
		}
		public double XScale = 0f;
		public double YScale = 0f;
		public double ZScale = 0f;

		public override void Input (MN_Operator_InputData data)
		{
			data.inputVector.Scale(new Vector3d(XScale, YScale, ZScale));
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class TURBULENCE : MN_Operator, IParserEventSubscriber
	{
		[PreApply]
		[ParserTarget("seed", optional = false)]
		public NumericParser<int> seedParser
		{
			set
			{
				seed = value.value;
			}
		}

		[ParserTarget("frequency", optional = false)]
		public NumericParser<double> frequencyParser
		{
			set
			{
				frequency = value.value;
			}
		}
		[ParserTarget("persistence", optional = false)]
		public NumericParser<double> persistenceParser
		{
			set
			{
				persistence = value.value;
			}
		}

		[ParserTarget("power", optional = false)]
		public NumericParser<double> powerParser
		{
			set
			{
				power = value.value;
			}
		}
		[ParserTarget("roughness", optional = false)]
		public NumericParser<int> roughnessParser
		{
			set
			{
				roughness = value.value;
			}
		}

		public int seed = 0;
		public double frequency = 1;
		public double persistence = 0.5;
		public double power = 1;
		public int roughness = 1;

		private System.Random rand;
		private SimplexMB sX;
		private SimplexMB sY;
		private SimplexMB sZ;

		const double pertubeX1 = 0.189422607421875;
		const double pertubeX2 = 0.99371337890625;
		const double pertubeX3 = 0.478164672851563;

		const double pertubeY1 = 0.404647827148438;
		const double pertubeY2 = 0.276611328125;
		const double pertubeY3 = 0.923049926757813;

		const double pertubeZ1 = 0.82122802734375;
		const double pertubeZ2 = 0.171096801757813;
		const double pertubeZ3 = 0.684280395507813;

		public void Apply(ConfigNode node)
		{
			rand = new System.Random (seed);
		}
		public void PostApply(ConfigNode node)
		{
			sX = new SimplexMB (frequency, persistence, roughness, rand.Next ());
			sY = new SimplexMB (frequency, persistence, roughness, rand.Next ());
			sZ = new SimplexMB (frequency, persistence, roughness, rand.Next ());
		}

		public override void Input (MN_Operator_InputData data)
		{
			double x = data.inputVector.x;
			double y = data.inputVector.y;
			double z = data.inputVector.z;

			double x2 = sX.GetValue (x + pertubeX1, y + pertubeX2, z + pertubeX3) * power;
			double y2 = sY.GetValue (x + pertubeY1, y + pertubeY2, z + pertubeY3) * power;
			double z2 = sZ.GetValue (x + pertubeZ1, y + pertubeZ2, z + pertubeZ3) * power;

			data.inputVector = new Vector3d (x + x2, y + y2, z + z2).normalized;
		}
	}
}

