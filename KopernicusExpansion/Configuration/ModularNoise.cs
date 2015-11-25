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
using KopernicusExpansion.Utility.Serialization;
using KopernicusExpansion.Configuration.ModularNoiseOperators;

using UnityEngine;

using LibNoise.Unity;
using LibNoise.Unity.Operator;
using LibNoise.Unity.Generator;

//shorthand for faster typing
using MN = KopernicusExpansion.Effects.PQSMod_ModularNoise;

namespace KopernicusExpansion.Configuration
{
	[RequireConfigType(ConfigType.Node)]
	public class ModularNoise : ModLoader<PQSMod_ModularNoise>, IParserEventSubscriber
	{
		//creation override
		public override void Create ()
		{
			base.Create ();
			mod.SerializationID = SerializedPQSMod.NewSerializationID ();
		}

		[ParserTargetCollection("Noises", optional = false, nameSignificance = NameSignificance.None)]
		public List<NoiseLoader> Noises
		{
			set
			{
				mod.SetProperty ("Noises", value.ToArray());
			}
		}

		[ParserTarget("deformity", optional = true)]
		public NumericParser<double> deformity
		{
			set
			{
				mod.deformity = value.value;
			}
		}

		[ParserTarget("finalNoise", optional = true)]
		public string finalNoise
		{
			set
			{
				mod.finalNoise = value;
			}
		}

		public List<MN_Operator> Operators = new List<MN_Operator> ();

		private void LoadOperators(ConfigNode node)
		{
			foreach (var opNode in node.GetNodes())
			{
				var opType = Type.GetType ("KopernicusExpansion.Configuration.ModularNoiseOperators." + opNode.name.ToUpper());
				if (opType == null)
				{
					Logger.Active.Log ("ModularNoise Operator " + opNode.name + " not recognized");
					continue;
				}
				if (!opType.IsSubclassOf (typeof(MN_Operator)))
				{
					Logger.Active.Log ("ModularNoise Operator " + opNode.name + " is not a valid operator");
					continue;
				}
				MN_Operator op = (MN_Operator)Parser.CreateObjectFromConfigNode (opType, opNode);

				//get default values
				if (opNode.HasValue ("order"))
					int.TryParse (opNode.GetValue ("order"), out op.order);
				if (opNode.HasValue ("applyTo"))
					op.applyTo = opNode.GetValue ("applyTo");

				Operators.Add (op);
			}
		}

