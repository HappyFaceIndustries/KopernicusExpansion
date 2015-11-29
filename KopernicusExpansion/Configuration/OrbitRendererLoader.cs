using System;
using System.Linq;
using System.Reflection;
using System.Collections.Generic;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;

using KopernicusExpansion.Effects;
using KopernicusExpansion.Configuration;

using UnityEngine;

namespace KopernicusExpansion.Configuration
{
	[ExternalParserTarget("OrbitRenderer", parentNodeName = "Orbit")]
	public class OrbitRendererLoader : ExternalParserTargetLoader, IParserEventSubscriber
	{
		private bool drawIcon = true;
		private bool drawApsisIcons = false;
		private bool drawOrbitLine = true;

		[ParserTarget("drawIcon", optional = true)]
		private NumericParser<bool> DrawIcon
		{
			set
			{
				drawIcon = value.value;
			}
		}
		[ParserTarget("drawApsisIcons", optional = true)]
		private NumericParser<bool> DrawApsisIcons
		{
			set
			{
				drawApsisIcons = value.value;
			}
		}
		[ParserTarget("drawOrbitLine", optional = true)]
		private NumericParser<bool> DrawOrbitLine
		{
			set
			{
				drawOrbitLine = value.value;
			}
		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{
			if(drawIcon)
			{
				if (drawApsisIcons) //11
				{
					generatedBody.orbitRenderer.drawIcons = OrbitRenderer.DrawIcons.ALL;
				}
				else //10
				{
					generatedBody.orbitRenderer.drawIcons = OrbitRenderer.DrawIcons.OBJ;
				}
			}
			else
			{
				if (drawApsisIcons) //01
				{
					generatedBody.orbitRenderer.drawIcons = OrbitRenderer.DrawIcons.OBJ_PE_AP;
				}
				else //00
				{
					generatedBody.orbitRenderer.drawIcons = OrbitRenderer.DrawIcons.NONE;
				}
			}

			if (!drawOrbitLine)
			{
				generatedBody.orbitDriver.enabled = false;
			}
		}
	}
}

