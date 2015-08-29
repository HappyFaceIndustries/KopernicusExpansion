// Compiled shader for all platforms, uncompressed size: 455.5KB

Shader "ProceduralGasGiant" {
Properties {
 _MainTex ("Ramp Texture", 2D) = "white" {}
 _Evolution ("Time", Float) = 0
 _StormMap ("Storm Map", 2D) = "white" {}
 _StormFrequency ("Storm Frequency", Float) = 5
 _StormDistortion ("Storm Distortion", Float) = 0.85
 _Distortion ("Distortion", Range(0,0.05)) = 0.02
 _MainFrequency ("Frequency", Float) = 25
 _Lacunarity ("Lacunarity", Float) = 1.3
 _Gain ("Gain", Float) = 0.9
 _PermTable2D ("2D Perm Table", 2D) = "white" {}
 _Gradient3D ("3D Gradient", 2D) = "white" {}
}
SubShader { 
 LOD 200
 Tags { "ForceNoShadowCasting"="true" "RenderType"="Opaque" }
 Pass {
  Tags { "ForceNoShadowCasting"="true" "RenderType"="Opaque" }
 }


 // Stats for Vertex shader:
 //        d3d9 : 27 avg math (9..60)
 //      opengl : 27 avg math (9..60)
 // Stats for Fragment shader:
 //        d3d9 : 163 avg math (162..165), 20 avg texture (20..21), 10 branch
 //      opengl : 555 avg math (555..557), 65 avg texture (65..66)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "ForceNoShadowCasting"="true" "RenderType"="Opaque" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
SubProgram "opengl " {
// Stats: 30 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [unity_Scale]
Vector 17 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[18] = { { 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[16].w;
DP3 R3.x, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.x;
MOV R0.z, R2.w;
MOV R0.w, c[0].x;
MUL R1, R0.xyzz, R0.yzzx;
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
DP4 R0.z, R1, c[13];
DP4 R0.y, R1, c[12];
DP4 R0.w, R1, c[14];
ADD R2.xyz, R2, R0.yzww;
MUL R1.x, R3, R3;
MAD R0.z, R0.x, R0.x, -R1.x;
DP3 R0.y, vertex.position, vertex.position;
MUL R1.xyz, R0.z, c[15];
RSQ R0.y, R0.y;
ADD result.texcoord[3].xyz, R2, R1;
MUL result.texcoord[1].xyz, R0.y, vertex.position;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.x;
MOV result.texcoord[2].x, R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 30 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 30 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_SHAr]
Vector 9 [unity_SHAg]
Vector 10 [unity_SHAb]
Vector 11 [unity_SHBr]
Vector 12 [unity_SHBg]
Vector 13 [unity_SHBb]
Vector 14 [unity_SHC]
Vector 15 [unity_Scale]
Vector 16 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c15.w
dp3 r3.x, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.x
mov r0.z, r2.w
mov r0.w, c17.x
mul r1, r0.xyzz, r0.yzzx
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
dp4 r0.z, r1, c12
dp4 r0.y, r1, c11
dp4 r0.w, r1, c13
add r2.xyz, r2, r0.yzww
mul r1.x, r3, r3
mad r0.z, r0.x, r0.x, -r1.x
dp3 r0.y, v0, v0
mul r1.xyz, r0.z, c14
rsq r0.y, r0.y
add o4.xyz, r2, r1
mul o2.xyz, r0.y, v0
mov o3.z, r2.w
mov o3.y, r3.x
mov o3.x, r0
mad o1.xy, v2, c16, c16.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture2D (_MainTex, tmpvar_92).xyz;
  lowp vec4 c_93;
  c_93.xyz = ((c_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = (c_93.xyz + (c_3 * xlv_TEXCOORD3));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture2D (_MainTex, tmpvar_92).xyz;
  lowp vec4 c_93;
  c_93.xyz = ((c_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = (c_93.xyz + (c_3 * xlv_TEXCOORD3));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture (_MainTex, tmpvar_92).xyz;
  lowp vec4 c_93;
  c_93.xyz = ((c_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = (c_93.xyz + (c_3 * xlv_TEXCOORD3));
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o2.xyz, r0.x, v0
mad o1.xy, v2, c9, c9.zwzw
mad o3.xy, v3, c8, c8.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  highp vec3 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = _Evolution;
  tmpvar_3.z = _Evolution;
  highp vec3 p_4;
  p_4 = (xlv_TEXCOORD1 + tmpvar_3);
  int i_5;
  highp float amp_6;
  highp float freq_7;
  highp float sum_8;
  sum_8 = 0.0;
  freq_7 = _MainFrequency;
  amp_6 = 1.0;
  i_5 = 0;
  for (int i_5 = 0; i_5 < 4; ) {
    highp vec3 p_9;
    p_9 = (p_4 * freq_7);
    highp vec3 tmpvar_10;
    tmpvar_10 = (floor(p_9) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_12;
    if ((tmpvar_10.x >= 0.0)) {
      tmpvar_12 = tmpvar_11.x;
    } else {
      tmpvar_12 = -(tmpvar_11.x);
    };
    highp float tmpvar_13;
    if ((tmpvar_10.y >= 0.0)) {
      tmpvar_13 = tmpvar_11.y;
    } else {
      tmpvar_13 = -(tmpvar_11.y);
    };
    highp float tmpvar_14;
    if ((tmpvar_10.z >= 0.0)) {
      tmpvar_14 = tmpvar_11.z;
    } else {
      tmpvar_14 = -(tmpvar_11.z);
    };
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_12;
    tmpvar_15.y = tmpvar_13;
    tmpvar_15.z = tmpvar_14;
    highp vec3 tmpvar_16;
    tmpvar_16 = (p_9 - floor(p_9));
    p_9 = tmpvar_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
    highp vec3 tmpvar_18;
    tmpvar_18 = (tmpvar_15 / 256.0);
    highp vec4 tmpvar_19;
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_PermTable2D, tmpvar_18.xy);
    tmpvar_19 = tmpvar_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_19 + tmpvar_18.z);
    highp vec3 g_22;
    highp vec2 tmpvar_23;
    tmpvar_23.y = 0.0;
    tmpvar_23.x = tmpvar_21.x;
    lowp vec3 tmpvar_24;
    tmpvar_24 = ((texture2D (_Gradient3D, tmpvar_23).xyz * 2.0) - 1.0);
    g_22 = tmpvar_24;
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_21.z;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_21.y;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_21.w;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = (tmpvar_21.x + 0.00390625);
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_21.z + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_21.y + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_21.w + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    sum_8 = (sum_8 + (abs(mix (mix (mix (dot (g_22, tmpvar_16), dot (g_25, (tmpvar_16 + vec3(-1.0, 0.0, 0.0))), tmpvar_17.x), mix (dot (g_28, (tmpvar_16 + vec3(0.0, -1.0, 0.0))), dot (g_31, (tmpvar_16 + vec3(-1.0, -1.0, 0.0))), tmpvar_17.x), tmpvar_17.y), mix (mix (dot (g_34, (tmpvar_16 + vec3(0.0, 0.0, -1.0))), dot (g_37, (tmpvar_16 + vec3(-1.0, 0.0, -1.0))), tmpvar_17.x), mix (dot (g_40, (tmpvar_16 + vec3(0.0, -1.0, -1.0))), dot (g_43, (tmpvar_16 + vec3(-1.0, -1.0, -1.0))), tmpvar_17.x), tmpvar_17.y), tmpvar_17.z)) * amp_6));
    freq_7 = (freq_7 * _Lacunarity);
    amp_6 = (amp_6 * _Gain);
    i_5 = (i_5 + 1);
  };
  highp float tmpvar_46;
  tmpvar_46 = (sum_8 * _Distortion);
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.y = 0.0;
  tmpvar_48.x = _Evolution;
  tmpvar_48.z = _Evolution;
  highp vec3 p_49;
  p_49 = (xlv_TEXCOORD1 + tmpvar_48);
  int i_50;
  highp float sum_51;
  highp float amp_52;
  highp float freq_53;
  freq_53 = _StormFrequency;
  amp_52 = 0.5;
  sum_51 = 0.0;
  i_50 = 0;
  for (int i_50 = 0; i_50 < 3; ) {
    highp vec3 p_54;
    p_54 = (p_49 * freq_53);
    highp vec3 tmpvar_55;
    tmpvar_55 = (floor(p_54) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_57;
    if ((tmpvar_55.x >= 0.0)) {
      tmpvar_57 = tmpvar_56.x;
    } else {
      tmpvar_57 = -(tmpvar_56.x);
    };
    highp float tmpvar_58;
    if ((tmpvar_55.y >= 0.0)) {
      tmpvar_58 = tmpvar_56.y;
    } else {
      tmpvar_58 = -(tmpvar_56.y);
    };
    highp float tmpvar_59;
    if ((tmpvar_55.z >= 0.0)) {
      tmpvar_59 = tmpvar_56.z;
    } else {
      tmpvar_59 = -(tmpvar_56.z);
    };
    highp vec3 tmpvar_60;
    tmpvar_60.x = tmpvar_57;
    tmpvar_60.y = tmpvar_58;
    tmpvar_60.z = tmpvar_59;
    highp vec3 tmpvar_61;
    tmpvar_61 = (p_54 - floor(p_54));
    p_54 = tmpvar_61;
    highp vec3 tmpvar_62;
    tmpvar_62 = ((tmpvar_61 * tmpvar_61) * (3.0 - (2.0 * tmpvar_61)));
    highp vec3 tmpvar_63;
    tmpvar_63 = (tmpvar_60 / 256.0);
    highp vec4 tmpvar_64;
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_PermTable2D, tmpvar_63.xy);
    tmpvar_64 = tmpvar_65;
    highp vec4 tmpvar_66;
    tmpvar_66 = (tmpvar_64 + tmpvar_63.z);
    highp vec3 g_67;
    highp vec2 tmpvar_68;
    tmpvar_68.y = 0.0;
    tmpvar_68.x = tmpvar_66.x;
    lowp vec3 tmpvar_69;
    tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
    g_67 = tmpvar_69;
    highp vec3 g_70;
    highp vec2 tmpvar_71;
    tmpvar_71.y = 0.0;
    tmpvar_71.x = tmpvar_66.z;
    lowp vec3 tmpvar_72;
    tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
    g_70 = tmpvar_72;
    highp vec3 g_73;
    highp vec2 tmpvar_74;
    tmpvar_74.y = 0.0;
    tmpvar_74.x = tmpvar_66.y;
    lowp vec3 tmpvar_75;
    tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
    g_73 = tmpvar_75;
    highp vec3 g_76;
    highp vec2 tmpvar_77;
    tmpvar_77.y = 0.0;
    tmpvar_77.x = tmpvar_66.w;
    lowp vec3 tmpvar_78;
    tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
    g_76 = tmpvar_78;
    highp vec3 g_79;
    highp vec2 tmpvar_80;
    tmpvar_80.y = 0.0;
    tmpvar_80.x = (tmpvar_66.x + 0.00390625);
    lowp vec3 tmpvar_81;
    tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
    g_79 = tmpvar_81;
    highp vec3 g_82;
    highp vec2 tmpvar_83;
    tmpvar_83.y = 0.0;
    tmpvar_83.x = (tmpvar_66.z + 0.00390625);
    lowp vec3 tmpvar_84;
    tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
    g_82 = tmpvar_84;
    highp vec3 g_85;
    highp vec2 tmpvar_86;
    tmpvar_86.y = 0.0;
    tmpvar_86.x = (tmpvar_66.y + 0.00390625);
    lowp vec3 tmpvar_87;
    tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
    g_85 = tmpvar_87;
    highp vec3 g_88;
    highp vec2 tmpvar_89;
    tmpvar_89.y = 0.0;
    tmpvar_89.x = (tmpvar_66.w + 0.00390625);
    lowp vec3 tmpvar_90;
    tmpvar_90 = ((texture2D (_Gradient3D, tmpvar_89).xyz * 2.0) - 1.0);
    g_88 = tmpvar_90;
    sum_51 = (sum_51 + (mix (mix (mix (dot (g_67, tmpvar_61), dot (g_70, (tmpvar_61 + vec3(-1.0, 0.0, 0.0))), tmpvar_62.x), mix (dot (g_73, (tmpvar_61 + vec3(0.0, -1.0, 0.0))), dot (g_76, (tmpvar_61 + vec3(-1.0, -1.0, 0.0))), tmpvar_62.x), tmpvar_62.y), mix (mix (dot (g_79, (tmpvar_61 + vec3(0.0, 0.0, -1.0))), dot (g_82, (tmpvar_61 + vec3(-1.0, 0.0, -1.0))), tmpvar_62.x), mix (dot (g_85, (tmpvar_61 + vec3(0.0, -1.0, -1.0))), dot (g_88, (tmpvar_61 + vec3(-1.0, -1.0, -1.0))), tmpvar_62.x), tmpvar_62.y), tmpvar_62.z) * amp_52));
    freq_53 = (freq_53 * _Lacunarity);
    amp_52 = (amp_52 * _Gain);
    i_50 = (i_50 + 1);
  };
  highp vec2 tmpvar_91;
  tmpvar_91.y = 0.0;
  tmpvar_91.x = (((((xlv_TEXCOORD1.y + tmpvar_46) + ((sum_51 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_1.xyz = (texture2D (_MainTex, tmpvar_91).xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  highp vec3 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = _Evolution;
  tmpvar_3.z = _Evolution;
  highp vec3 p_4;
  p_4 = (xlv_TEXCOORD1 + tmpvar_3);
  int i_5;
  highp float amp_6;
  highp float freq_7;
  highp float sum_8;
  sum_8 = 0.0;
  freq_7 = _MainFrequency;
  amp_6 = 1.0;
  i_5 = 0;
  for (int i_5 = 0; i_5 < 4; ) {
    highp vec3 p_9;
    p_9 = (p_4 * freq_7);
    highp vec3 tmpvar_10;
    tmpvar_10 = (floor(p_9) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_12;
    if ((tmpvar_10.x >= 0.0)) {
      tmpvar_12 = tmpvar_11.x;
    } else {
      tmpvar_12 = -(tmpvar_11.x);
    };
    highp float tmpvar_13;
    if ((tmpvar_10.y >= 0.0)) {
      tmpvar_13 = tmpvar_11.y;
    } else {
      tmpvar_13 = -(tmpvar_11.y);
    };
    highp float tmpvar_14;
    if ((tmpvar_10.z >= 0.0)) {
      tmpvar_14 = tmpvar_11.z;
    } else {
      tmpvar_14 = -(tmpvar_11.z);
    };
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_12;
    tmpvar_15.y = tmpvar_13;
    tmpvar_15.z = tmpvar_14;
    highp vec3 tmpvar_16;
    tmpvar_16 = (p_9 - floor(p_9));
    p_9 = tmpvar_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
    highp vec3 tmpvar_18;
    tmpvar_18 = (tmpvar_15 / 256.0);
    highp vec4 tmpvar_19;
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_PermTable2D, tmpvar_18.xy);
    tmpvar_19 = tmpvar_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_19 + tmpvar_18.z);
    highp vec3 g_22;
    highp vec2 tmpvar_23;
    tmpvar_23.y = 0.0;
    tmpvar_23.x = tmpvar_21.x;
    lowp vec3 tmpvar_24;
    tmpvar_24 = ((texture2D (_Gradient3D, tmpvar_23).xyz * 2.0) - 1.0);
    g_22 = tmpvar_24;
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_21.z;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_21.y;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_21.w;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = (tmpvar_21.x + 0.00390625);
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_21.z + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_21.y + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_21.w + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    sum_8 = (sum_8 + (abs(mix (mix (mix (dot (g_22, tmpvar_16), dot (g_25, (tmpvar_16 + vec3(-1.0, 0.0, 0.0))), tmpvar_17.x), mix (dot (g_28, (tmpvar_16 + vec3(0.0, -1.0, 0.0))), dot (g_31, (tmpvar_16 + vec3(-1.0, -1.0, 0.0))), tmpvar_17.x), tmpvar_17.y), mix (mix (dot (g_34, (tmpvar_16 + vec3(0.0, 0.0, -1.0))), dot (g_37, (tmpvar_16 + vec3(-1.0, 0.0, -1.0))), tmpvar_17.x), mix (dot (g_40, (tmpvar_16 + vec3(0.0, -1.0, -1.0))), dot (g_43, (tmpvar_16 + vec3(-1.0, -1.0, -1.0))), tmpvar_17.x), tmpvar_17.y), tmpvar_17.z)) * amp_6));
    freq_7 = (freq_7 * _Lacunarity);
    amp_6 = (amp_6 * _Gain);
    i_5 = (i_5 + 1);
  };
  highp float tmpvar_46;
  tmpvar_46 = (sum_8 * _Distortion);
  lowp float tmpvar_47;
  tmpvar_47 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.y = 0.0;
  tmpvar_48.x = _Evolution;
  tmpvar_48.z = _Evolution;
  highp vec3 p_49;
  p_49 = (xlv_TEXCOORD1 + tmpvar_48);
  int i_50;
  highp float sum_51;
  highp float amp_52;
  highp float freq_53;
  freq_53 = _StormFrequency;
  amp_52 = 0.5;
  sum_51 = 0.0;
  i_50 = 0;
  for (int i_50 = 0; i_50 < 3; ) {
    highp vec3 p_54;
    p_54 = (p_49 * freq_53);
    highp vec3 tmpvar_55;
    tmpvar_55 = (floor(p_54) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_57;
    if ((tmpvar_55.x >= 0.0)) {
      tmpvar_57 = tmpvar_56.x;
    } else {
      tmpvar_57 = -(tmpvar_56.x);
    };
    highp float tmpvar_58;
    if ((tmpvar_55.y >= 0.0)) {
      tmpvar_58 = tmpvar_56.y;
    } else {
      tmpvar_58 = -(tmpvar_56.y);
    };
    highp float tmpvar_59;
    if ((tmpvar_55.z >= 0.0)) {
      tmpvar_59 = tmpvar_56.z;
    } else {
      tmpvar_59 = -(tmpvar_56.z);
    };
    highp vec3 tmpvar_60;
    tmpvar_60.x = tmpvar_57;
    tmpvar_60.y = tmpvar_58;
    tmpvar_60.z = tmpvar_59;
    highp vec3 tmpvar_61;
    tmpvar_61 = (p_54 - floor(p_54));
    p_54 = tmpvar_61;
    highp vec3 tmpvar_62;
    tmpvar_62 = ((tmpvar_61 * tmpvar_61) * (3.0 - (2.0 * tmpvar_61)));
    highp vec3 tmpvar_63;
    tmpvar_63 = (tmpvar_60 / 256.0);
    highp vec4 tmpvar_64;
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture2D (_PermTable2D, tmpvar_63.xy);
    tmpvar_64 = tmpvar_65;
    highp vec4 tmpvar_66;
    tmpvar_66 = (tmpvar_64 + tmpvar_63.z);
    highp vec3 g_67;
    highp vec2 tmpvar_68;
    tmpvar_68.y = 0.0;
    tmpvar_68.x = tmpvar_66.x;
    lowp vec3 tmpvar_69;
    tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
    g_67 = tmpvar_69;
    highp vec3 g_70;
    highp vec2 tmpvar_71;
    tmpvar_71.y = 0.0;
    tmpvar_71.x = tmpvar_66.z;
    lowp vec3 tmpvar_72;
    tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
    g_70 = tmpvar_72;
    highp vec3 g_73;
    highp vec2 tmpvar_74;
    tmpvar_74.y = 0.0;
    tmpvar_74.x = tmpvar_66.y;
    lowp vec3 tmpvar_75;
    tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
    g_73 = tmpvar_75;
    highp vec3 g_76;
    highp vec2 tmpvar_77;
    tmpvar_77.y = 0.0;
    tmpvar_77.x = tmpvar_66.w;
    lowp vec3 tmpvar_78;
    tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
    g_76 = tmpvar_78;
    highp vec3 g_79;
    highp vec2 tmpvar_80;
    tmpvar_80.y = 0.0;
    tmpvar_80.x = (tmpvar_66.x + 0.00390625);
    lowp vec3 tmpvar_81;
    tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
    g_79 = tmpvar_81;
    highp vec3 g_82;
    highp vec2 tmpvar_83;
    tmpvar_83.y = 0.0;
    tmpvar_83.x = (tmpvar_66.z + 0.00390625);
    lowp vec3 tmpvar_84;
    tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
    g_82 = tmpvar_84;
    highp vec3 g_85;
    highp vec2 tmpvar_86;
    tmpvar_86.y = 0.0;
    tmpvar_86.x = (tmpvar_66.y + 0.00390625);
    lowp vec3 tmpvar_87;
    tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
    g_85 = tmpvar_87;
    highp vec3 g_88;
    highp vec2 tmpvar_89;
    tmpvar_89.y = 0.0;
    tmpvar_89.x = (tmpvar_66.w + 0.00390625);
    lowp vec3 tmpvar_90;
    tmpvar_90 = ((texture2D (_Gradient3D, tmpvar_89).xyz * 2.0) - 1.0);
    g_88 = tmpvar_90;
    sum_51 = (sum_51 + (mix (mix (mix (dot (g_67, tmpvar_61), dot (g_70, (tmpvar_61 + vec3(-1.0, 0.0, 0.0))), tmpvar_62.x), mix (dot (g_73, (tmpvar_61 + vec3(0.0, -1.0, 0.0))), dot (g_76, (tmpvar_61 + vec3(-1.0, -1.0, 0.0))), tmpvar_62.x), tmpvar_62.y), mix (mix (dot (g_79, (tmpvar_61 + vec3(0.0, 0.0, -1.0))), dot (g_82, (tmpvar_61 + vec3(-1.0, 0.0, -1.0))), tmpvar_62.x), mix (dot (g_85, (tmpvar_61 + vec3(0.0, -1.0, -1.0))), dot (g_88, (tmpvar_61 + vec3(-1.0, -1.0, -1.0))), tmpvar_62.x), tmpvar_62.y), tmpvar_62.z) * amp_52));
    freq_53 = (freq_53 * _Lacunarity);
    amp_52 = (amp_52 * _Gain);
    i_50 = (i_50 + 1);
  };
  highp vec2 tmpvar_91;
  tmpvar_91.y = 0.0;
  tmpvar_91.x = (((((xlv_TEXCOORD1.y + tmpvar_46) + ((sum_51 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  lowp vec4 tmpvar_92;
  tmpvar_92 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  c_1.xyz = (texture2D (_MainTex, tmpvar_91).xyz * ((8.0 * tmpvar_92.w) * tmpvar_92.xyz));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  highp vec3 tmpvar_3;
  tmpvar_3.y = 0.0;
  tmpvar_3.x = _Evolution;
  tmpvar_3.z = _Evolution;
  highp vec3 p_4;
  p_4 = (xlv_TEXCOORD1 + tmpvar_3);
  int i_5;
  highp float amp_6;
  highp float freq_7;
  highp float sum_8;
  sum_8 = 0.0;
  freq_7 = _MainFrequency;
  amp_6 = 1.0;
  i_5 = 0;
  for (int i_5 = 0; i_5 < 4; ) {
    highp vec3 p_9;
    p_9 = (p_4 * freq_7);
    highp vec3 tmpvar_10;
    tmpvar_10 = (floor(p_9) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_12;
    if ((tmpvar_10.x >= 0.0)) {
      tmpvar_12 = tmpvar_11.x;
    } else {
      tmpvar_12 = -(tmpvar_11.x);
    };
    highp float tmpvar_13;
    if ((tmpvar_10.y >= 0.0)) {
      tmpvar_13 = tmpvar_11.y;
    } else {
      tmpvar_13 = -(tmpvar_11.y);
    };
    highp float tmpvar_14;
    if ((tmpvar_10.z >= 0.0)) {
      tmpvar_14 = tmpvar_11.z;
    } else {
      tmpvar_14 = -(tmpvar_11.z);
    };
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_12;
    tmpvar_15.y = tmpvar_13;
    tmpvar_15.z = tmpvar_14;
    highp vec3 tmpvar_16;
    tmpvar_16 = (p_9 - floor(p_9));
    p_9 = tmpvar_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((tmpvar_16 * tmpvar_16) * (3.0 - (2.0 * tmpvar_16)));
    highp vec3 tmpvar_18;
    tmpvar_18 = (tmpvar_15 / 256.0);
    highp vec4 tmpvar_19;
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture (_PermTable2D, tmpvar_18.xy);
    tmpvar_19 = tmpvar_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_19 + tmpvar_18.z);
    highp vec3 g_22;
    highp vec2 tmpvar_23;
    tmpvar_23.y = 0.0;
    tmpvar_23.x = tmpvar_21.x;
    lowp vec3 tmpvar_24;
    tmpvar_24 = ((texture (_Gradient3D, tmpvar_23).xyz * 2.0) - 1.0);
    g_22 = tmpvar_24;
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_21.z;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_21.y;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_21.w;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = (tmpvar_21.x + 0.00390625);
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_21.z + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_21.y + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_21.w + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    sum_8 = (sum_8 + (abs(mix (mix (mix (dot (g_22, tmpvar_16), dot (g_25, (tmpvar_16 + vec3(-1.0, 0.0, 0.0))), tmpvar_17.x), mix (dot (g_28, (tmpvar_16 + vec3(0.0, -1.0, 0.0))), dot (g_31, (tmpvar_16 + vec3(-1.0, -1.0, 0.0))), tmpvar_17.x), tmpvar_17.y), mix (mix (dot (g_34, (tmpvar_16 + vec3(0.0, 0.0, -1.0))), dot (g_37, (tmpvar_16 + vec3(-1.0, 0.0, -1.0))), tmpvar_17.x), mix (dot (g_40, (tmpvar_16 + vec3(0.0, -1.0, -1.0))), dot (g_43, (tmpvar_16 + vec3(-1.0, -1.0, -1.0))), tmpvar_17.x), tmpvar_17.y), tmpvar_17.z)) * amp_6));
    freq_7 = (freq_7 * _Lacunarity);
    amp_6 = (amp_6 * _Gain);
    i_5 = (i_5 + 1);
  };
  highp float tmpvar_46;
  tmpvar_46 = (sum_8 * _Distortion);
  lowp float tmpvar_47;
  tmpvar_47 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_47;
  highp vec3 tmpvar_48;
  tmpvar_48.y = 0.0;
  tmpvar_48.x = _Evolution;
  tmpvar_48.z = _Evolution;
  highp vec3 p_49;
  p_49 = (xlv_TEXCOORD1 + tmpvar_48);
  int i_50;
  highp float sum_51;
  highp float amp_52;
  highp float freq_53;
  freq_53 = _StormFrequency;
  amp_52 = 0.5;
  sum_51 = 0.0;
  i_50 = 0;
  for (int i_50 = 0; i_50 < 3; ) {
    highp vec3 p_54;
    p_54 = (p_49 * freq_53);
    highp vec3 tmpvar_55;
    tmpvar_55 = (floor(p_54) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_56;
    tmpvar_56 = (fract(abs(tmpvar_55)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_57;
    if ((tmpvar_55.x >= 0.0)) {
      tmpvar_57 = tmpvar_56.x;
    } else {
      tmpvar_57 = -(tmpvar_56.x);
    };
    highp float tmpvar_58;
    if ((tmpvar_55.y >= 0.0)) {
      tmpvar_58 = tmpvar_56.y;
    } else {
      tmpvar_58 = -(tmpvar_56.y);
    };
    highp float tmpvar_59;
    if ((tmpvar_55.z >= 0.0)) {
      tmpvar_59 = tmpvar_56.z;
    } else {
      tmpvar_59 = -(tmpvar_56.z);
    };
    highp vec3 tmpvar_60;
    tmpvar_60.x = tmpvar_57;
    tmpvar_60.y = tmpvar_58;
    tmpvar_60.z = tmpvar_59;
    highp vec3 tmpvar_61;
    tmpvar_61 = (p_54 - floor(p_54));
    p_54 = tmpvar_61;
    highp vec3 tmpvar_62;
    tmpvar_62 = ((tmpvar_61 * tmpvar_61) * (3.0 - (2.0 * tmpvar_61)));
    highp vec3 tmpvar_63;
    tmpvar_63 = (tmpvar_60 / 256.0);
    highp vec4 tmpvar_64;
    lowp vec4 tmpvar_65;
    tmpvar_65 = texture (_PermTable2D, tmpvar_63.xy);
    tmpvar_64 = tmpvar_65;
    highp vec4 tmpvar_66;
    tmpvar_66 = (tmpvar_64 + tmpvar_63.z);
    highp vec3 g_67;
    highp vec2 tmpvar_68;
    tmpvar_68.y = 0.0;
    tmpvar_68.x = tmpvar_66.x;
    lowp vec3 tmpvar_69;
    tmpvar_69 = ((texture (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
    g_67 = tmpvar_69;
    highp vec3 g_70;
    highp vec2 tmpvar_71;
    tmpvar_71.y = 0.0;
    tmpvar_71.x = tmpvar_66.z;
    lowp vec3 tmpvar_72;
    tmpvar_72 = ((texture (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
    g_70 = tmpvar_72;
    highp vec3 g_73;
    highp vec2 tmpvar_74;
    tmpvar_74.y = 0.0;
    tmpvar_74.x = tmpvar_66.y;
    lowp vec3 tmpvar_75;
    tmpvar_75 = ((texture (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
    g_73 = tmpvar_75;
    highp vec3 g_76;
    highp vec2 tmpvar_77;
    tmpvar_77.y = 0.0;
    tmpvar_77.x = tmpvar_66.w;
    lowp vec3 tmpvar_78;
    tmpvar_78 = ((texture (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
    g_76 = tmpvar_78;
    highp vec3 g_79;
    highp vec2 tmpvar_80;
    tmpvar_80.y = 0.0;
    tmpvar_80.x = (tmpvar_66.x + 0.00390625);
    lowp vec3 tmpvar_81;
    tmpvar_81 = ((texture (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
    g_79 = tmpvar_81;
    highp vec3 g_82;
    highp vec2 tmpvar_83;
    tmpvar_83.y = 0.0;
    tmpvar_83.x = (tmpvar_66.z + 0.00390625);
    lowp vec3 tmpvar_84;
    tmpvar_84 = ((texture (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
    g_82 = tmpvar_84;
    highp vec3 g_85;
    highp vec2 tmpvar_86;
    tmpvar_86.y = 0.0;
    tmpvar_86.x = (tmpvar_66.y + 0.00390625);
    lowp vec3 tmpvar_87;
    tmpvar_87 = ((texture (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
    g_85 = tmpvar_87;
    highp vec3 g_88;
    highp vec2 tmpvar_89;
    tmpvar_89.y = 0.0;
    tmpvar_89.x = (tmpvar_66.w + 0.00390625);
    lowp vec3 tmpvar_90;
    tmpvar_90 = ((texture (_Gradient3D, tmpvar_89).xyz * 2.0) - 1.0);
    g_88 = tmpvar_90;
    sum_51 = (sum_51 + (mix (mix (mix (dot (g_67, tmpvar_61), dot (g_70, (tmpvar_61 + vec3(-1.0, 0.0, 0.0))), tmpvar_62.x), mix (dot (g_73, (tmpvar_61 + vec3(0.0, -1.0, 0.0))), dot (g_76, (tmpvar_61 + vec3(-1.0, -1.0, 0.0))), tmpvar_62.x), tmpvar_62.y), mix (mix (dot (g_79, (tmpvar_61 + vec3(0.0, 0.0, -1.0))), dot (g_82, (tmpvar_61 + vec3(-1.0, 0.0, -1.0))), tmpvar_62.x), mix (dot (g_85, (tmpvar_61 + vec3(0.0, -1.0, -1.0))), dot (g_88, (tmpvar_61 + vec3(-1.0, -1.0, -1.0))), tmpvar_62.x), tmpvar_62.y), tmpvar_62.z) * amp_52));
    freq_53 = (freq_53 * _Lacunarity);
    amp_52 = (amp_52 * _Gain);
    i_50 = (i_50 + 1);
  };
  highp vec2 tmpvar_91;
  tmpvar_91.y = 0.0;
  tmpvar_91.x = (((((xlv_TEXCOORD1.y + tmpvar_46) + ((sum_51 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_1.xyz = (texture (_MainTex, tmpvar_91).xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o2.xyz, r0.x, v0
mad o1.xy, v2, c9, c9.zwzw
mad o3.xy, v3, c8, c8.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture2D (_MainTex, tmpvar_92).xyz;
  mediump vec3 lm_93;
  lowp vec3 tmpvar_94;
  tmpvar_94 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_93 = tmpvar_94;
  mediump vec3 tmpvar_95;
  tmpvar_95 = (c_3 * lm_93);
  c_1.xyz = tmpvar_95;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture2D (_MainTex, tmpvar_92).xyz;
  lowp vec4 tmpvar_93;
  tmpvar_93 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_94;
  lowp vec3 tmpvar_95;
  tmpvar_95 = ((8.0 * tmpvar_93.w) * tmpvar_93.xyz);
  lm_94 = tmpvar_95;
  mediump vec3 tmpvar_96;
  tmpvar_96 = (c_3 * lm_94);
  c_1.xyz = tmpvar_96;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture (_MainTex, tmpvar_92).xyz;
  mediump vec3 lm_93;
  lowp vec3 tmpvar_94;
  tmpvar_94 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_93 = tmpvar_94;
  mediump vec3 tmpvar_95;
  tmpvar_95 = (c_3 * lm_93);
  c_1.xyz = tmpvar_95;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 60 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [unity_Scale]
Vector 25 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[26] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[24].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[10];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[9];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[11];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[12];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[19];
DP4 R2.y, R4, c[18];
DP4 R2.x, R4, c[17];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[14];
MAD R1.xyz, R0.x, c[13], R1;
MAD R0.xyz, R0.z, c[15], R1;
MAD R1.xyz, R0.w, c[16], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R4.w, R0, c[22];
DP4 R4.z, R0, c[21];
DP4 R4.y, R0, c[20];
MUL R1.w, R3, R3;
MAD R0.w, R4.x, R4.x, -R1;
ADD R0.xyz, R2, R4.yzww;
MUL R2.xyz, R0.w, c[23];
DP3 R0.w, vertex.position, vertex.position;
ADD R0.xyz, R0, R2;
RSQ R0.w, R0.w;
ADD result.texcoord[3].xyz, R0, R1;
MUL result.texcoord[1].xyz, R0.w, vertex.position;
MOV result.texcoord[2].z, R3.x;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R4;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 60 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 60 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_4LightPosX0]
Vector 9 [unity_4LightPosY0]
Vector 10 [unity_4LightPosZ0]
Vector 11 [unity_4LightAtten0]
Vector 12 [unity_LightColor0]
Vector 13 [unity_LightColor1]
Vector 14 [unity_LightColor2]
Vector 15 [unity_LightColor3]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [unity_Scale]
Vector 24 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c25, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c23.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c9
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c8
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c25.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c10
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c11
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c25.x
dp4 r2.z, r4, c18
dp4 r2.y, r4, c17
dp4 r2.x, r4, c16
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c25.y
mul r0, r0, r1
mul r1.xyz, r0.y, c13
mad r1.xyz, r0.x, c12, r1
mad r0.xyz, r0.z, c14, r1
mad r1.xyz, r0.w, c15, r0
mul r0, r4.xyzz, r4.yzzx
dp4 r4.w, r0, c21
dp4 r4.z, r0, c20
dp4 r4.y, r0, c19
mul r1.w, r3, r3
mad r0.w, r4.x, r4.x, -r1
add r0.xyz, r2, r4.yzww
mul r2.xyz, r0.w, c22
dp3 r0.w, v0, v0
add r0.xyz, r0, r2
rsq r0.w, r0.w
add o4.xyz, r0, r1
mul o2.xyz, r0.w, v0
mov o3.z, r3.x
mov o3.y, r3.w
mov o3.x, r4
mad o1.xy, v2, c24, c24.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture2D (_MainTex, tmpvar_92).xyz;
  lowp vec4 c_93;
  c_93.xyz = ((c_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = (c_93.xyz + (c_3 * xlv_TEXCOORD3));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture2D (_MainTex, tmpvar_92).xyz;
  lowp vec4 c_93;
  c_93.xyz = ((c_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = (c_93.xyz + (c_3 * xlv_TEXCOORD3));
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp float stormStrength_2;
  lowp vec3 c_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_2 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_2) * _StormDistortion)) + stormStrength_2) * 0.5) - 0.5);
  c_3 = texture (_MainTex, tmpvar_92).xyz;
  lowp vec4 c_93;
  c_93.xyz = ((c_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = (c_93.xyz + (c_3 * xlv_TEXCOORD3));
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
// Stats: 557 math, 65 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_Lacunarity]
Float 3 [_Gain]
Float 4 [_MainFrequency]
Float 5 [_Distortion]
Float 6 [_StormFrequency]
Float 7 [_StormDistortion]
Float 8 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[2].x;
MUL R3.w, R1, c[4].x;
MUL R2.w, R3, c[2].x;
MOV R0.xz, c[8].x;
MOV R0.y, c[9];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[10].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[10].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[10];
MOV R4.y, c[9];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
ADD R4.xyz, R2, c[10].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[10].z;
ADD R3.x, R0.w, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[10].wwzw;
ADD R3.x, R0, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[10].zwzw;
ADD R3.x, R0.z, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[9].z, c[9].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[10].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[10].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[9];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[9].z, -c[9].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[10].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[10].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[10].wzzw;
ADD R3.x, R0.y, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[10].z;
ADD R3.x, R0.w, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[10].wwzw;
ADD R3.x, R0, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[10].zwzw;
ADD R3.x, R0.z, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[9].z, c[9].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[10].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[10].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[4].x;
FLR R5.xyz, R4;
MOV R0.y, c[9];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[9].z, -c[9].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[10].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[10].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[10].wzzw;
ADD R3.x, R0.y, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[10].z;
ADD R3.x, R0.w, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[10].wwzw;
ADD R3.x, R0, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[10].zwzw;
ADD R3.x, R0.z, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[9].z, c[9].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[10].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[10].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
MOV R0.y, c[9];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[9].z, -c[9].x;
MUL R2.w, R2, c[2].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[10].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[10].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[10].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[3], R0.w;
MUL R0.w, c[3].x, c[3].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[10].wzzw;
ADD R3.x, R2.y, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[10].z;
ADD R3.x, R2.w, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[10].wwzw;
ADD R3.x, R2, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[10].zwzw;
ADD R3.x, R2.z, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[9].z, c[9].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[10].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[10].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[9].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[6].x;
MOV R2.y, c[9];
ADD R5.xyz, R0, c[10].zwww;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[2].x;
MAD R4.xyz, R2, c[9].z, -c[9].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[10].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[10].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[10].wzzw;
MUL R0.x, R0.w, c[3];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[10];
MOV R5.y, c[9];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[9].z, -c[9].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[10].z;
ADD R2.x, R0.w, c[10];
MOV R2.y, c[9];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[9].z, -c[9].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[10].wwzw;
ADD R2.x, R0, c[10];
MOV R2.y, c[9];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[9].z, -c[9].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[10].zwzw;
ADD R2.x, R0.z, c[10];
MOV R2.y, c[9];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[9].z, -c[9].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[9].z, c[9].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[10].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[10].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[10].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[10].x;
MOV R0.y, c[9];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[9].z, -c[9].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[10].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[10].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[10].wzzw;
MUL R1.xyz, R1, c[6].x;
ADD R3.x, R0.y, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[10].z;
ADD R3.x, R0.w, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[10].wwzw;
ADD R3.x, R0, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[10].zwzw;
ADD R3.x, R0.z, c[10];
MOV R3.y, c[9];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[9].z, -c[9].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[9].z, c[9].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[10].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[10].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[9];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[9].z, -c[9].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[10].x;
MOV R0.y, c[9];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[9].z, -c[9].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[10].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[10].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[10];
MOV R3.y, c[9];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[9].z, -c[9].x;
ADD R3.xyz, R2, c[10].wzzw;
DP3 R4.x, R1, R3;
ADD R3.xyz, R2, c[10].z;
ADD R1.x, R0.w, c[10];
MOV R1.y, c[9];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[9].z, -c[9].x;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[9].z, c[9].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R4.xyz, R2, c[10].wwzw;
ADD R1.x, R0, c[10];
MOV R1.y, c[9];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[9].z, -c[9].x;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[10].zwzw;
ADD R1.x, R0.z, c[10];
MOV R1.y, c[9];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[9].z, -c[9].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[10].zwww;
MOV R1.x, R0;
MOV R1.y, c[9];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[9].z, -c[9].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[9];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[9].z, -c[9].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[9];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[9].z, -c[9].x;
ADD R1.xyz, R2, c[10].wzww;
DP3 R4.y, R0, R1;
ADD R1.xyz, R2, c[10].zzww;
MOV R0.x, R0.w;
MOV R0.y, c[9];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[9].z, -c[9].x;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[11];
MUL R0.x, R0, c[3];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[11].x, R0.w;
MUL R0.x, R0, c[3];
MAD R0.x, R2.w, R0, R0.y;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.x, R0, R0.w;
MAD R1.w, R1, c[5].x, fragment.texcoord[1].y;
MAD R0.x, R0, c[7], R1.w;
ADD R0.x, R0, R0.w;
MOV R0.y, c[9];
MAD R0.x, R0, c[11], -c[11];
TEX R0.xyz, R0, texture[3], 2D;
MUL R1.xyz, R0, fragment.texcoord[3];
MUL R2.xyz, R0, c[1];
DP3 R0.w, fragment.texcoord[2], c[0];
MAX R0.x, R0.w, c[9].y;
MUL R0.xyz, R0.x, R2;
MAD result.color.xyz, R0, c[9].z, R1;
MOV result.color.w, c[9].x;
END
# 557 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 165 math, 20 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_Lacunarity]
Float 3 [_Gain]
Float 4 [_MainFrequency]
Float 5 [_Distortion]
Float 6 [_StormFrequency]
Float 7 [_StormDistortion]
Float 8 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0.50000000, 0
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.xz, c8.x
mov r0.y, c9.x
add r1.xyz, v1, r0
mov r0.w, c9.x
mov r1.w, c4.x
mov r3.w, c9.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c10.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c10.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c9.z, c9.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c11.yyxw
add r4.x, r2, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r2.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c10
add r5.x, r2, -r6
mov r4.y, c9.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r4.x, r2, r4
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c2.x
mul r3.w, r3, c3.x
endloop
mov r0.xz, c8.x
mov r0.y, c9.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c5.x
mov r3.w, c6.x
mov r4.w, c11.z
mov r5.w, c9.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c10.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c10.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c9.z, c9.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c11.yyxw
add r4.x, r2, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r2.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c10
add r5.x, r2, -r6.z
mov r4.y, c9.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r4.x, r2, r4
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c2.x
mul r4.w, r4, c3.x
endloop
add r0.y, v1, r0.w
mul r0.x, r5.w, r1.w
mad r0.x, r0, c7, r0.y
add r0.x, r0, r1.w
mov r0.y, c9.x
mad r0.x, r0, c11.z, -c11.z
texld r0.xyz, r0, s3
mul_pp r1.xyz, r0, v3
mul_pp r2.xyz, r0, c1
dp3_pp r0.w, v2, c0
max_pp r0.x, r0.w, c9
mul_pp r0.xyz, r0.x, r2
mad_pp oC0.xyz, r0, c9.z, r1
mov_pp oC0.w, c9.y
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 555 math, 66 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Lacunarity]
Float 1 [_Gain]
Float 2 [_MainFrequency]
Float 3 [_Distortion]
Float 4 [_StormFrequency]
Float 5 [_StormDistortion]
Float 6 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"3.0-!!ARBfp1.0
PARAM c[10] = { program.local[0..6],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[0].x;
MUL R3.w, R1, c[2].x;
MUL R2.w, R3, c[0].x;
MOV R0.xz, c[6].x;
MOV R0.y, c[7];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[8].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[8].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[8];
MOV R4.y, c[7];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
ADD R4.xyz, R2, c[8].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[8].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[8].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[8].wzzw;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[2].x;
FLR R5.xyz, R4;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[8].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[8].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[8].wzzw;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
MOV R0.y, c[7];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[7].z, -c[7].x;
MUL R2.w, R2, c[0].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[8].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[8].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[8].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[1], R0.w;
MUL R0.w, c[1].x, c[1].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[8].wzzw;
ADD R3.x, R2.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[8].z;
ADD R3.x, R2.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[8].wwzw;
ADD R3.x, R2, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[8].zwzw;
ADD R3.x, R2.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[7].z, c[7].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[8].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[8].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[7].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[4].x;
MOV R2.y, c[7];
ADD R5.xyz, R0, c[8].zwww;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[0].x;
MAD R4.xyz, R2, c[7].z, -c[7].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[8].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[8].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[8].wzzw;
MUL R0.x, R0.w, c[1];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[8];
MOV R5.y, c[7];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[8].z;
ADD R2.x, R0.w, c[8];
MOV R2.y, c[7];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[8].wwzw;
ADD R2.x, R0, c[8];
MOV R2.y, c[7];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[8].zwzw;
ADD R2.x, R0.z, c[8];
MOV R2.y, c[7];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[7].z, c[7].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[8].x;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[8].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[8].wzzw;
MUL R1.xyz, R1, c[4].x;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[8].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[8].x;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[8].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
ADD R3.xyz, R2, c[8].wzzw;
DP3 R4.x, R1, R3;
ADD R1.x, R0.w, c[8];
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
ADD R3.xyz, R2, c[8].z;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R1.x, R0, c[8];
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
ADD R4.xyz, R2, c[8].wwzw;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R1.x, R0.z, c[8];
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[8].zwww;
MOV R1.x, R0;
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[7];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
ADD R1.xyz, R2, c[8].wzww;
DP3 R4.y, R0, R1;
ADD R1.xyz, R2, c[8].zzww;
MOV R0.x, R0.w;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[9];
MUL R0.x, R0, c[1];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[9].x, R0.w;
MUL R0.x, R0, c[1];
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MAD R0.x, R2.w, R0, R0.y;
MUL R0.x, R0, R0.w;
MAD R1.w, R1, c[3].x, fragment.texcoord[1].y;
MAD R0.x, R0, c[5], R1.w;
ADD R0.x, R0, R0.w;
MAD R1.x, R0, c[9], -c[9];
MOV R1.y, c[7];
TEX R0, fragment.texcoord[2], texture[4], 2D;
TEX R1.xyz, R1, texture[3], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[9].y;
MOV result.color.w, c[7].x;
END
# 555 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 162 math, 21 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_Lacunarity]
Float 1 [_Gain]
Float 2 [_MainFrequency]
Float 3 [_Distortion]
Float 4 [_StormFrequency]
Float 5 [_StormDistortion]
Float 6 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c8, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c9, -1.00000000, 0.00000000, 0.50000000, 8.00000000
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
mov r0.xz, c6.x
mov r0.y, c7.x
add r1.xyz, v1, r0
mov r0.w, c7.x
mov r1.w, c2.x
mov r3.w, c7.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c8.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c8.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c8.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c9.yxyw
mov r0.x, r2
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c8.z, c8.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c9.xxyw
mov r0.y, c7.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c9.xyyw
mov r0.x, r2.z
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c7.z, c7.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c9.yyxw
add r4.x, r2, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c9.xyxw
add r4.x, r2.z, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c8
add r5.x, r2, -r6
mov r4.y, c7.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c9.yxxw
mad r2.xyz, r2, c8.z, c8.w
dp3 r4.x, r2, r4
mov r2.y, c7.x
add r2.x, r2.w, c8
texld r2.xyz, r2, s1
mad r2.xyz, r2, c8.z, c8.w
add r3.xyz, r3, c9.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c0.x
mul r3.w, r3, c1.x
endloop
mov r0.xz, c6.x
mov r0.y, c7.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c3.x
mov r3.w, c4.x
mov r4.w, c9.z
mov r5.w, c7.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c8.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c8.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c8.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c9.yxyw
mov r0.x, r2
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c8.z, c8.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c9.xxyw
mov r0.y, c7.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c9.xyyw
mov r0.x, r2.z
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c7.z, c7.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c9.yyxw
add r4.x, r2, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c9.xyxw
add r4.x, r2.z, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c8
add r5.x, r2, -r6.z
mov r4.y, c7.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c9.yxxw
mad r2.xyz, r2, c8.z, c8.w
dp3 r4.x, r2, r4
mov r2.y, c7.x
add r2.x, r2.w, c8
texld r2.xyz, r2, s1
mad r2.xyz, r2, c8.z, c8.w
add r3.xyz, r3, c9.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c0.x
mul r4.w, r4, c1.x
endloop
add r0.y, v1, r0.w
mul r0.x, r5.w, r1.w
mad r1.x, r0, c5, r0.y
texld r0, v2, s4
add r1.x, r1, r1.w
mov r1.y, c7.x
mad r1.x, r1, c9.z, -c9.z
texld r1.xyz, r1, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c9.w
mov_pp oC0.w, c7.y
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 555 math, 66 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Lacunarity]
Float 1 [_Gain]
Float 2 [_MainFrequency]
Float 3 [_Distortion]
Float 4 [_StormFrequency]
Float 5 [_StormDistortion]
Float 6 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"3.0-!!ARBfp1.0
PARAM c[10] = { program.local[0..6],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[0].x;
MUL R3.w, R1, c[2].x;
MUL R2.w, R3, c[0].x;
MOV R0.xz, c[6].x;
MOV R0.y, c[7];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[8].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[8].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[8];
MOV R4.y, c[7];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
ADD R4.xyz, R2, c[8].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[8].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[8].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[8].wzzw;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[2].x;
FLR R5.xyz, R4;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[8].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[8].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[8].wzzw;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
MOV R0.y, c[7];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[7].z, -c[7].x;
MUL R2.w, R2, c[0].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[8].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[8].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[8].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[1], R0.w;
MUL R0.w, c[1].x, c[1].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[8].wzzw;
ADD R3.x, R2.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[8].z;
ADD R3.x, R2.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[8].wwzw;
ADD R3.x, R2, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[8].zwzw;
ADD R3.x, R2.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[7].z, c[7].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[8].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[8].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[7].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[4].x;
MOV R2.y, c[7];
ADD R5.xyz, R0, c[8].zwww;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[0].x;
MAD R4.xyz, R2, c[7].z, -c[7].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[8].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[8].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[8].wzzw;
MUL R0.x, R0.w, c[1];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[8];
MOV R5.y, c[7];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[8].z;
ADD R2.x, R0.w, c[8];
MOV R2.y, c[7];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[8].wwzw;
ADD R2.x, R0, c[8];
MOV R2.y, c[7];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[8].zwzw;
ADD R2.x, R0.z, c[8];
MOV R2.y, c[7];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[7].z, -c[7].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[7].z, c[7].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[8].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[8].x;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[8].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[8].wzzw;
MUL R1.xyz, R1, c[4].x;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[8].z;
ADD R3.x, R0.w, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[8].wwzw;
ADD R3.x, R0, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R3.x, R0.z, c[8];
MOV R3.y, c[7];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[7].z, -c[7].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[8].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[8].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[8].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[7];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[7].z, -c[7].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[8].x;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[8].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[8].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[8];
MOV R3.y, c[7];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
ADD R3.xyz, R2, c[8].wzzw;
DP3 R4.x, R1, R3;
ADD R1.x, R0.w, c[8];
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
ADD R3.xyz, R2, c[8].z;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[7].z, c[7].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R1.x, R0, c[8];
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
ADD R4.xyz, R2, c[8].wwzw;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[8].zwzw;
ADD R1.x, R0.z, c[8];
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[8].zwww;
MOV R1.x, R0;
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[7];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[7].z, -c[7].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[7];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
ADD R1.xyz, R2, c[8].wzww;
DP3 R4.y, R0, R1;
ADD R1.xyz, R2, c[8].zzww;
MOV R0.x, R0.w;
MOV R0.y, c[7];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[7].z, -c[7].x;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[9];
MUL R0.x, R0, c[1];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[9].x, R0.w;
MUL R0.x, R0, c[1];
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MAD R0.x, R2.w, R0, R0.y;
MUL R0.x, R0, R0.w;
MAD R1.w, R1, c[3].x, fragment.texcoord[1].y;
MAD R0.x, R0, c[5], R1.w;
ADD R0.x, R0, R0.w;
MAD R1.x, R0, c[9], -c[9];
MOV R1.y, c[7];
TEX R0, fragment.texcoord[2], texture[4], 2D;
TEX R1.xyz, R1, texture[3], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[9].y;
MOV result.color.w, c[7].x;
END
# 555 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 162 math, 21 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_Lacunarity]
Float 1 [_Gain]
Float 2 [_MainFrequency]
Float 3 [_Distortion]
Float 4 [_StormFrequency]
Float 5 [_StormDistortion]
Float 6 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [unity_Lightmap] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c7, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c8, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c9, -1.00000000, 0.00000000, 0.50000000, 8.00000000
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xy
mov r0.xz, c6.x
mov r0.y, c7.x
add r1.xyz, v1, r0
mov r0.w, c7.x
mov r1.w, c2.x
mov r3.w, c7.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c8.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c8.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c8.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c9.yxyw
mov r0.x, r2
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c8.z, c8.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c9.xxyw
mov r0.y, c7.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c9.xyyw
mov r0.x, r2.z
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c7.z, c7.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c9.yyxw
add r4.x, r2, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c9.xyxw
add r4.x, r2.z, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c8
add r5.x, r2, -r6
mov r4.y, c7.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c9.yxxw
mad r2.xyz, r2, c8.z, c8.w
dp3 r4.x, r2, r4
mov r2.y, c7.x
add r2.x, r2.w, c8
texld r2.xyz, r2, s1
mad r2.xyz, r2, c8.z, c8.w
add r3.xyz, r3, c9.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c0.x
mul r3.w, r3, c1.x
endloop
mov r0.xz, c6.x
mov r0.y, c7.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c3.x
mov r3.w, c4.x
mov r4.w, c9.z
mov r5.w, c7.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c8.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c8.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c8.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c9.yxyw
mov r0.x, r2
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c8.z, c8.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c9.xxyw
mov r0.y, c7.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c9.xyyw
mov r0.x, r2.z
mov r0.y, c7.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c8.z, c8.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c7.z, c7.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c9.yyxw
add r4.x, r2, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c9.xyxw
add r4.x, r2.z, c8
mov r4.y, c7.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c8.z, c8.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c8
add r5.x, r2, -r6.z
mov r4.y, c7.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c9.yxxw
mad r2.xyz, r2, c8.z, c8.w
dp3 r4.x, r2, r4
mov r2.y, c7.x
add r2.x, r2.w, c8
texld r2.xyz, r2, s1
mad r2.xyz, r2, c8.z, c8.w
add r3.xyz, r3, c9.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c0.x
mul r4.w, r4, c1.x
endloop
add r0.y, v1, r0.w
mul r0.x, r5.w, r1.w
mad r1.x, r0, c5, r0.y
texld r0, v2, s4
add r1.x, r1, r1.w
mov r1.y, c7.x
mad r1.x, r1, c9.z, -c9.z
texld r1.xyz, r1, s3
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c9.w
mov_pp oC0.w, c7.y
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }


 // Stats for Vertex shader:
 //        d3d9 : 18 avg math (13..21)
 //      opengl : 18 avg math (13..21)
 // Stats for Fragment shader:
 //        d3d9 : 168 avg math (165..174), 21 avg texture (20..22), 10 branch
 //      opengl : 563 avg math (557..575), 66 avg texture (65..67)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "ForceNoShadowCasting"="true" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "POINT" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "SPOT" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
SubProgram "opengl " {
// Stats: 20 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.position, vertex.position;
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
RSQ R0.w, R1.x;
MUL R1.xyz, vertex.normal, c[14].w;
MUL result.texcoord[1].xyz, R0.w, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
rsq r0.w, r1.x
mul r1.xyz, v1, c13.w
mul o2.xyz, r0.w, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
add o4.xyz, -r0, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_95;
  c_95.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_94)).w) * 2.0));
  c_95.w = 1.0;
  c_1.xyz = c_95.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_95;
  c_95.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_94)).w) * 2.0));
  c_95.w = 1.0;
  c_1.xyz = c_95.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_95;
  c_95.xyz = ((texture (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * texture (_LightTexture0, vec2(tmpvar_94)).w) * 2.0));
  c_95.w = 1.0;
  c_1.xyz = c_95.xyz;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 13 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
Vector 11 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
MUL R0.yzw, vertex.normal.xxyz, c[10].w;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
DP3 result.texcoord[2].z, R0.yzww, c[7];
DP3 result.texcoord[2].y, R0.yzww, c[6];
DP3 result.texcoord[2].x, R0.yzww, c[5];
MOV result.texcoord[3].xyz, c[9];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 13 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 13 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [unity_Scale]
Vector 10 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.yzw, v1.xxyz, c9.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o2.xyz, r0.x, v0
dp3 o3.z, r0.yzww, c6
dp3 o3.y, r0.yzww, c5
dp3 o3.x, r0.yzww, c4
mov o4.xyz, c8
mad o1.xy, v2, c10, c10.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_93;
  c_93.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = c_93.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_93;
  c_93.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = c_93.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_93;
  c_93.xyz = ((texture (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = c_93.xyz;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 21 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.position, vertex.position;
DP4 result.texcoord[4].w, R0, c[12];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
RSQ R0.w, R1.x;
MUL R1.xyz, vertex.normal, c[14].w;
MUL result.texcoord[1].xyz, R0.w, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 21 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 21 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o5.w, r0, c11
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
rsq r0.w, r1.x
mul r1.xyz, v1, c13.w
mul o2.xyz, r0.w, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
add o4.xyz, -r0, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp vec2 P_94;
  P_94 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_95;
  tmpvar_95 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp float atten_96;
  atten_96 = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, P_94).w) * texture2D (_LightTextureB0, vec2(tmpvar_95)).w);
  lowp vec4 c_97;
  c_97.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * atten_96) * 2.0));
  c_97.w = 1.0;
  c_1.xyz = c_97.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp vec2 P_94;
  P_94 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_95;
  tmpvar_95 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp float atten_96;
  atten_96 = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, P_94).w) * texture2D (_LightTextureB0, vec2(tmpvar_95)).w);
  lowp vec4 c_97;
  c_97.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * atten_96) * 2.0));
  c_97.w = 1.0;
  c_1.xyz = c_97.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp vec2 P_94;
  P_94 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_95;
  tmpvar_95 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp float atten_96;
  atten_96 = ((float((xlv_TEXCOORD4.z > 0.0)) * texture (_LightTexture0, P_94).w) * texture (_LightTextureB0, vec2(tmpvar_95)).w);
  lowp vec4 c_97;
  c_97.xyz = ((texture (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * atten_96) * 2.0));
  c_97.w = 1.0;
  c_1.xyz = c_97.xyz;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 20 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.position, vertex.position;
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
RSQ R0.w, R1.x;
MUL R1.xyz, vertex.normal, c[14].w;
MUL result.texcoord[1].xyz, R0.w, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
rsq r0.w, r1.x
mul r1.xyz, v1, c13.w
mul o2.xyz, r0.w, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
add o4.xyz, -r0, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_95;
  c_95.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_94)).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w)) * 2.0));
  c_95.w = 1.0;
  c_1.xyz = c_95.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_95;
  c_95.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_94)).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w)) * 2.0));
  c_95.w = 1.0;
  c_1.xyz = c_95.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  mediump vec3 tmpvar_93;
  tmpvar_93 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_93;
  highp float tmpvar_94;
  tmpvar_94 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_95;
  c_95.xyz = ((texture (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * (texture (_LightTextureB0, vec2(tmpvar_94)).w * texture (_LightTexture0, xlv_TEXCOORD4).w)) * 2.0));
  c_95.w = 1.0;
  c_1.xyz = c_95.xyz;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 19 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
Vector 15 [_StormMap_ST]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
DP4 R0.x, vertex.position, c[5];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.y, vertex.position, c[6];
DP3 R1.x, vertex.position, vertex.position;
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
RSQ R0.x, R1.x;
MUL R1.xyz, vertex.normal, c[14].w;
MUL result.texcoord[1].xyz, R0.x, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 19 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
Vector 14 [_StormMap_ST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
dp4 r0.x, v0, c4
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
rsq r0.x, r1.x
mul r1.xyz, v1, c13.w
mul o2.xyz, r0.x, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
mov o4.xyz, c12
mad o1.xy, v2, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_93;
  c_93.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD4).w) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = c_93.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture2D (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture2D (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture2D (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture2D (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture2D (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture2D (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture2D (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture2D (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture2D (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture2D (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture2D (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_93;
  c_93.xyz = ((texture2D (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD4).w) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = c_93.xyz;
  c_1.w = 1.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _StormMap_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _StormMap_ST.xy) + _StormMap_ST.zw);
  xlv_TEXCOORD1 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D _MainTex;
uniform highp float _MainFrequency;
uniform mediump float _Distortion;
uniform sampler2D _StormMap;
uniform highp float _StormFrequency;
uniform mediump float _StormDistortion;
uniform highp float _Evolution;
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  highp float stormStrength_3;
  highp vec3 tmpvar_4;
  tmpvar_4.y = 0.0;
  tmpvar_4.x = _Evolution;
  tmpvar_4.z = _Evolution;
  highp vec3 p_5;
  p_5 = (xlv_TEXCOORD1 + tmpvar_4);
  int i_6;
  highp float amp_7;
  highp float freq_8;
  highp float sum_9;
  sum_9 = 0.0;
  freq_8 = _MainFrequency;
  amp_7 = 1.0;
  i_6 = 0;
  for (int i_6 = 0; i_6 < 4; ) {
    highp vec3 p_10;
    p_10 = (p_5 * freq_8);
    highp vec3 tmpvar_11;
    tmpvar_11 = (floor(p_10) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_12;
    tmpvar_12 = (fract(abs(tmpvar_11)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_13;
    if ((tmpvar_11.x >= 0.0)) {
      tmpvar_13 = tmpvar_12.x;
    } else {
      tmpvar_13 = -(tmpvar_12.x);
    };
    highp float tmpvar_14;
    if ((tmpvar_11.y >= 0.0)) {
      tmpvar_14 = tmpvar_12.y;
    } else {
      tmpvar_14 = -(tmpvar_12.y);
    };
    highp float tmpvar_15;
    if ((tmpvar_11.z >= 0.0)) {
      tmpvar_15 = tmpvar_12.z;
    } else {
      tmpvar_15 = -(tmpvar_12.z);
    };
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_13;
    tmpvar_16.y = tmpvar_14;
    tmpvar_16.z = tmpvar_15;
    highp vec3 tmpvar_17;
    tmpvar_17 = (p_10 - floor(p_10));
    p_10 = tmpvar_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = ((tmpvar_17 * tmpvar_17) * (3.0 - (2.0 * tmpvar_17)));
    highp vec3 tmpvar_19;
    tmpvar_19 = (tmpvar_16 / 256.0);
    highp vec4 tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_PermTable2D, tmpvar_19.xy);
    tmpvar_20 = tmpvar_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_20 + tmpvar_19.z);
    highp vec3 g_23;
    highp vec2 tmpvar_24;
    tmpvar_24.y = 0.0;
    tmpvar_24.x = tmpvar_22.x;
    lowp vec3 tmpvar_25;
    tmpvar_25 = ((texture (_Gradient3D, tmpvar_24).xyz * 2.0) - 1.0);
    g_23 = tmpvar_25;
    highp vec3 g_26;
    highp vec2 tmpvar_27;
    tmpvar_27.y = 0.0;
    tmpvar_27.x = tmpvar_22.z;
    lowp vec3 tmpvar_28;
    tmpvar_28 = ((texture (_Gradient3D, tmpvar_27).xyz * 2.0) - 1.0);
    g_26 = tmpvar_28;
    highp vec3 g_29;
    highp vec2 tmpvar_30;
    tmpvar_30.y = 0.0;
    tmpvar_30.x = tmpvar_22.y;
    lowp vec3 tmpvar_31;
    tmpvar_31 = ((texture (_Gradient3D, tmpvar_30).xyz * 2.0) - 1.0);
    g_29 = tmpvar_31;
    highp vec3 g_32;
    highp vec2 tmpvar_33;
    tmpvar_33.y = 0.0;
    tmpvar_33.x = tmpvar_22.w;
    lowp vec3 tmpvar_34;
    tmpvar_34 = ((texture (_Gradient3D, tmpvar_33).xyz * 2.0) - 1.0);
    g_32 = tmpvar_34;
    highp vec3 g_35;
    highp vec2 tmpvar_36;
    tmpvar_36.y = 0.0;
    tmpvar_36.x = (tmpvar_22.x + 0.00390625);
    lowp vec3 tmpvar_37;
    tmpvar_37 = ((texture (_Gradient3D, tmpvar_36).xyz * 2.0) - 1.0);
    g_35 = tmpvar_37;
    highp vec3 g_38;
    highp vec2 tmpvar_39;
    tmpvar_39.y = 0.0;
    tmpvar_39.x = (tmpvar_22.z + 0.00390625);
    lowp vec3 tmpvar_40;
    tmpvar_40 = ((texture (_Gradient3D, tmpvar_39).xyz * 2.0) - 1.0);
    g_38 = tmpvar_40;
    highp vec3 g_41;
    highp vec2 tmpvar_42;
    tmpvar_42.y = 0.0;
    tmpvar_42.x = (tmpvar_22.y + 0.00390625);
    lowp vec3 tmpvar_43;
    tmpvar_43 = ((texture (_Gradient3D, tmpvar_42).xyz * 2.0) - 1.0);
    g_41 = tmpvar_43;
    highp vec3 g_44;
    highp vec2 tmpvar_45;
    tmpvar_45.y = 0.0;
    tmpvar_45.x = (tmpvar_22.w + 0.00390625);
    lowp vec3 tmpvar_46;
    tmpvar_46 = ((texture (_Gradient3D, tmpvar_45).xyz * 2.0) - 1.0);
    g_44 = tmpvar_46;
    sum_9 = (sum_9 + (abs(mix (mix (mix (dot (g_23, tmpvar_17), dot (g_26, (tmpvar_17 + vec3(-1.0, 0.0, 0.0))), tmpvar_18.x), mix (dot (g_29, (tmpvar_17 + vec3(0.0, -1.0, 0.0))), dot (g_32, (tmpvar_17 + vec3(-1.0, -1.0, 0.0))), tmpvar_18.x), tmpvar_18.y), mix (mix (dot (g_35, (tmpvar_17 + vec3(0.0, 0.0, -1.0))), dot (g_38, (tmpvar_17 + vec3(-1.0, 0.0, -1.0))), tmpvar_18.x), mix (dot (g_41, (tmpvar_17 + vec3(0.0, -1.0, -1.0))), dot (g_44, (tmpvar_17 + vec3(-1.0, -1.0, -1.0))), tmpvar_18.x), tmpvar_18.y), tmpvar_18.z)) * amp_7));
    freq_8 = (freq_8 * _Lacunarity);
    amp_7 = (amp_7 * _Gain);
    i_6 = (i_6 + 1);
  };
  highp float tmpvar_47;
  tmpvar_47 = (sum_9 * _Distortion);
  lowp float tmpvar_48;
  tmpvar_48 = texture (_StormMap, xlv_TEXCOORD0).w;
  stormStrength_3 = tmpvar_48;
  highp vec3 tmpvar_49;
  tmpvar_49.y = 0.0;
  tmpvar_49.x = _Evolution;
  tmpvar_49.z = _Evolution;
  highp vec3 p_50;
  p_50 = (xlv_TEXCOORD1 + tmpvar_49);
  int i_51;
  highp float sum_52;
  highp float amp_53;
  highp float freq_54;
  freq_54 = _StormFrequency;
  amp_53 = 0.5;
  sum_52 = 0.0;
  i_51 = 0;
  for (int i_51 = 0; i_51 < 3; ) {
    highp vec3 p_55;
    p_55 = (p_50 * freq_54);
    highp vec3 tmpvar_56;
    tmpvar_56 = (floor(p_55) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_57;
    tmpvar_57 = (fract(abs(tmpvar_56)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_58;
    if ((tmpvar_56.x >= 0.0)) {
      tmpvar_58 = tmpvar_57.x;
    } else {
      tmpvar_58 = -(tmpvar_57.x);
    };
    highp float tmpvar_59;
    if ((tmpvar_56.y >= 0.0)) {
      tmpvar_59 = tmpvar_57.y;
    } else {
      tmpvar_59 = -(tmpvar_57.y);
    };
    highp float tmpvar_60;
    if ((tmpvar_56.z >= 0.0)) {
      tmpvar_60 = tmpvar_57.z;
    } else {
      tmpvar_60 = -(tmpvar_57.z);
    };
    highp vec3 tmpvar_61;
    tmpvar_61.x = tmpvar_58;
    tmpvar_61.y = tmpvar_59;
    tmpvar_61.z = tmpvar_60;
    highp vec3 tmpvar_62;
    tmpvar_62 = (p_55 - floor(p_55));
    p_55 = tmpvar_62;
    highp vec3 tmpvar_63;
    tmpvar_63 = ((tmpvar_62 * tmpvar_62) * (3.0 - (2.0 * tmpvar_62)));
    highp vec3 tmpvar_64;
    tmpvar_64 = (tmpvar_61 / 256.0);
    highp vec4 tmpvar_65;
    lowp vec4 tmpvar_66;
    tmpvar_66 = texture (_PermTable2D, tmpvar_64.xy);
    tmpvar_65 = tmpvar_66;
    highp vec4 tmpvar_67;
    tmpvar_67 = (tmpvar_65 + tmpvar_64.z);
    highp vec3 g_68;
    highp vec2 tmpvar_69;
    tmpvar_69.y = 0.0;
    tmpvar_69.x = tmpvar_67.x;
    lowp vec3 tmpvar_70;
    tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
    g_68 = tmpvar_70;
    highp vec3 g_71;
    highp vec2 tmpvar_72;
    tmpvar_72.y = 0.0;
    tmpvar_72.x = tmpvar_67.z;
    lowp vec3 tmpvar_73;
    tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
    g_71 = tmpvar_73;
    highp vec3 g_74;
    highp vec2 tmpvar_75;
    tmpvar_75.y = 0.0;
    tmpvar_75.x = tmpvar_67.y;
    lowp vec3 tmpvar_76;
    tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
    g_74 = tmpvar_76;
    highp vec3 g_77;
    highp vec2 tmpvar_78;
    tmpvar_78.y = 0.0;
    tmpvar_78.x = tmpvar_67.w;
    lowp vec3 tmpvar_79;
    tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
    g_77 = tmpvar_79;
    highp vec3 g_80;
    highp vec2 tmpvar_81;
    tmpvar_81.y = 0.0;
    tmpvar_81.x = (tmpvar_67.x + 0.00390625);
    lowp vec3 tmpvar_82;
    tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
    g_80 = tmpvar_82;
    highp vec3 g_83;
    highp vec2 tmpvar_84;
    tmpvar_84.y = 0.0;
    tmpvar_84.x = (tmpvar_67.z + 0.00390625);
    lowp vec3 tmpvar_85;
    tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
    g_83 = tmpvar_85;
    highp vec3 g_86;
    highp vec2 tmpvar_87;
    tmpvar_87.y = 0.0;
    tmpvar_87.x = (tmpvar_67.y + 0.00390625);
    lowp vec3 tmpvar_88;
    tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
    g_86 = tmpvar_88;
    highp vec3 g_89;
    highp vec2 tmpvar_90;
    tmpvar_90.y = 0.0;
    tmpvar_90.x = (tmpvar_67.w + 0.00390625);
    lowp vec3 tmpvar_91;
    tmpvar_91 = ((texture (_Gradient3D, tmpvar_90).xyz * 2.0) - 1.0);
    g_89 = tmpvar_91;
    sum_52 = (sum_52 + (mix (mix (mix (dot (g_68, tmpvar_62), dot (g_71, (tmpvar_62 + vec3(-1.0, 0.0, 0.0))), tmpvar_63.x), mix (dot (g_74, (tmpvar_62 + vec3(0.0, -1.0, 0.0))), dot (g_77, (tmpvar_62 + vec3(-1.0, -1.0, 0.0))), tmpvar_63.x), tmpvar_63.y), mix (mix (dot (g_80, (tmpvar_62 + vec3(0.0, 0.0, -1.0))), dot (g_83, (tmpvar_62 + vec3(-1.0, 0.0, -1.0))), tmpvar_63.x), mix (dot (g_86, (tmpvar_62 + vec3(0.0, -1.0, -1.0))), dot (g_89, (tmpvar_62 + vec3(-1.0, -1.0, -1.0))), tmpvar_63.x), tmpvar_63.y), tmpvar_63.z) * amp_53));
    freq_54 = (freq_54 * _Lacunarity);
    amp_53 = (amp_53 * _Gain);
    i_51 = (i_51 + 1);
  };
  highp vec2 tmpvar_92;
  tmpvar_92.y = 0.0;
  tmpvar_92.x = (((((xlv_TEXCOORD1.y + tmpvar_47) + ((sum_52 * stormStrength_3) * _StormDistortion)) + stormStrength_3) * 0.5) - 0.5);
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_93;
  c_93.xyz = ((texture (_MainTex, tmpvar_92).xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir_2)) * texture (_LightTexture0, xlv_TEXCOORD4).w) * 2.0));
  c_93.w = 1.0;
  c_1.xyz = c_93.xyz;
  c_1.w = 1.0;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
// Stats: 562 math, 66 textures
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..7],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[1].x;
MUL R3.w, R1, c[3].x;
MUL R2.w, R3, c[1].x;
MOV R0.xz, c[7].x;
MOV R0.y, c[8];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[9].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[9];
MOV R4.y, c[8];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[3].x;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
MOV R0.y, c[8];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[8].z, -c[8].x;
MUL R2.w, R2, c[1].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[9].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[9].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[9].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[2], R0.w;
MUL R0.w, c[2].x, c[2].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[9].wzzw;
ADD R3.x, R2.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[9].z;
ADD R3.x, R2.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[9].wwzw;
ADD R3.x, R2, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[9].zwzw;
ADD R3.x, R2.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[8].z, c[8].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[9].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[9].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[8].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[5].x;
MOV R2.y, c[8];
ADD R5.xyz, R0, c[9].zwww;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[1].x;
MAD R4.xyz, R2, c[8].z, -c[8].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[9].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[9].wzzw;
MUL R0.x, R0.w, c[2];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[9];
MOV R5.y, c[8];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[9].z;
ADD R2.x, R0.w, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[9].wwzw;
ADD R2.x, R0, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[9].zwzw;
ADD R2.x, R0.z, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[8].z, c[8].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[9].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[9].wzzw;
MUL R1.xyz, R1, c[5].x;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[9].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[9].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].wzzw;
DP3 R4.x, R1, R3;
ADD R1.x, R0.w, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].z;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R1.x, R0, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wwzw;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R1.x, R0.z, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[9].zwww;
MOV R1.x, R0;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[8];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].wzww;
DP3 R4.y, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].zzww;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[10];
MUL R0.x, R0, c[2];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[10].x, R0.w;
MUL R0.x, R0, c[2];
MAD R0.x, R2.w, R0, R0.y;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.x, R0, R0.w;
MAD R1.w, R1, c[4].x, fragment.texcoord[1].y;
MAD R0.x, R0, c[6], R1.w;
ADD R0.x, R0, R0.w;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MAD R0.x, R0, c[10], -c[10];
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[3], 2D;
MUL R1.xyz, R0, c[0];
MUL R0.xyz, R0.w, fragment.texcoord[3];
DP3 R0.x, fragment.texcoord[2], R0;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
TEX R0.w, R0.w, texture[4], 2D;
MAX R0.x, R0, c[8].y;
MUL R0.x, R0, R0.w;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[8].z;
MOV result.color.w, c[8].x;
END
# 562 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 169 math, 21 textures, 10 branches
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 0.50000000, 0
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
mov r0.w, c8.x
mov r1.w, c3.x
mov r3.w, c8.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c1.x
mul r3.w, r3, c2.x
endloop
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c4.x
mov r3.w, c5.x
mov r4.w, c10.z
mov r5.w, c8.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6.z
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c1.x
mul r4.w, r4, c2.x
endloop
add r0.y, v1, r0.w
mul r0.x, r5.w, r1.w
mad r0.x, r0, c6, r0.y
add r0.x, r0, r1.w
dp3_pp r0.w, v3, v3
rsq_pp r0.w, r0.w
mad r0.x, r0, c10.z, -c10.z
mov r0.y, c8.x
texld r0.xyz, r0, s3
mul_pp r2.xyz, r0, c0
mul_pp r1.xyz, r0.w, v3
dp3 r0.x, v4, v4
dp3_pp r0.y, v2, r1
max_pp r0.y, r0, c8.x
texld r0.x, r0.x, s4
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c8.z
mov_pp oC0.w, c8.y
"
}
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 557 math, 65 textures
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..7],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[1].x;
MUL R3.w, R1, c[3].x;
MUL R2.w, R3, c[1].x;
MOV R0.xz, c[7].x;
MOV R0.y, c[8];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[9].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[9];
MOV R4.y, c[8];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[3].x;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
MOV R0.y, c[8];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[8].z, -c[8].x;
MUL R2.w, R2, c[1].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[9].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[9].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[9].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[2], R0.w;
MUL R0.w, c[2].x, c[2].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[9].wzzw;
ADD R3.x, R2.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[9].z;
ADD R3.x, R2.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[9].wwzw;
ADD R3.x, R2, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[9].zwzw;
ADD R3.x, R2.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[8].z, c[8].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[9].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[9].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[8].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[5].x;
MOV R2.y, c[8];
ADD R5.xyz, R0, c[9].zwww;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[1].x;
MAD R4.xyz, R2, c[8].z, -c[8].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[9].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[9].wzzw;
MUL R0.x, R0.w, c[2];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[9];
MOV R5.y, c[8];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[9].z;
ADD R2.x, R0.w, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[9].wwzw;
ADD R2.x, R0, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[9].zwzw;
ADD R2.x, R0.z, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[8].z, c[8].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[9].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[9].wzzw;
MUL R1.xyz, R1, c[5].x;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[9].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[9].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].wzzw;
DP3 R4.x, R1, R3;
ADD R1.x, R0.w, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].z;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R1.x, R0, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wwzw;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R1.x, R0.z, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[9].zwww;
MOV R1.x, R0;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[8];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].wzww;
DP3 R4.y, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].zzww;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[10];
MUL R0.x, R0, c[2];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[10].x, R0.w;
MUL R0.x, R0, c[2];
MAD R0.x, R2.w, R0, R0.y;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.x, R0, R0.w;
MAD R1.w, R1, c[4].x, fragment.texcoord[1].y;
MAD R0.x, R0, c[6], R1.w;
ADD R0.x, R0, R0.w;
MOV R1.xyz, fragment.texcoord[3];
DP3 R0.w, fragment.texcoord[2], R1;
MAD R0.x, R0, c[10], -c[10];
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[3], 2D;
MUL R1.xyz, R0, c[0];
MAX R0.x, R0.w, c[8].y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[8].z;
MOV result.color.w, c[8].x;
END
# 557 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 165 math, 20 textures, 10 branches
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 0.50000000, 0
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
mov r0.w, c8.x
mov r1.w, c3.x
mov r3.w, c8.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c1.x
mul r3.w, r3, c2.x
endloop
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c4.x
mov r3.w, c5.x
mov r4.w, c10.z
mov r5.w, c8.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6.z
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c1.x
mul r4.w, r4, c2.x
endloop
add r0.y, v1, r0.w
mov_pp r1.xyz, v3
mul r0.x, r5.w, r1.w
mad r0.x, r0, c6, r0.y
add r0.x, r0, r1.w
dp3_pp r0.w, v2, r1
mov r0.y, c8.x
mad r0.x, r0, c10.z, -c10.z
texld r0.xyz, r0, s3
mul_pp r1.xyz, r0, c0
max_pp r0.x, r0.w, c8
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c8.z
mov_pp oC0.w, c8.y
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 575 math, 67 textures
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
SetTexture 5 [_LightTextureB0] 2D 5
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..7],
		{ 1, 0, 0.5, 2 },
		{ 3, 0.00390625, 256, -1 },
		{ 0, -1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[1].x;
MUL R3.w, R1, c[3].x;
MUL R2.w, R3, c[1].x;
MOV R0.xz, c[7].x;
MOV R0.y, c[8];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[9].y;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].z;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[9].y;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[9].y;
MOV R4.y, c[8];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
ADD R4.xyz, R2, c[10].xyyw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].w;
ADD R3.x, R0.w, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[10].yxyw;
ADD R3.x, R0.z, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[10].xxyw;
ADD R3.x, R0, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.z, R3, R4;
MUL R3.xyz, -R2, c[8].w;
ADD R4.xyz, R3, c[9].x;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
ADD R5.y, R5, -R5.z;
MAD R5.w, R3.x, R5.y, R5.z;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[10].xyxw;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].yyxw;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[10].yxxw;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].w, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].y;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].z;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].y;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[10].xyyw;
ADD R3.x, R0.y, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].w;
ADD R3.x, R0.w, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[10].yxyw;
ADD R3.x, R0.z, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[10].xxyw;
ADD R3.x, R0, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.z, R3, R4;
MUL R3.xyz, -R2, c[8].w;
ADD R4.xyz, R3, c[9].x;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
ADD R5.y, R5, -R5.z;
MAD R5.w, R3.x, R5.y, R5.z;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[10].xyxw;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].yyxw;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[10].yxxw;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[3].x;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].w, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].y;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].z;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].y;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[10].xyyw;
ADD R3.x, R0.y, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].w;
ADD R3.x, R0.w, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[10].yxyw;
ADD R3.x, R0.z, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[10].xxyw;
ADD R3.x, R0, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.w, R3, R4;
MUL R3.xyz, -R2, c[8].w;
ADD R4.xyz, R3, c[9].x;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
ADD R5.z, R5, -R5.w;
MAD R5.w, R3.x, R5.z, R5;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[10].xyxw;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].yyxw;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[10].yxxw;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
MOV R0.y, c[8];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[8].w, -c[8].x;
MUL R2.w, R2, c[1].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[9].y;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[9].z;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[9].y;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[2], R0.w;
MUL R0.w, c[2].x, c[2].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[10].xyyw;
ADD R3.x, R2.y, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[9].w;
ADD R3.x, R2.w, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[10].yxyw;
ADD R3.x, R2.z, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[10].xxyw;
ADD R3.x, R2, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.z, R3, R4;
MUL R3.xyz, -R0, c[8].w;
ADD R4.xyz, R3, c[9].x;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
ADD R5.y, R5, -R5.z;
MAD R5.w, R3.x, R5.y, R5.z;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[10].xyxw;
MOV R4.x, R2.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[10].yyxw;
MOV R4.x, R2.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[8].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[5].x;
MOV R2.y, c[8];
ADD R5.xyz, R0, c[10].yxxw;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[1].x;
MAD R4.xyz, R2, c[8].w, -c[8].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[9].y;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].z;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[9].y;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[10].xyyw;
MUL R0.x, R0.w, c[2];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[9].y;
MOV R5.y, c[8];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[8].w, -c[8].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[9].w;
MAD R1.w, R1, c[4].x, fragment.texcoord[1].y;
ADD R2.x, R0.w, c[9].y;
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].w, -c[8].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[10].yxyw;
ADD R2.x, R0.z, c[9].y;
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].w, -c[8].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[10].xxyw;
ADD R2.x, R0, c[9].y;
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].w, -c[8].x;
DP3 R5.y, R2, R4;
MUL R2.xyz, -R3, c[8].w;
ADD R4.xyz, R2, c[9].x;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
ADD R5.x, R5, -R5.y;
MAD R5.w, R2.x, R5.x, R5.y;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[10].xyxw;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[10].yyxw;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[10].yxxw;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[9].y;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].w, -c[8].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[9].z;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[9].y;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[10].xyyw;
MUL R1.xyz, R1, c[5].x;
ADD R3.x, R0.y, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[9].w;
ADD R3.x, R0.w, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[10].yxyw;
ADD R3.x, R0.z, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[10].xxyw;
ADD R3.x, R0, c[9].y;
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].w, -c[8].x;
DP3 R5.y, R3, R4;
MUL R3.xyz, -R2, c[8].w;
ADD R4.xyz, R3, c[9].x;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
ADD R5.x, R5, -R5.y;
MAD R5.w, R3.x, R5.x, R5.y;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[10].xyxw;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[10].yyxw;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[10].yxxw;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].w, -c[8].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[9].y;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].w, -c[8].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[9].z;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[9].y;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.w, c[9].y;
MOV R3.y, c[8];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[8].w, -c[8].x;
ADD R3.xyz, R2, c[9].w;
DP3 R4.x, R1, R3;
ADD R1.x, R0.y, c[9].y;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
ADD R3.xyz, R2, c[10].xyyw;
MAD R1.xyz, R1, c[8].w, -c[8].x;
DP3 R4.y, R1, R3;
MUL R1.xyz, -R2, c[8].w;
ADD R3.xyz, R1, c[9].x;
MUL R1.xyz, R2, R2;
MUL R3.xyz, R1, R3;
ADD R4.x, R4, -R4.y;
MAD R4.w, R3.x, R4.x, R4.y;
ADD R1.x, R0, c[9].y;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].w, -c[8].x;
ADD R4.xyz, R2, c[10].xxyw;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[10].yxyw;
ADD R1.x, R0.z, c[9].y;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].w, -c[8].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[10].yxxw;
MOV R1.x, R0;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].w, -c[8].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].w, -c[8].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[8];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[8].w, -c[8].x;
ADD R1.xyz, R2, c[10].xyxw;
DP3 R4.y, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].w, -c[8].x;
ADD R1.xyz, R2, c[10].yyxw;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[8].z;
MUL R0.x, R0, c[2];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[8].z, R0.w;
MUL R0.x, R0, c[2];
MAD R0.x, R2.w, R0, R0.y;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.x, R0, R0.w;
MAD R0.x, R0, c[6], R1.w;
ADD R0.x, R0, R0.w;
DP3 R0.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.w;
MUL R1.xyz, R0.w, fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[2], R1;
RCP R0.w, fragment.texcoord[4].w;
MAD R1.zw, fragment.texcoord[4].xyxy, R0.w, c[8].z;
DP3 R1.y, fragment.texcoord[4], fragment.texcoord[4];
TEX R0.w, R1.zwzw, texture[4], 2D;
TEX R1.w, R1.y, texture[5], 2D;
SLT R1.y, c[8], fragment.texcoord[4].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[8].y;
MAD R0.x, R0, c[8].z, -c[8].z;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[3], 2D;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[8].w;
MOV result.color.w, c[8].x;
END
# 575 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 174 math, 22 textures, 10 branches
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
SetTexture 5 [_LightTextureB0] 2D 5
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 0.50000000, 0
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
mov r0.w, c8.x
mov r1.w, c3.x
mov r3.w, c8.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c1.x
mul r3.w, r3, c2.x
endloop
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c4.x
mov r3.w, c5.x
mov r4.w, c10.z
mov r5.w, c8.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6.z
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c1.x
mul r4.w, r4, c2.x
endloop
add r0.y, v1, r0.w
mul r0.x, r5.w, r1.w
mad r0.x, r0, c6, r0.y
add r0.x, r0, r1.w
dp3_pp r0.w, v3, v3
rsq_pp r0.w, r0.w
mad r0.x, r0, c10.z, -c10.z
mov r0.y, c8.x
texld r0.xyz, r0, s3
mul_pp r2.xyz, r0, c0
mul_pp r0.xyz, r0.w, v3
dp3_pp r0.y, v2, r0
rcp r0.w, v4.w
mad r1.xy, v4, r0.w, c10.z
dp3 r0.x, v4, v4
texld r0.x, r0.x, s5
texld r0.w, r1, s4
cmp r0.z, -v4, c8.x, c8.y
mul_pp r0.z, r0, r0.w
mul_pp r0.z, r0, r0.x
max_pp r0.x, r0.y, c8
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c8.z
mov_pp oC0.w, c8.y
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 564 math, 67 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_LightTexture0] CUBE 5
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..7],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[1].x;
MUL R3.w, R1, c[3].x;
MUL R2.w, R3, c[1].x;
MOV R0.xz, c[7].x;
MOV R0.y, c[8];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[9].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[9];
MOV R4.y, c[8];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[3].x;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
MOV R0.y, c[8];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[8].z, -c[8].x;
MUL R2.w, R2, c[1].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[9].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[9].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[9].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[2], R0.w;
MUL R0.w, c[2].x, c[2].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[9].wzzw;
ADD R3.x, R2.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[9].z;
ADD R3.x, R2.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[9].wwzw;
ADD R3.x, R2, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[9].zwzw;
ADD R3.x, R2.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[8].z, c[8].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[9].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[9].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[8].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[5].x;
MOV R2.y, c[8];
ADD R5.xyz, R0, c[9].zwww;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[1].x;
MAD R4.xyz, R2, c[8].z, -c[8].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[9].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[9].wzzw;
MUL R0.x, R0.w, c[2];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[9];
MOV R5.y, c[8];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[9].z;
MAD R1.w, R1, c[4].x, fragment.texcoord[1].y;
ADD R2.x, R0.w, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[9].wwzw;
ADD R2.x, R0, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[9].zwzw;
ADD R2.x, R0.z, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[8].z, c[8].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[9].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[9].wzzw;
MUL R1.xyz, R1, c[5].x;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[9].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[9].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].wzzw;
DP3 R4.x, R1, R3;
ADD R1.x, R0.w, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].z;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R1.x, R0, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wwzw;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R1.x, R0.z, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[9].zwww;
MOV R1.x, R0;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[8];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].wzww;
DP3 R4.y, R0, R1;
MOV R0.x, R0.w;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].zzww;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MAD R0.y, R3.z, R0, R0.z;
MOV R0.x, c[10];
MUL R0.x, R0, c[2];
MUL R0.w, R0.x, R3;
MAD R0.y, R0, c[10].x, R0.w;
MUL R0.x, R0, c[2];
MAD R0.x, R2.w, R0, R0.y;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.x, R0, R0.w;
MAD R0.x, R0, c[6], R1.w;
ADD R0.x, R0, R0.w;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
RSQ R0.w, R0.z;
MUL R1.xyz, R0.w, fragment.texcoord[3];
DP3 R1.x, fragment.texcoord[2], R1;
DP3 R1.y, fragment.texcoord[4], fragment.texcoord[4];
TEX R0.w, fragment.texcoord[4], texture[5], CUBE;
TEX R1.w, R1.y, texture[4], 2D;
MUL R1.y, R1.w, R0.w;
MAX R0.w, R1.x, c[8].y;
MAD R0.x, R0, c[10], -c[10];
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[3], 2D;
MUL R0.xyz, R0, c[0];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[8].z;
MOV result.color.w, c[8].x;
END
# 564 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 170 math, 22 textures, 10 branches
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
SetTexture 5 [_LightTexture0] CUBE 5
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 0.50000000, 0
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
mov r0.w, c8.x
mov r1.w, c3.x
mov r3.w, c8.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c1.x
mul r3.w, r3, c2.x
endloop
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c4.x
mov r3.w, c5.x
mov r4.w, c10.z
mov r5.w, c8.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6.z
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c1.x
mul r4.w, r4, c2.x
endloop
add r0.y, v1, r0.w
dp3_pp r0.z, v3, v3
rsq_pp r0.w, r0.z
mul_pp r2.xyz, r0.w, v3
mul r0.x, r5.w, r1.w
mad r0.x, r0, c6, r0.y
add r0.x, r0, r1.w
mad r0.x, r0, c10.z, -c10.z
mov r0.y, c8.x
texld r0.xyz, r0, s3
mul_pp r1.xyz, r0, c0
dp3_pp r0.y, v2, r2
dp3 r0.x, v4, v4
max_pp r0.y, r0, c8.x
texld r0.w, v4, s5
texld r0.x, r0.x, s4
mul r0.x, r0, r0.w
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c8.z
mov_pp oC0.w, c8.y
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "opengl " {
// Stats: 559 math, 66 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
"3.0-!!ARBfp1.0
PARAM c[11] = { program.local[0..7],
		{ 1, 0, 2, 3 },
		{ 0.00390625, 256, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.w, c[1].x;
MUL R3.w, R1, c[3].x;
MUL R2.w, R3, c[1].x;
MOV R0.xz, c[7].x;
MOV R0.y, c[8];
ADD R1.xyz, fragment.texcoord[1], R0;
MUL R2.xyz, R1, R2.w;
FLR R3.xyz, R2;
MUL R0.xyz, R3, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R3, -R0, R0;
MUL R4.xyz, R0, c[9].x;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R2, -R3;
ADD R4.x, R0.y, c[9];
MOV R4.y, c[8];
TEX R3.xyz, R4, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
ADD R4.xyz, R2, c[9].wzzw;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, R3.w;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R3.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R4, R5;
MAD R4.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.w, R4, R5;
MUL R4.xyz, R1, c[3].x;
FLR R5.xyz, R4;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
MUL R6.xyz, R5, c[9].x;
ADD R2.y, R5.w, -R2.x;
MAD R2.x, R3, R2.y, R2;
ABS R0.xyz, R6;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3.y, R2.y, R2;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R2.xyz, R0, c[9].x;
ADD R3.y, R0.w, -R3.x;
TEX R0, R2, texture[0], 2D;
MAD R2.x, R3.z, R3.y, R3;
ADD R0, R0, R2.z;
ABS R4.w, R2.x;
ADD R2.xyz, R4, -R5;
ADD R4.xyz, R2, c[9].wzzw;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.z, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.w, R3.x, -R5.z;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5, R5.z;
MAD R4.x, R3, R5.y, R5;
ADD R6.x, R4, -R5.w;
ADD R5.xyz, R2, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R4.x, R0.w, -R0.y;
MAD R0.w, R3.y, R6.x, R5;
MAD R5.w, R3.x, R4.x, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
MOV R0.y, c[8];
DP3 R5.x, R4, R5;
TEX R0.xyz, R0, texture[1], 2D;
MAD R4.xyz, R0, c[8].z, -c[8].x;
MUL R2.w, R2, c[1].x;
MUL R0.xyz, R1, R2.w;
DP3 R2.w, R2, R4;
FLR R4.xyz, R0;
ADD R5.x, R5, -R2.w;
MAD R2.w, R3.x, R5.x, R2;
ADD R3.x, R5.w, -R2.w;
MAD R2.w, R3.y, R3.x, R2;
ADD R0.w, R0, -R2;
MAD R0.w, R3.z, R0, R2;
MUL R2.xyz, R4, c[9].x;
ABS R2.xyz, R2;
FRC R2.xyz, R2;
MUL R2.xyz, R2, c[9].y;
CMP R2.xyz, R4, -R2, R2;
ADD R0.xyz, R0, -R4;
MUL R3.xyz, R2, c[9].x;
TEX R2, R3, texture[0], 2D;
ABS R0.w, R0;
MAD R3.x, R4.w, c[2], R0.w;
MUL R0.w, c[2].x, c[2].x;
ADD R2, R2, R3.z;
MAD R3.w, R0, R3, R3.x;
ADD R4.xyz, R0, c[9].wzzw;
ADD R3.x, R2.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R4.w, R3, R4;
ADD R4.xyz, R0, c[9].z;
ADD R3.x, R2.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.x, R3, -R4.w;
ADD R4.xyz, R0, c[9].wwzw;
ADD R3.x, R2, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.y, R3, R4;
ADD R4.xyz, R0, c[9].zwzw;
ADD R3.x, R2.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.z, R3.x, -R5.y;
MAD R4.xyz, -R0, c[8].z, c[8].w;
MUL R3.xyz, R0, R0;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.z, R5.y;
MAD R4.x, R3, R5, R4.w;
ADD R4.w, R4.x, -R5;
MAD R4.w, R3.y, R4, R5;
ADD R5.xyz, R0, c[9].wzww;
MOV R4.x, R2.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.y, R4, R5;
ADD R5.xyz, R0, c[9].zzww;
MOV R4.x, R2.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R2.w, R4, R5;
ADD R2.w, R2, -R2.y;
MAD R5.w, R3.x, R2, R2.y;
MOV R2.w, c[8].y;
TEX R4.xyz, R2.zwzw, texture[1], 2D;
MUL R2.w, R1, c[5].x;
MOV R2.y, c[8];
ADD R5.xyz, R0, c[9].zwww;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R5.x, R4, R5;
TEX R2.xyz, R2, texture[1], 2D;
MUL R1.w, R2, c[1].x;
MAD R4.xyz, R2, c[8].z, -c[8].x;
MUL R2.xyz, R1, R1.w;
DP3 R1.w, R0, R4;
FLR R4.xyz, R2;
ADD R5.x, R5, -R1.w;
MAD R1.w, R3.x, R5.x, R1;
ADD R3.x, R5.w, -R1.w;
MAD R1.w, R3.y, R3.x, R1;
ADD R3.x, R4.w, -R1.w;
MAD R1.w, R3.z, R3.x, R1;
MUL R0.xyz, R4, c[9].x;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
ADD R3.xyz, R2, -R4;
MUL R0.xyz, R0, c[9].x;
TEX R5, R0, texture[0], 2D;
ADD R4.xyz, R3, c[9].wzzw;
MUL R0.x, R0.w, c[2];
ABS R1.w, R1;
MAD R1.w, R1, R0.x, R3;
ADD R0, R5, R0.z;
ADD R5.x, R0.y, c[9];
MOV R5.y, c[8];
TEX R2.xyz, R5, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R3.w, R2, R4;
ADD R4.xyz, R3, c[9].z;
ADD R2.x, R0.w, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R4.w, R2.x, -R3;
ADD R4.xyz, R3, c[9].wwzw;
ADD R2.x, R0, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R5.x, R2, R4;
ADD R4.xyz, R3, c[9].zwzw;
ADD R2.x, R0.z, c[9];
MOV R2.y, c[8];
TEX R2.xyz, R2, texture[1], 2D;
MAD R2.xyz, R2, c[8].z, -c[8].x;
DP3 R2.x, R2, R4;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R3, c[8].z, c[8].w;
MUL R2.xyz, R3, R3;
MUL R2.xyz, R2, R4;
MAD R5.w, R2.x, R5.y, R5.x;
MAD R3.w, R2.x, R4, R3;
ADD R3.w, R3, -R5;
MAD R3.w, R2.y, R3, R5;
ADD R5.xyz, R3, c[9].wzww;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R3, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R2.x, R0, R0.y;
ADD R5.xyz, R3, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
MUL R4.xyz, R1, R2.w;
FLR R5.xyz, R4;
MUL R6.xyz, R5, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.w, R3, R0;
ADD R3.x, R4.w, -R2.w;
MAD R2.x, R2, R3, R2.w;
ADD R0.w, R0, -R2.x;
MAD R2.x, R2.y, R0.w, R2;
ADD R2.y, R3.w, -R2.x;
MAD R2.w, R2.z, R2.y, R2.x;
ADD R2.xyz, R4, -R5;
ABS R6.xyz, R6;
FRC R0.xyz, R6;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R5, -R0, R0;
MUL R3.xyz, R0, c[9].x;
TEX R0, R3, texture[0], 2D;
ADD R0, R0, R3.z;
ADD R4.xyz, R2, c[9].wzzw;
MUL R1.xyz, R1, c[5].x;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.w, R3, R4;
ADD R4.xyz, R2, c[9].z;
ADD R3.x, R0.w, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R4.w, R3.x, -R3;
ADD R4.xyz, R2, c[9].wwzw;
ADD R3.x, R0, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R5.x, R3, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R3.x, R0.z, c[9];
MOV R3.y, c[8];
TEX R3.xyz, R3, texture[1], 2D;
MAD R3.xyz, R3, c[8].z, -c[8].x;
DP3 R3.x, R3, R4;
ADD R5.y, R3.x, -R5.x;
MAD R4.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R2, R2;
MUL R3.xyz, R3, R4;
MAD R5.w, R3.x, R5.y, R5.x;
MAD R3.w, R3.x, R4, R3;
ADD R3.w, R3, -R5;
ADD R5.xyz, R2, c[9].wzww;
MAD R3.w, R3.y, R3, R5;
MOV R4.x, R0.y;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.y, R4, R5;
ADD R5.xyz, R2, c[9].zzww;
MOV R4.x, R0.w;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R0.w, R4, R5;
ADD R0.w, R0, -R0.y;
MAD R0.w, R3.x, R0, R0.y;
ADD R5.xyz, R2, c[9].zwww;
MOV R4.x, R0.z;
MOV R4.y, c[8];
TEX R4.xyz, R4, texture[1], 2D;
MAD R4.xyz, R4, c[8].z, -c[8].x;
DP3 R4.w, R4, R5;
FLR R4.xyz, R1;
MUL R5.xyz, R4, c[9].x;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R2.x, R2, R0;
ABS R5.xyz, R5;
FRC R0.xyz, R5;
ADD R2.y, R4.w, -R2.x;
MAD R3.x, R3, R2.y, R2;
ADD R0.w, R0, -R3.x;
MAD R3.x, R3.y, R0.w, R3;
MUL R0.xyz, R0, c[9].y;
CMP R0.xyz, R4, -R0, R0;
MUL R2.xyz, R0, c[9].x;
TEX R0, R2, texture[0], 2D;
ADD R2.x, R3.w, -R3;
ADD R0, R0, R2.z;
MAD R3.w, R3.z, R2.x, R3.x;
ADD R2.xyz, R1, -R4;
ADD R3.x, R0.y, c[9];
MOV R3.y, c[8];
TEX R1.xyz, R3, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
ADD R3.xyz, R2, c[9].wzzw;
DP3 R4.x, R1, R3;
ADD R3.xyz, R2, c[9].z;
ADD R1.x, R0.w, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R1.x, R1, R3;
ADD R4.y, R1.x, -R4.x;
MUL R1.xyz, R2, R2;
MAD R3.xyz, -R2, c[8].z, c[8].w;
MUL R3.xyz, R1, R3;
MAD R4.w, R3.x, R4.y, R4.x;
ADD R4.xyz, R2, c[9].wwzw;
ADD R1.x, R0, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R5.x, R1, R4;
ADD R4.xyz, R2, c[9].zwzw;
ADD R1.x, R0.z, c[9];
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R1.x, R1, R4;
ADD R4.x, R1, -R5;
MAD R5.x, R3, R4, R5;
ADD R4.xyz, R2, c[9].zwww;
MOV R1.x, R0;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R5.y, R2, R1;
MOV R1.x, R0.z;
MOV R1.y, c[8];
TEX R1.xyz, R1, texture[1], 2D;
MAD R1.xyz, R1, c[8].z, -c[8].x;
DP3 R0.x, R1, R4;
MOV R1.x, R0.y;
ADD R4.x, R0, -R5.y;
MOV R1.y, c[8];
TEX R0.xyz, R1, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
ADD R1.xyz, R2, c[9].wzww;
DP3 R4.y, R0, R1;
ADD R1.xyz, R2, c[9].zzww;
MOV R0.x, R0.w;
MOV R0.y, c[8];
TEX R0.xyz, R0, texture[1], 2D;
MAD R0.xyz, R0, c[8].z, -c[8].x;
DP3 R0.x, R0, R1;
ADD R4.w, R4, -R5.x;
ADD R0.x, R0, -R4.y;
MAD R0.z, R3.x, R4.x, R5.y;
MAD R0.x, R3, R0, R4.y;
ADD R0.x, R0, -R0.z;
MAD R0.z, R3.y, R0.x, R0;
MAD R0.y, R3, R4.w, R5.x;
ADD R0.y, R0, -R0.z;
MOV R0.x, c[10];
MUL R0.x, R0, c[2];
MUL R0.w, R0.x, R3;
MAD R0.y, R3.z, R0, R0.z;
MAD R0.y, R0, c[10].x, R0.w;
MUL R0.x, R0, c[2];
MAD R0.x, R2.w, R0, R0.y;
TEX R0.w, fragment.texcoord[0], texture[2], 2D;
MUL R0.x, R0, R0.w;
MAD R1.w, R1, c[4].x, fragment.texcoord[1].y;
MAD R0.x, R0, c[6], R1.w;
ADD R0.x, R0, R0.w;
MOV R0.y, c[8];
MAD R0.x, R0, c[10], -c[10];
TEX R0.xyz, R0, texture[3], 2D;
MUL R2.xyz, R0, c[0];
MOV R1.xyz, fragment.texcoord[3];
DP3 R0.x, fragment.texcoord[2], R1;
TEX R0.w, fragment.texcoord[4], texture[4], 2D;
MAX R0.x, R0, c[8].y;
MUL R0.x, R0, R0.w;
MUL R0.xyz, R0.x, R2;
MUL result.color.xyz, R0, c[8].z;
MOV result.color.w, c[8].x;
END
# 559 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 166 math, 21 textures, 10 branches
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_Lacunarity]
Float 2 [_Gain]
Float 3 [_MainFrequency]
Float 4 [_Distortion]
Float 5 [_StormFrequency]
Float 6 [_StormDistortion]
Float 7 [_Evolution]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 4, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 0.50000000, 0
defi i1, 3, 0, 1, 0
dcl_texcoord0 v0.xy
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xy
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
mov r0.w, c8.x
mov r1.w, c3.x
mov r3.w, c8.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.x
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
abs r0.x, r0
mad r0.w, r0.x, r3, r0
mul r1.w, r1, c1.x
mul r3.w, r3, c2.x
endloop
mov r0.xz, c7.x
mov r0.y, c8.x
add r1.xyz, v1, r0
texld r1.w, v0, s2
mul r0.w, r0, c4.x
mov r3.w, c5.x
mov r4.w, c10.z
mov r5.w, c8.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c9.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c9.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c9.z, c9.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c8.z, c8.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c10.yyxw
add r4.x, r2, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c10.xyxw
add r4.x, r2.z, c9
mov r4.y, c8.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c9
add r5.x, r2, -r6.z
mov r4.y, c8.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r4.x, r2, r4
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
add r3.xyz, r3, c10.x
dp3 r2.x, r2, r3
mad r2.y, r0.x, r5.x, r6.z
add r2.x, r2, -r4
mad r0.x, r0, r2, r4
add r0.x, r0, -r2.y
mad r2.x, r0.y, r6.y, r6
mad r0.x, r0.y, r0, r2.y
add r0.x, r0, -r2
mad r0.x, r0.z, r0, r2
mad r5.w, r0.x, r4, r5
mul r3.w, r3, c1.x
mul r4.w, r4, c2.x
endloop
add r0.y, v1, r0.w
mul r0.x, r5.w, r1.w
mad r0.x, r0, c6, r0.y
add r0.x, r0, r1.w
mov r0.y, c8.x
mad r0.x, r0, c10.z, -c10.z
texld r0.xyz, r0, s3
mul_pp r2.xyz, r0, c0
mov_pp r1.xyz, v3
dp3_pp r0.x, v2, r1
texld r0.w, v4, s4
max_pp r0.x, r0, c8
mul_pp r0.x, r0, r0.w
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c8.z
mov_pp oC0.w, c8.y
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
}
 }
}
Fallback "Diffuse"
}