		public void Apply(ConfigNode node)
		{
		}
		public void PostApply(ConfigNode node)
		{
			if(node.HasNode("Operators"))
				LoadOperators (node.GetNode("Operators"));

			//sort operators by order
			if(Operators.Count > 0)
			{
				Operators.Sort (delegate(MN_Operator a, MN_Operator b) {
					return a.order.CompareTo(b.order);
				});
			}

			Logger.Active.Log ("ModularNoise Operators:");
			foreach(var op in Operators)
			{
				Logger.Active.Log (op.applyTo + ": " + op.order + " => " + op.GetType ().Name);
			}

			mod.SetProperty("Operators", Operators.ToArray ());
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_ModularNoise : SerializedPQSMod
	{
		//parameters
		public MN_Operator[] Operators = null;
		public NoiseLoader[] Noises = null;

		public double deformity = 0;
		public string finalNoise;

		public override void OnSetup ()
		{
			requirements = PQS.ModiferRequirements.VertexMapCoords;
			GetData ();
		}
		private void GetData()
		{
			Operators = (MN_Operator[])GetProperty ("Operators");
			Noises = (NoiseLoader[])GetProperty ("Noises");

			NoiseInputs.Clear ();
			NoiseOutputs.Clear ();
		}
		public override double GetVertexMinHeight ()
		{
			return 0;
		}
		public override double GetVertexMaxHeight ()
		{
			return deformity;
		}

		private static Dictionary<string, Vector3d> NoiseInputs = new Dictionary<string, Vector3d> ();
		private static Dictionary<string, double> NoiseOutputs = new Dictionary<string, double> ();

		public static Vector3d GetInput(string noiseName)
		{
			if (NoiseInputs.ContainsKey (noiseName))
				return NoiseInputs [noiseName];
			return default(Vector3d);
		}
		public static double GetOutput(string noiseName)
		{
			if (NoiseOutputs.ContainsKey (noiseName))
				return NoiseOutputs [noiseName];
			return 0;
		}
		public static void SetInput(string noiseName, Vector3d input)
		{
			if (NoiseInputs.ContainsKey (noiseName))
				NoiseInputs [noiseName] = input;
		}
		public static void SetOutput(string noiseName, double output)
		{
			if (NoiseOutputs.ContainsKey (noiseName))
				NoiseOutputs [noiseName] = output;
		}

		public override void OnVertexBuildHeight (PQS.VertexBuildData data)
		{
			//run input pass
			foreach(var noise in Noises)
			{
				if (!NoiseInputs.ContainsKey (noise.name))
					NoiseInputs.Add (noise.name, data.directionFromCenter);
				else
					NoiseInputs [noise.name] = data.directionFromCenter;
			}
			var inputData = new MN_Operator_InputData ();
			foreach (var op in Operators)
			{
				op.Input (inputData);
			}

			//run noise pass
			foreach(var noise in Noises)
			{
				Vector3d input = data.directionFromCenter;
				if (NoiseInputs.ContainsKey (noise.name))
					input = NoiseInputs [noise.name];

				double value = noise.Module.GetValue (input);
				if (noise.type != NoiseType.Const)
				{
					//attempt to normalize to 0-1 range
					value += 1;
					value *= 0.5;
				}

				if (!NoiseOutputs.ContainsKey (noise.name))
					NoiseOutputs.Add (noise.name, value);
				else
					NoiseOutputs [noise.name] = value;
			}

			//run output pass
			double lat = data.latitude * (double)Mathf.Rad2Deg;
			double lon = data.longitude * (double)Mathf.Rad2Deg;
			lon += 90; //make longitude range from 0-360 instead of -90-270
			double height = data.vertHeight - sphere.radius;
			var outputData = new MN_Operator_OutputData (lat, lon, height);
			foreach (var op in Operators)
			{
				op.Output (outputData);
			}

			//return final value
			double finalValue = 0;
			foreach(var noise in Noises)
			{
				if (!NoiseOutputs.ContainsKey (noise.name))
					continue;
				if (noise.name == finalNoise)
					finalValue = NoiseOutputs [noise.name];
			}

			data.vertHeight += finalValue * deformity;
		}
	}
}

namespace KopernicusExpansion.Configuration.ModularNoiseOperators
{
	//IO for Operators
	public class MN_Operator_InputData
	{
		public MN_Operator_InputData()
		{

		}
	}
	public class MN_Operator_OutputData
	{
		public readonly double latitude;
		public readonly double longitude;
		public readonly double vertHeight;
		public MN_Operator_OutputData(double lat, double lon, double height)
		{
			this.latitude = lat;
			this.longitude = lon;
			this.vertHeight = height;
		}
	}

	//base operator class
	public abstract class MN_Operator
	{
		public int order = 0;
		public string applyTo = null;

		public virtual void Input (MN_Operator_InputData data)
		{
		}
		public virtual void Output (MN_Operator_OutputData data)
		{
		}
	}

	//combiner modules
	#region combiner modules
	[RequireConfigType(ConfigType.Node)]
	public class ADD : MN_Operator
	{
		[ParserTarget("X", optional = true)]
		private NumericParser<double> XParser
		{
			set
			{
				valueToAdd = value.value;
			}
		}

		[ParserTarget("applyFrom", optional = true)]
		private string applyFrom = null;

		public double valueToAdd = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);

			if (applyFrom != null)
			{
				output += MN.GetOutput (applyFrom);
				output *= 0.5; //average together
			}
			else
			{
				output += valueToAdd;
			}

			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class MULT : MN_Operator
	{
		[ParserTarget("X", optional = true)]
		private NumericParser<double> XParser
		{
			set
			{
				valueToMult = value.value;
			}
		}

		[ParserTarget("applyFrom", optional = true)]
		private string applyFrom = null;

		public double valueToMult = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);

