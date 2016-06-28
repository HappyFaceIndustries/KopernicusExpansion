

Shader "KopernicusExpansion/ParticleGrass" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_TintColor ("Color", Color) = (1,1,1,1)
		_WindPower ("Wind Power", Float) = 0.2
		//_XZScale ("XZ Scale", Float) = 1
		_Evolution ("Time", Float) = 0
		_Alpha ("Alpha", Range(0, 1)) = 1
		_AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5

		_Frequency ("Frequency", Float) = 1

		_PermTable2D ("2D Perm Table", 2D) = "white"{}
		_Gradient3D ("3D Gradient", 2D) = "white"{}
	}
	/*SubShader {
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" "IgnoreProjector"="True" }
		LOD 200

		Pass {
			Cull Off
			ZWrite On

			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma fragment frag
			#pragma vertex vert
			#include "UnityCG.cginc"
			#include "AutoLight.cginc"
			#include "UnityLightingCommon.cginc"
			#include "../CommonUtils/ImprovedPerlinNoise.cginc"

			sampler2D _MainTex;
			fixed4 _TintColor;
			float _WindPower;
			//float _XZScale;
			float _Evolution;
			float _Alpha;
			float _AlphaCutoff;

			struct v2f {
				float2 uv : TEXCOORD0;
				float4 color : COLOR0;
				float4 vertex : SV_POSITION;
				float3 diff : COLOR1;
				float3 ambient : COLOR2;
				SHADOW_COORDS(1)
			};

			v2f vert(appdata_full v) {
				v2f o;

				//wind
				float yMult = v.texcoord.y;
				float noiseZ = inoise(float3(v.vertex.z, v.vertex.y, _Evolution) * _Frequency);
				float noiseX = inoise(float3(v.vertex.x, v.vertex.y, _Evolution) * _Frequency);
				v.vertex.x += (yMult * noiseX * _WindPower);
				v.vertex.z += (yMult * noiseZ * _WindPower);

				//v2f setup
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.texcoord;
				o.color = v.color;

				//lighting and shadows
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				float nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = nl * _LightColor0;
				o.ambient = ShadeSH9(float4(worldNormal, 1));
				TRANSFER_SHADOW(o);

				return o;
			}

			float4 frag(v2f i) : SV_TARGET {
				float4 c = tex2D(_MainTex, i.uv);
				float shadow = SHADOW_ATTENUATION(i);
				//c.rgb *= i.color * i.diff * shadow;
				//c.rgb += i.ambient;
				c.rgb = float3(shadow, shadow, shadow);
				clip(c.a - _AlphaCutoff);
				return c;
			}

			ENDCG
		}
	}*/
	SubShader {
		Tags { "Queue"="AlphaTest" "RenderType"="TransparentCutout" "IgnoreProjector"="True" }
		//Tags { "Queue"="Geometry" "RenderType"="Opaque" "IgnoreProjector"="True" }
		LOD 200
		Cull Off
		ZWrite On

		Blend SrcAlpha OneMinusSrcAlpha

		CGPROGRAM
		#pragma target 3.0
		#include "UnityCG.cginc"
		#include "../CommonUtils/ImprovedPerlinNoise.cginc"
		#pragma surface surf Lambert alphatest:_AlphaCutoff vertex:vert nofog noforwardadd

		sampler2D _MainTex;
		fixed4 _TintColor;
		float _WindPower;
		//float _XZScale;
		float _Evolution;
		float _Alpha;

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
			o.Alpha = c.a * _Alpha;
			clip(o.Alpha - 0.3);
			//o.Alpha = 1;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
