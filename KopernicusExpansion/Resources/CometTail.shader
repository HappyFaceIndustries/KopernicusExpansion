

Shader "CometTail" {
	Properties {
		_TintColor ("Color", Color) = (0.5,0.5,0.5,1)
		_Evolution ("Time", Float) = 0
		_RimPower ("Rim Power", Range(0, 4)) = 0.01
		_Distortion ("Distortion", Range(0, 0.5)) = 0.2
		_ZDistortion ("Z Distortion", Range(0, 1)) = 0.1
		_AlphaDistortion ("Alpha Distortion", Range(0, 1)) = 0.2
		_VertexDistortion ("Vertex Distortion", Float) = 0.2
		_Frequency ("Frequency", Float) = 1
		_Lacunarity ("Lacunarity", Float) = 1.3
		_Gain ("Gain", Float) = 0.9

		_PermTable2D ("2D Perm Table", 2D) = "white"{}
		_Gradient3D ("3D Gradient", 2D) = "white"{}
	}
	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 200
		ZWrite On
		Cull Off
	
		CGPROGRAM
		#pragma target 3.0
		#include "UnityCG.cginc"
		#pragma surface surf Unlit alpha vertex:vert

		sampler2D _PermTable2D, _Gradient3D;
		fixed4 _TintColor;
		float _Evolution;
		half _RimPower;
		half _Distortion;
		half _ZDistortion;
		half _AlphaDistortion;
		half _VertexDistortion;
		float _Frequency = 1;
		float _Lacunarity = 1.5;
		float _Gain = 1;


		half4 LightingUnlit(SurfaceOutput s, half3 lightDir, half atten)
		{
			return half4(s.Albedo, s.Alpha);
		}


		float3 fade(float3 t)
		{
			//return t * t * t * (t * (t * 6 - 15) + 10); // new curve
			return t * t * (3 - 2 * t); // old curve
		}
		
		float4 perm2d(float2 uv)
		{
			return tex2D(_PermTable2D, uv);
		}
		
		float gradperm(float x, float3 p)
		{
			float3 g = tex2D(_Gradient3D, float2(x, 0) ).rgb *2.0 - 1.0;
			return dot(g, p);
		}
					
		float inoise(float3 p)
		{
			float3 P = fmod(floor(p), 256.0);	// FIND UNIT CUBE THAT CONTAINS POINT
		  	p -= floor(p);                      // FIND RELATIVE X,Y,Z OF POINT IN CUBE.
			float3 f = fade(p);                 // COMPUTE FADE CURVES FOR EACH OF X,Y,Z.
		
			P = P / 256.0;
			const float one = 1.0 / 256.0;
			
		    // HASH COORDINATES OF THE 8 CUBE CORNERS
			float4 AA = perm2d(P.xy) + P.z;
		 
			// AND ADD BLENDED RESULTS FROM 8 CORNERS OF CUBE
		  	return lerp( lerp( lerp( gradperm(AA.x, p ),  
		                             gradperm(AA.z, p + float3(-1, 0, 0) ), f.x),
		                       lerp( gradperm(AA.y, p + float3(0, -1, 0) ),
		                             gradperm(AA.w, p + float3(-1, -1, 0) ), f.x), f.y),
		                             
		                 lerp( lerp( gradperm(AA.x+one, p + float3(0, 0, -1) ),
		                             gradperm(AA.z+one, p + float3(-1, 0, -1) ), f.x),
		                       lerp( gradperm(AA.y+one, p + float3(0, -1, -1) ),
		                             gradperm(AA.w+one, p + float3(-1, -1, -1) ), f.x), f.y), f.z);
		}
		
		// fractal sum, range -1.0 - 1.0
		float fBm(float3 p, int octaves)
		{
			float freq = _Frequency, amp = 0.5;
			float sum = 0;	
			for(int i = 0; i < octaves; i++) 
			{
				sum += inoise(p * freq) * amp;
				freq *= _Lacunarity;
				amp *= _Gain;
			}
			return sum;
		}
		
		// fractal abs sum, range 0.0 - 1.0
		float turbulence(float3 p, int octaves)
		{
			float sum = 0;
			float freq = _Frequency, amp = 1.0;
			for(int i = 0; i < octaves; i++) 
			{
				sum += abs(inoise(p*freq))*amp;
				freq *= _Lacunarity;
				amp *= _Gain;
			}
			return sum;
		}
		
		// Ridged multifractal, range 0.0 - 1.0
		// See "Texturing & Modeling, A Procedural Approach", Chapter 12
		float ridge(float h, float offset)
		{
		    h = abs(h);
		    h = offset - h;
		    h = h * h;
		    return h;
		}
		
		float ridgedmf(float3 p, int octaves, float offset)
		{
			float sum = 0;
			float freq = _Frequency, amp = 0.5;
			float prev = 1.0;
			for(int i = 0; i < octaves; i++) 
			{
				float n = ridge(inoise(p*freq), offset);
				sum += n*amp*prev;
				prev = n;
				freq *= _Lacunarity;
				amp *= _Gain;
			}
			return sum;
		}


		struct Input {
			float3 vertPos;
			float3 viewDir;
		};

		void vert (inout appdata_full v, out Input i)
		{
			//v.vertex.z -= turbulence(v.vertex + float3(0, 0, _Evolution), 3) * _VertexDistortion * pow(v.vertex.z, 2);
			i.vertPos = v.vertex.xyz;
		}

		void surf (Input i, inout SurfaceOutput o)
		{
			//calculate noise
			i.vertPos.z *= _ZDistortion;
			float n = fBm(i.vertPos + float3(0, 0, _Evolution), 5);
			half3 color = lerp(_TintColor.rgb, fixed3(n, n, n), _Distortion);

			half rim1 = saturate(dot(normalize(i.viewDir), o.Normal));
			half rim2 = saturate(dot(normalize(i.viewDir), -o.Normal));
			half rim = max(rim1, rim2);

			o.Albedo = color;
			o.Alpha = lerp(_TintColor.a, n, _AlphaDistortion) * pow(rim, _RimPower);
		}
		ENDCG
	}
	FallBack "Particles/Alpha Blended"
}
