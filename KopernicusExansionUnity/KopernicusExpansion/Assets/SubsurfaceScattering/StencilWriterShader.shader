Shader "KopernicusExpansion/StencilWriterShader"
{
	Properties
	{
		
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 200

		Pass
		{
			Blend DstAlpha SrcAlpha
			Cull Off
			ZWrite On
			ZTest Always

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			//#define OneOver32 0.03125
			#define OneOver32 0.57142857

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float depth : DEPTH;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				float depth = -mul(UNITY_MATRIX_MV, v.vertex).z * _ProjectionParams.w;
				o.depth = depth;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return fixed4(OneOver32, OneOver32, OneOver32, OneOver32);
			}
			ENDCG
		}
	}
}
