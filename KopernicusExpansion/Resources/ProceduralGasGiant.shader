

Shader "Surface/ProceduralGasGiant" {
	Properties {
		_MainTex ("Ramp Texture", 2D) = "white"{}
		_PlanetOpacity ("Opacity", Float) = 1
		_Evolution ("Time", Float) = 0
		_StormFrequency ("Storm Frequency", Float) = 5
		_StormThreshold ("Storm Threshold", Float) = 0.85
		_Distortion ("Distortion", Range(0, 0.05)) = 0.02
		_MainFrequency ("Frequency", Float) = 25
		_Lacunarity ("Lacunarity", Float) = 1.3
		_Gain ("Gain", Float) = 0.9

		_PermTable2D ("2D Perm Table", 2D) = "white"{}
		_Gradient3D ("3D Gradient", 2D) = "white"{}

	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma target 3.0
		#include "UnityCG.cginc"
		#pragma surface surf Lambert alpha vertex:vert

		sampler2D _PermTable2D, _Gradient3D;
		sampler2D _MainTex;
		fixed _PlanetOpacity;
		float _MainFrequency;
		float _Frequency = 1;
		float _Lacunarity = 1.5;
		float _Gain = 1;
		half _Distortion;
		float _Evolution;
		float _StormFrequency;
		half _StormThreshold;


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
		};

		void vert(inout appdata_full v, out Input i)
		{
			i.vertPos = normalize(v.vertex.xyz);
		}

		half3 getColor (float3 vertPos)
		{
			//noise functions are fBm, turbulence, and ridgemf. use i.uv.xyz as the first argument, second argument is octaves
			half3 c;

			_Frequency = _MainFrequency;

			//main pattern
			float n = turbulence(vertPos + float3(_Evolution, 0, _Evolution), 6) * _Distortion;

			_Frequency = _StormFrequency;

			//storms
			float s = _StormThreshold * 2;
			float sn1 = turbulence((vertPos + float3(0, 0, 0) * 2), 1) - s;
			float sn2 = turbulence((vertPos + float3(800, 0, 800) * 2), 1) - s;
			float sn3 = turbulence((vertPos + float3(1600, 0, 1600) * 2), 1) - s;
			float threshold = max(0, sn1 * sn2 * sn3) * 50;
			float sn4 = fBm(vertPos * 0.1, 4) * threshold;
			
			float2 uv = float2(((vertPos.y + n + sn4) * 0.5) - 0.5, 0);
			
			c.rgb = tex2D(_MainTex, uv).rgb;
			
			c.r = max(0.05, c.r);
			c.g = max(0.05, c.g);
			c.b = max(0.05, c.b);
			return c;
		}
		void surf (Input i, inout SurfaceOutput o)
		{
			o.Albedo = getColor(i.vertPos);
			o.Alpha = _PlanetOpacity;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