			if (applyFrom != null)
			{
				output *= MN.GetOutput (applyFrom);
			}
			else
			{
				output *= valueToMult;
			}

			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class MIN : MN_Operator
	{
		[ParserTarget("min", optional = true)]
		private NumericParser<double> minParser
		{
			set
			{
				min = value.value;
			}
		}

		[ParserTarget("applyFrom", optional = true)]
		private string applyFrom = null;

		public double min = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);

			if (applyFrom != null)
			{
				var from = MN.GetOutput (applyFrom);
				if (output > from)
					output = from;
			}
			else
			{
				if (output < min)
					output = min;
			}

			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class MAX : MN_Operator
	{
		[ParserTarget("max", optional = true)]
		private NumericParser<double> minParser
		{
			set
			{
				max = value.value;
			}
		}

		[ParserTarget("applyFrom", optional = true)]
		private string applyFrom = null;

		public double max = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);

			if (applyFrom != null)
			{
				var from = MN.GetOutput (applyFrom);
				if (output < from)
					output = from;
			}
			else
			{
				if (output > max)
					output = max;
			}

			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class EXPONENT : MN_Operator
	{
		[ParserTarget("X", optional = true)]
		private NumericParser<double> XParser
		{
			set
			{
				power = value.value;
			}
		}

		[ParserTarget("applyFrom", optional = true)]
		private string applyFrom = null;

		public double power = 0f;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);

			if (applyFrom != null)
			{
				var sign = (output < 0 ? -1 : 1);
				var from = MN.GetOutput (applyFrom);
				output = Math.Abs (Math.Pow (output, from)) * sign;
			}
			else
			{
				var sign = (output < 0 ? -1 : 1);
				output = Math.Abs (Math.Pow (output, power)) * sign;
			}

			MN.SetOutput (applyTo, output);
		}
	}
	#endregion

