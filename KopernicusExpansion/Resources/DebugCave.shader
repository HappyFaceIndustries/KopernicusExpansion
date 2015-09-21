Shader "Debug/Cave" {
	Properties {
		_TintColor ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Tags { "RenderType"="Transparent" }
		LOD 2000
		Cull Off
		Lighting Off
		
		CGPROGRAM
		#pragma surface surf Lambert alpha

		fixed4 _TintColor;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _TintColor.rgb;
			o.Alpha = _TintColor.a;
		}
		ENDCG
	} 
	FallBack "Particles/Additive"
}
