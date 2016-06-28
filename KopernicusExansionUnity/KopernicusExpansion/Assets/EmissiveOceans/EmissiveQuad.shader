

Shader "KopernicusExpansion/EmissiveQuad" {
Properties {
	_Color ("Color", Color) = (1,1,1,1)
	_EmissiveMap ("Map", 2D) = "white" {}
	_Brightness ("Brightness", Float) = 1.5
	_Transparency ("Transparency", Float) = 0.35
}

SubShader {
	Tags { "Queue"="Transparent" "RenderType"="Transparent" }
	LOD 250
	
	CGPROGRAM
	#pragma surface surf Lambert alpha
	
	float4 _Color;
	sampler2D _EmissiveMap;
	float _Brightness;
	float _Transparency;

	struct Input {
		float3 viewDir;
		float3 worldNormal;
		float2 uv_EmissiveMap;
	};

	void surf (Input IN, inout SurfaceOutput o) {

		o.Emission = _Color * _Brightness * tex2D (_EmissiveMap, IN.uv_EmissiveMap).rgb;
		o.Alpha = tex2D (_EmissiveMap, IN.uv_EmissiveMap).a - _Transparency;
	}
	ENDCG
}

Fallback "Diffuse"
}
