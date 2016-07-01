

Shader "KopernicusExpansion/ParticleGrass" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_TintColor ("Color", Color) = (1,1,1,1)
		_WindPower ("Wind Power", Float) = 0.2
		//_XZScale ("XZ Scale", Float) = 1
		_Evolution ("Time", Float) = 0
		_Alpha ("Alpha", Range(0, 1)) = 1
		//for some reason there's a bug where using a property for alphatest:_Property means that that property can't be used in CG, so a duplicate property is required.
		//set both AlphaCutoff's to the same value
		_AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
		_AlphaCutoff2 ("Alpha Cutoff 2", Range(0, 1)) = 0.5

		_Frequency ("Frequency", Float) = 1

		_PermTable2D ("2D Perm Table", 2D) = "white"{}
		_Gradient3D ("3D Gradient", 2D) = "white"{}
	}
	SubShader {
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" "IgnoreProjector"="True" }
		LOD 200
		Cull Off
		ZWrite On

		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM
		#pragma target 3.0
		#include "UnityCG.cginc"
		#include "../CommonUtils/ImprovedPerlinNoise.cginc"
		#pragma surface surf Lambert alphatest:_AlphaCutoff vertex:vert addshadow nolightmap nofog nometa noforwardadd

		sampler2D _MainTex;
		fixed4 _TintColor;
		float _WindPower;
		//float _XZScale;
		float _Evolution;
		float _Alpha;
		float _AlphaCutoff2;

		half4 LightingParticleGrass(SurfaceOutput s, half3 lightDir, half atten) {
			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
			c.a = s.Alpha;
			return c;
		}

		struct Input {
			float2 uv_MainTex;
			float4 vertColor : COLOR;
		};

		void vert (inout appdata_full v, out Input i)
		{
			UNITY_INITIALIZE_OUTPUT(Input, i);

			float yMult = v.texcoord.y;
			float noiseZ = inoise(float3(v.vertex.z, v.vertex.y, _Evolution) * _Frequency);
			float noiseX = inoise(float3(v.vertex.x, v.vertex.y, _Evolution) * _Frequency);
			v.vertex.x += (yMult * noiseX * _WindPower);
			v.vertex.z += (yMult * noiseZ * _WindPower);
		}

		void surf (Input i, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, i.uv_MainTex);
			o.Albedo = c.rgb * i.vertColor.rgb * _TintColor;
			float a = c.a * _Alpha;
			clip(a - _AlphaCutoff2);
			o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