	//math functions
	#region math functions
	[RequireConfigType(ConfigType.Node)]
	public class ABS : MN_Operator
	{
		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);
			output = Math.Abs (output);
			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class CLAMP : MN_Operator
	{
		[ParserTarget("min", optional = false)]
		private NumericParser<double> minParser
		{
			set
			{
				min = value.value;
			}
		}
		[ParserTarget("max", optional = false)]
		private NumericParser<double> maxParser
		{
			set
			{
				max = value.value;
			}
		}
		public double min = 0;
		public double max = 0;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);
			if (output < min)
				output = min;
			if (output > max)
				output = max;
			MN.SetOutput (applyTo, output);
		}
	}
	#endregion

	//curve operators
	#region curve operators
	[RequireConfigType(ConfigType.Node)]
	public class CURVE : MN_Operator
	{
		[ParserTarget("Curve", optional = false)]
		private FloatCurveParser curveParser
		{
			set
			{
				curve = value.curve;
			}
		}
		public FloatCurve curve;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);
			output *= (double)curve.Evaluate ((float)output);
			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class DEFORMITYCURVE : MN_Operator
	{
		[ParserTarget("DeformityCurve", optional = false)]
		private FloatCurveParser deformityCurveParser
		{
			set
			{
				deformityCurve = value.curve;
			}
		}
		public FloatCurve deformityCurve;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);
			output *= (double)deformityCurve.Evaluate ((float)data.vertHeight);
			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class LATITUDECURVE : MN_Operator
	{
		[ParserTarget("LatitudeCurve", optional = false)]
		private FloatCurveParser latitudeCurveParser
		{
			set
			{
				latitudeCurve = value.curve;
			}
		}
		public FloatCurve latitudeCurve;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);
			output *= (double)latitudeCurve.Evaluate ((float)data.latitude);
			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class LONGITUDECURVE : MN_Operator
	{
		[ParserTarget("LongitudeCurve", optional = false)]
		private FloatCurveParser longitudeCurveParser
		{
			set
			{
				longitudeCurve = value.curve;
			}
		}
		public FloatCurve longitudeCurve;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = MN.GetOutput (applyTo);
			output *= (double)longitudeCurve.Evaluate ((float)data.longitude);
			MN.SetOutput (applyTo, output);
		}
	}
	#endregion

	//input operators
	#region input operators
	[RequireConfigType(ConfigType.Node)]
	public class SCALE : MN_Operator
	{
		[ParserTarget("XScale", optional = true)]
		private NumericParser<double> XScaleParser
		{
			set
			{
				XScale = value.value;
			}
		}
		[ParserTarget("YScale", optional = true)]
		private NumericParser<double> YScaleParser
		{
			set
			{
				YScale = value.value;
			}
		}
		[ParserTarget("ZScale", optional = true)]
		private NumericParser<double> ZScaleParser
		{
			set
			{
				ZScale = value.value;
			}
		}
		public double XScale = 1;
		public double YScale = 1;
		public double ZScale = 1;

		public override void Input (MN_Operator_InputData data)
		{
			var input = MN.GetInput (applyTo);
			input.Scale (new Vector3d (XScale, YScale, ZScale));
			input.Normalize ();
			MN.SetInput (applyTo, input);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class TURBULENCE : MN_Operator, IParserEventSubscriber
	{
		[ParserTarget("seed", optional = true)]
		private NumericParser<int> seedParser
		{
			set
			{
				seed = value.value;
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
		[ParserTarget("lacunarity", optional = true)]
		private NumericParser<double> lacunarityParser
		{
			set
			{
				lacunarity = value.value;
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

		[ParserTarget("power", optional = true)]
		private NumericParser<double> powerParser
		{
			set
			{
				power = value.value;
			}
		}
		[ParserTarget("roughness", optional = true)]
		private NumericParser<int> roughnessParser
		{
			set
			{
				roughness = value.value;
			}
		}

		public int seed = 0;
		public double frequency = 1;
		public double lacunarity = 1.5;
		public double persistence = 0.5;
		public double power = 1;
		public int roughness = 1;

		private System.Random rand;
		private Perlin pX;
		private Perlin pY;
		private Perlin pZ;

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
		}
		public void PostApply(ConfigNode node)
		{
			rand = new System.Random (seed);
			pX = new Perlin (frequency, lacunarity, persistence, roughness, rand.Next (), QualityMode.Medium);
			pY = new Perlin (frequency, lacunarity, persistence, roughness, rand.Next (), QualityMode.Medium);
			pZ = new Perlin (frequency, lacunarity, persistence, roughness, rand.Next (), QualityMode.Medium);
		}

		public override void Input (MN_Operator_InputData data)
		{
			var input = MN.GetInput (applyTo);

			double x = input.x;
			double y = input.y;
			double z = input.z;

			double x2 = pX.GetValue (x + pertubeX1, y + pertubeX2, z + pertubeX3) * power;
			double y2 = pY.GetValue (x + pertubeY1, y + pertubeY2, z + pertubeY3) * power;
			double z2 = pZ.GetValue (x + pertubeZ1, y + pertubeZ2, z + pertubeZ3) * power;

			input = new Vector3d (x + x2, y + y2, z + z2).normalized;

			MN.SetInput (applyTo, input);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class ROTATE : MN_Operator, IParserEventSubscriber
	{
		[ParserTarget("XAngle", optional = true)]
		private NumericParser<double> XAngleParser
		{
			set
			{
				XAngle = value.value;
			}
		}
		[ParserTarget("YAngle", optional = true)]
		private NumericParser<double> YAngleParser
		{
			set
			{
				YAngle = value.value;
			}
		}
		[ParserTarget("ZAngle", optional = true)]
		private NumericParser<double> ZAngleParser
		{
			set
			{
				ZAngle = value.value;
			}
		}
		private double XAngle = 0;
		private double YAngle = 0;
		private double ZAngle = 0;

		private Matrix4x4D rotationMatrix;

		public void Apply(ConfigNode node)
		{
		}
		public void PostApply(ConfigNode node)
		{
			rotationMatrix = new Matrix4x4D ();

			var xc = Math.Cos(XAngle * Mathf.Deg2Rad);
			var yc = Math.Cos(YAngle * Mathf.Deg2Rad);
			var zc = Math.Cos(ZAngle * Mathf.Deg2Rad);
			var xs = Math.Sin(XAngle * Mathf.Deg2Rad);
			var ys = Math.Sin(YAngle * Mathf.Deg2Rad);
			var zs = Math.Sin(ZAngle * Mathf.Deg2Rad);
			//x = 0
			//y = 1
			//z = 2
			rotationMatrix.m00 = ys * xs * zs + yc * zc;
			rotationMatrix.m10 = xc * zs;
			rotationMatrix.m20 = ys * zc - yc * xs * zs;
			rotationMatrix.m01 = ys * xs * zc - yc * zs;
			rotationMatrix.m11 = xc * zc;
			rotationMatrix.m21 = -yc * xs * zc - ys * zs;
			rotationMatrix.m02 = -ys * xc;
			rotationMatrix.m12 = xs;
			rotationMatrix.m22 = yc * xc;
		}

		public override void Input (MN_Operator_InputData data)
		{
			var input = MN.GetInput (applyTo);

			var nx = (rotationMatrix.m00 * input.x) + (rotationMatrix.m10 * input.y) + (rotationMatrix.m20 * input.z);
			var ny = (rotationMatrix.m01 * input.x) + (rotationMatrix.m11 * input.y) + (rotationMatrix.m21 * input.z);
			var nz = (rotationMatrix.m02 * input.x) + (rotationMatrix.m12 * input.y) + (rotationMatrix.m22 * input.z);

			MN.SetInput (applyTo, new Vector3d (nx, ny, nz));
		}
	}
	#endregion

	//selector modules
	#region selector modules
	[RequireConfigType(ConfigType.Node)]
	public class BLEND : MN_Operator
	{
		[ParserTarget("firstNoise", optional = false)]
		private string firstNoise = null;

		[ParserTarget("secondNoise", optional = false)]
		private string secondNoise = null;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = (MN.GetOutput (applyTo) + 1) * 0.5;
			var output1 = MN.GetOutput (firstNoise);
			var output2 = MN.GetOutput (secondNoise);

			output = Utils.LerpD (output1, output2, output);

			MN.SetOutput (applyTo, output);
		}
	}
	[RequireConfigType(ConfigType.Node)]
	public class SELECT : MN_Operator
	{
		[ParserTarget("firstNoise", optional = false)]
		private string firstNoise = null;

		[ParserTarget("secondNoise", optional = false)]
		private string secondNoise = null;

		[ParserTarget("falloff", optional = true)]
		private NumericParser<double> falloffParser
		{
			set
			{
				var bs = max - min;
				falloff = (value.value > bs / 2) ? bs / 2 : value.value;
			}
		}
		private double falloff = 0.2;

		[PreApply]
		[ParserTarget("min", optional = false)]
		private NumericParser<double> minParser
		{
			set
			{
				min = value.value;
			}
		}
		[PreApply]
		[ParserTarget("max", optional = false)]
		private NumericParser<double> maxParser
		{
			set
			{
				max = value.value;
			}
		}
		private double min = 0;
		private double max = 0;

		public override void Output (MN_Operator_OutputData data)
		{
			var output = (MN.GetOutput (applyTo) + 1) * 0.5; //2
			var output1 = MN.GetOutput (firstNoise); //0
			var output2 = MN.GetOutput (secondNoise); //1

			if (falloff > 0.0)
			{
				if (output < (min - falloff))
				{
					MN.SetOutput (applyTo, output1);
					return;
				}
				if (output < (min + falloff))
				{
					var lc = (min - falloff);
					var uc = (min + falloff);
					var t = Utils.MapCubicCurve((output - lc) / (uc - lc));
					var ret = Utils.LerpD(output1,
						output2, t);
					MN.SetOutput (applyTo, ret);
					return;
				}
				if (output < (max - falloff))
				{
					MN.SetOutput (applyTo, output2);
					return;
				}
				if (output < (max + falloff))
				{
					var lc = (max - falloff);
					var uc = (max + falloff);
					var t = Utils.MapCubicCurve((output - lc) / (uc - lc));
					var ret = Utils.LerpD(output2,
						output1, t);
					MN.SetOutput (applyTo, ret);
					return;
				}
				MN.SetOutput (applyTo, output1);
				return;
			}
			if (output < min || output > max)
			{
				MN.SetOutput (applyTo, output1);
				return;
			}
		}
	}
	#endregion
}

