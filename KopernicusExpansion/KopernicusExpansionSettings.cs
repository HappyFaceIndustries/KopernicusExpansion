using System;
using UnityEngine;

namespace KopernicusExpansion
{
	public static class Settings
	{
		private static ConfigNode node;
		public static string ConfigPath
		{
			get
			{
				return KSPUtil.ApplicationRootPath + "GameData/KopernicusExpansion/Settings.cfg";
			}
		}
		public static void Load()
		{
			node = ConfigNode.Load (ConfigPath);
			if (node == null)
			{
				node = CreateNewSettingsConfig ();
			}

			//set defaults
			AllowEditors = false;
			AllowGasGiants = true;
			AllowGasGiantAnimation = true;
			AllowAdvancedCometShader = true;
			AllowCometAnimation = true;
			AllowCreatures = true;
			AllowCreatureGore = true;
			AllowFootprints = true;
			MaximumFootprints = 256;

			if (node == null)
				return;

			//load settings
			if (!node.HasValue ("mode"))
				AllowEditors = false;
			AllowEditors = node.GetValue("mode").ToLower() == "editor";

			bool allowGasGiants = AllowGasGiants;
			bool.TryParse (node.GetValue ("allowProceduralGasGiants"), out allowGasGiants);
			AllowGasGiants = allowGasGiants;

			bool allowAdvComets = AllowAdvancedCometShader;
			bool.TryParse (node.GetValue ("allowAdvancedCometShader"), out allowAdvComets);
			AllowAdvancedCometShader = allowAdvComets;

			bool allowAnimatedComets = AllowCometAnimation;
			bool.TryParse (node.GetValue ("allowAnimatedComets"), out allowAnimatedComets);
			AllowCometAnimation = allowAnimatedComets;

			bool allowGasGiantAnimation = AllowGasGiantAnimation;
			bool.TryParse (node.GetValue ("allowAnimatedProceduralGasGiants"), out allowGasGiantAnimation);
			AllowGasGiantAnimation = allowGasGiantAnimation;

			bool allowRefractiveAtmospheres = AllowRefractiveAtmospheres;
			bool.TryParse (node.GetValue ("allowRefractiveAtmospheres"), out allowRefractiveAtmospheres);
			AllowRefractiveAtmospheres = allowRefractiveAtmospheres;

			bool allowCreatures = AllowCreatures;
			bool.TryParse (node.GetValue ("allowCreatures"), out allowCreatures);
			AllowCreatures = allowCreatures;

			bool allowCreatureGore = AllowCreatureGore;
			bool.TryParse (node.GetValue ("allowCreatureGore"), out allowCreatureGore);
			AllowCreatureGore = allowCreatureGore;

			bool allowFootprints = AllowFootprints;
			bool.TryParse (node.GetValue ("allowFootprints"), out allowFootprints);
			AllowFootprints = allowFootprints;

			int maximumFootprints = MaximumFootprints;
			int.TryParse (node.GetValue ("maximumFootprints"), out maximumFootprints);
			MaximumFootprints = maximumFootprints;
			if (MaximumFootprints < 0)
				MaximumFootprints = 0;
			if (MaximumFootprints > 2056)
				MaximumFootprints = 2056;
		}
		private static ConfigNode CreateNewSettingsConfig()
		{
			ConfigNode node = new ConfigNode ();
			node.AddValue ("mode", "normal");
			node.AddValue ("allowProceduralGasGiants", true);
			node.AddValue ("allowAdvancedCometShader", true);
			node.AddValue ("allowAnimatedComets", true);
			node.AddValue ("allowAnimatedProceduralGasGiants", true);
			node.AddValue ("allowRefractiveAtmospheres", true);
			node.AddValue ("allowCreatureGore", true);
			node.AddValue ("allowCreatures", true);
			node.Save (ConfigPath);
			return node;
		}


		//Settings
		public static bool AllowEditors
		{
			get;
			private set;
		}
		public static bool AllowGasGiants
		{
			get;
			private set;
		}
		public static bool AllowAdvancedCometShader
		{
			get;
			private set;
		}
		public static bool AllowCometAnimation {
			get;
			private set;
		}
		public static bool AllowGasGiantAnimation
		{
			get;
			private set;
		}
		public static bool AllowRefractiveAtmospheres
		{
			get;
			private set;
		}
		public static bool AllowCreatures
		{
			get;
			private set;
		}
		public static bool AllowCreatureGore
		{
			get;
			private set;
		}
		public static bool AllowFootprints
		{
			get;
			private set;
		}
		public static int MaximumFootprints
		{
			get;
			private set;
		}
	}
}

namespace KopernicusExpansion.Utility
{
	[KSPAddon(KSPAddon.Startup.Instantly, false)]
	public class SettingsLoader : MonoBehaviour
	{
		void Start()
		{
			Settings.Load ();
		}
	}
}