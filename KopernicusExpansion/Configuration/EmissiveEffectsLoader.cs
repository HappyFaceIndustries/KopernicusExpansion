using System;
using System.Linq;
using System.Collections.Generic;

using KopernicusExpansion;
using KopernicusExpansion.Effects;
using KopernicusExpansion.Resources;

using Kopernicus;
using Kopernicus.Constants;
using Kopernicus.Configuration;
using Kopernicus.Configuration.ModLoader;

using UnityEngine;

#pragma warning disable 0414

namespace KopernicusExpansion.Configuration
{
	[ExternalParserTarget("EmissiveOverlay", parentNodeName = "ScaledVersion")]
	public class EmissiveOverlayLoader : ExternalParserTargetLoader, IParserEventSubscriber
	{
		//constructor
		public EmissiveOverlayLoader ()
		{
		}

		private Material scaledMaterial;

		[ParserTarget("emissiveMap", optional = false)]
		private Texture2DParser emissiveMap
		{
			set{ scaledMaterial.SetTexture ("_EmissiveMap", value.value); }
		}
		[ParserTarget("color", optional = false)]
		private ColorParser color
		{
			set{ scaledMaterial.SetColor ("_Color", value.value); }
		}
		[ParserTarget("brightness", optional = true)]
		private NumericParser<float> brightness
		{
			set{ scaledMaterial.SetFloat ("_Brightness", value.value); }
		}
		[ParserTarget("transparency", optional = true)]
		private NumericParser<float> transparency
		{
			set{ scaledMaterial.SetFloat ("_Transparency", value.value); }
		}

		public void Apply(ConfigNode node)
		{
			//create scaled material and set proprties to defaults
			scaledMaterial = new Material (Shaders.EmissiveScaled);
			scaledMaterial.SetTextureScale ("_EmissiveMap", Vector2.one);
			scaledMaterial.SetTextureOffset ("_EmissiveMap", Vector2.zero);
			scaledMaterial.SetColor ("_Color", new Color (1f, 1f, 1f));
			scaledMaterial.SetFloat ("_Brightness", 1.25f);
			scaledMaterial.SetFloat ("_Transparency", 0.75f);
		}
		public void PostApply(ConfigNode node)
		{
			//add material to scaled version
			var origMat = generatedBody.scaledVersion.renderer.sharedMaterial;
			generatedBody.scaledVersion.renderer.materials = new Material[]{ origMat, scaledMaterial };
		}
	}

	[ExternalParserTarget("EmissiveFX", parentNodeName = "Ocean")]
	public class EmissiveFX : ExternalParserTargetLoader, IParserEventSubscriber
	{
		private PQSMod_EmissiveOceanFX _mod;

		[ParserTarget("color", optional = false)]
		private ColorParser PQScolor
		{
			set{ _mod.EmissiveMaterial.SetColor ("_Color", value.value); }
		}
		[ParserTarget("brightness", optional = true)]
		private NumericParser<float> PQSbrightness
		{
			set{  _mod.EmissiveMaterial.SetFloat ("_Brightness", value.value); }
		}
		[ParserTarget("transparency", optional = true)]
		private NumericParser<float> PQStransparency
		{
			set{  _mod.EmissiveMaterial.SetFloat ("_Transparency", value.value); }
		}

		public EmissiveFX()
		{
			var obj = new GameObject ("EmissiveFX");
			obj.transform.parent = Kopernicus.Utility.Deactivator;

			_mod = obj.AddComponent<PQSMod_EmissiveOceanFX> ();
			_mod.EmissiveMaterial = new Material (Shaders.EmissiveQuad);
			_mod.EmissiveMaterial.SetColor ("_Color", new Color (1f, 1f, 1f));
			_mod.EmissiveMaterial.SetFloat ("_Brightness", 1.4f);
			_mod.EmissiveMaterial.SetFloat ("_Transparency", 0.6f);
		}

		public void Apply(ConfigNode node)
		{

		}
		public void PostApply(ConfigNode node)
		{
			//apply mod to child PQS (Ocean)
			foreach (Transform child in generatedBody.pqsVersion.transform)
			{
				if (child.GetComponent<PQS> () != null)
				{
					var pqs = child.GetComponent<PQS> ();
					Logger.Active.Log ("PQS: " + pqs.name);
					_mod.transform.parent = pqs.transform;
					_mod.sphere = pqs;
					_mod.gameObject.layer = pqs.gameObject.layer;
					_mod.OnSetup ();
					pqs.RebuildSphere ();
					break;
				}
			}
		}
	}
}

namespace KopernicusExpansion.Effects
{
	public class PQSMod_EmissiveOceanFX : PQSMod
	{
		public Material EmissiveMaterial;

		public override void OnPostSetup ()
		{
			//force the PQS to share the surface material
			sphere.useSharedMaterial = true;
		}

		public override void OnQuadBuilt (PQ quad)
		{
			if (quad.sphereRoot != sphere)
				return;

			var surfaceMaterial = quad.meshRenderer.sharedMaterial;

			//take a copy of the emissive material
			var emissiveMaterial = new Material(EmissiveMaterial);
			emissiveMaterial.renderQueue = surfaceMaterial.renderQueue + 10;

			quad.meshRenderer.sharedMaterials = new Material[]{ surfaceMaterial, emissiveMaterial };
		}

		//remove extra material at end of quad's life to prevent issues
		public override void OnQuadDestroy (PQ quad)
		{
			var mats = quad.meshRenderer.sharedMaterials;
			var newMats = new Material[]{ mats [0] };
			quad.meshRenderer.sharedMaterials = newMats;
		}
	}
}

#pragma warning restore 0414