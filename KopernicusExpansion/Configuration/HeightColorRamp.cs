using System;
using System.Linq;
using System.Reflection;
using System.Collections;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Utility;
using KopernicusExpansion.Configuration;
using KopernicusExpansion.Utility.Serialization;

using UnityEngine;

using LibNoise.Unity;

namespace Kopernicus.Configuration.ModLoader
{
	[RequireConfigType(ConfigType.Node)]
	public class HeightColorRamp : ModLoader, IParserEventSubscriber
	{
		//constructor
		public HeightColorRamp ()
		{
			var modObject = new GameObject ("HeightColorRamp");
			_mod = modObject.AddComponent<PQSMod_HeightColorRamp> ();
			_mod.transform.parent = Kopernicus.Utility.Deactivator;
			var tempRamp = new ColorRamp ();
			tempRamp.Add (Color.white, Color.black, 0f);
			_mod.SetProperty ("Ramp", tempRamp);
			base.mod = _mod;
		}

		private PQSMod_HeightColorRamp _mod;

		[ParserTarget("ColorRamp", optional = true)]
		public ColorRamp ColorRamp
		{
			set
			{
				_mod.SetProperty ("Ramp", value);
			}
		}

		[ParserTarget("Noise", optional = true)]
		public NoiseLoader Noise
		{
			set
			{
				_mod.SetProperty ("Noise", value.Module);
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

		void IParserEventSubscriber.Apply(ConfigNode node)
		{

		}
		void IParserEventSubscriber.PostApply(ConfigNode node)
		{

		}
	}

	[RequireConfigType(ConfigType.Node)]
	public class ColorRamp : IParserEventSubscriber, IEnumerable<ColorRamp.ColorRampKeyframe>
	{
		//constructor
		public ColorRamp()
		{
			r = new FloatCurve();
			g = new FloatCurve();
			b = new FloatCurve();

			rn = new FloatCurve();
			gn = new FloatCurve();
			bn = new FloatCurve();

			keyframes = new List<ColorRampKeyframe> ();
		}

		FloatCurve r;
		FloatCurve g;
		FloatCurve b;

		FloatCurve rn;
		FloatCurve gn;
		FloatCurve bn;

		private List<ColorRampKeyframe> keyframes;
		public ColorRampKeyframe this[int index]
		{
			get
			{
				return keyframes [index];
			}
		}
		public IEnumerator<ColorRampKeyframe> GetEnumerator()
		{
			return keyframes.GetEnumerator ();
		}
		IEnumerator IEnumerable.GetEnumerator()
		{
			return keyframes.GetEnumerator();
		}

		public Color ColorAt(float height)
		{
			var color = new Color (r.Evaluate (height), g.Evaluate (height), b.Evaluate (height));
			return color;
		}
		public Color NoiseAt(float height)
		{
			var noise = new Color (rn.Evaluate (height), gn.Evaluate (height), bn.Evaluate (height));
			return noise;
		}

		public void Add(Color color, Color noise, float height)
		{
			this.Add (new ColorRampKeyframe (color, noise, height));
		}
		public void Add(ColorRampKeyframe key)
		{
			r.Add (key.height, key.color.r);
			g.Add (key.height, key.color.g);
			b.Add (key.height, key.color.b);

			rn.Add (key.height, key.noise.r);
			gn.Add (key.height, key.noise.g);
			bn.Add (key.height, key.noise.b);

			keyframes.Add (key);
		}

		public bool Is32 = false;
		[ParserTarget("Is32", optional = true)]
		public NumericParser<bool> Is32Parser
		{
			set
			{
				Is32 = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{
			foreach (ConfigNode.Value value in node.values)
			{
				float height;
				if (float.TryParse (value.name, out height))
				{
					string[] splitString = value.value.Split (new char[]{ '|' }, 2, StringSplitOptions.RemoveEmptyEntries);
					if (Is32)
					{
						var colorParser = new Color32Parser();

						colorParser.SetFromString (splitString [0]);
						var color = colorParser.value;

						colorParser.SetFromString (splitString [1]);
						var noise = colorParser.value;

						Add (color, noise, height);
					}
					else
					{
						var colorParser = new ColorParser();

						colorParser.SetFromString (splitString [0]);
						var color = colorParser.value;

						colorParser.SetFromString (splitString [1]);
						var noise = colorParser.value;

						Add (color, noise, height);
					}
				}
			}
		}
		public void PostApply(ConfigNode node)
		{
		}

		public struct ColorRampKeyframe
		{
			public Color color;
			public Color noise;
			public float height;
			public ColorRampKeyframe(Color color, Color noise, float height)
			{
				this.color = color;
				this.noise = noise;
				this.height = height;
			}

			public override string ToString ()
			{
				return "ColorRamp.ColorRampKeyframe (" + height + ": " + color.ToString () + " -> " + noise.ToString () + ")";
			}
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_HeightColorRamp : SerializedPQSMod
	{
		private ColorRamp __Ramp;
		public ColorRamp Ramp
		{
			get
			{
				if (__Ramp == null)
					__Ramp = (ColorRamp)GetProperty ("Ramp");
				return __Ramp;
			}
		}
		private ModuleBase __Noise;
		public ModuleBase Noise
		{
			get
			{
				if (__Noise == null)
					__Noise = (ModuleBase)GetProperty ("Noise");
				return __Noise;
			}
		}

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
			var noiseColor = Ramp.NoiseAt (height);

			double noise = 0;
			if(Noise != null)
			{
				noise = (Noise.GetValue (data.directionFromCenter) + 1) * 0.5;
			}
			float noiseAmount = Mathf.Clamp01 ((float)noise - BaseColorBias);

			data.vertColor = Color.Lerp (data.vertColor, Color.Lerp (color, noiseColor, noiseAmount), blend);
		}
	}
}