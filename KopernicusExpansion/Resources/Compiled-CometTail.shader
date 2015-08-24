// Compiled shader for all platforms, uncompressed size: 284.7KB

Shader "CometTail" {
Properties {
 _TintColor ("Color", Color) = (0.5,0.5,0.5,1)
 _Evolution ("Time", Float) = 0
 _RimPower ("Rim Power", Range(0,4)) = 0.01
 _Distortion ("Distortion", Range(0,0.5)) = 0.2
 _ZDistortion ("Z Distortion", Range(0,1)) = 0.1
 _AlphaDistortion ("Alpha Distortion", Range(0,1)) = 0.2
 _VertexDistortion ("Vertex Distortion", Float) = 0.2
 _Frequency ("Frequency", Float) = 1
 _Lacunarity ("Lacunarity", Float) = 1.3
 _Gain ("Gain", Float) = 0.9
 _PermTable2D ("2D Perm Table", 2D) = "white" {}
 _Gradient3D ("3D Gradient", 2D) = "white" {}
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //        d3d9 : 35 avg math (14..60)
 //      opengl : 35 avg math (14..60)
 // Stats for Fragment shader:
 //        d3d9 : 96 avg math (95..97), 9 avg texture (9..10), 5 branch
 //      opengl : 443 avg math (442..445), 45 avg texture (45..46)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
// Platform d3d11 had shader errors
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
SubProgram "opengl " {
// Stats: 31 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[18] = { { 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[16];
ADD R2.xyz, R2, R3;
ADD result.texcoord[3].xyz, R2, R1;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
ADD result.texcoord[0].xyz, -R1, c[9];
MOV result.texcoord[1].xyz, vertex.position;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 31 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c16.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c17.x
dp4 r2.z, r0, c11
dp4 r2.y, r0, c10
dp4 r2.x, r0, c9
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c14
dp4 r3.y, r1, c13
dp4 r3.x, r1, c12
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c15
add r2.xyz, r2, r3
add o4.xyz, r2, r1
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
add o1.xyz, -r1, c8
mov o2.xyz, v0
mov o3.z, r2.w
mov o3.y, r3.w
mov o3.x, r0
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1 = tmpvar_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1 = tmpvar_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1 = tmpvar_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 14 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [unity_Scale]
Vector 11 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD result.texcoord[0].xyz, -R0, c[9];
MUL R0.xyz, vertex.normal, c[10].w;
MOV result.texcoord[1].xyz, vertex.position;
DP3 result.texcoord[2].z, R0, c[7];
DP3 result.texcoord[2].y, R0, c[6];
DP3 result.texcoord[2].x, R0, c[5];
MAD result.texcoord[3].xy, vertex.texcoord[1], c[11], c[11].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [unity_Scale]
Vector 10 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add o1.xyz, -r0, c8
mul r0.xyz, v1, c9.w
mov o2.xyz, v0
dp3 o3.z, r0, c6
dp3 o3.y, r0, c5
dp3 o3.x, r0, c4
mad o4.xy, v2, c10, c10.zwzw
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D unity_Lightmap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  c_1.xyz = (tmpvar_3 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D unity_Lightmap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  lowp vec4 tmpvar_57;
  tmpvar_57 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  c_1.xyz = (tmpvar_3 * ((8.0 * tmpvar_57.w) * tmpvar_57.xyz));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_LightmapST;
out highp vec3 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform sampler2D unity_Lightmap;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  c_1.xyz = (tmpvar_3 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 60 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[26] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[25].w;
DP3 R5.x, R3, c[5];
DP4 R4.zw, vertex.position, c[6];
ADD R2, -R4.z, c[11];
DP3 R4.z, R3, c[6];
DP3 R3.z, R3, c[7];
DP4 R3.w, vertex.position, c[5];
MUL R0, R4.z, R2;
ADD R1, -R3.w, c[10];
DP4 R4.xy, vertex.position, c[7];
MUL R2, R2, R2;
MOV R5.y, R4.z;
MOV R5.z, R3;
MOV R5.w, c[0].x;
MAD R0, R5.x, R1, R0;
MAD R2, R1, R1, R2;
ADD R1, -R4.x, c[12];
MAD R2, R1, R1, R2;
MAD R0, R3.z, R1, R0;
MUL R1, R2, c[13];
ADD R1, R1, c[0].x;
RSQ R2.x, R2.x;
RSQ R2.y, R2.y;
RSQ R2.z, R2.z;
RSQ R2.w, R2.w;
MUL R0, R0, R2;
DP4 R2.z, R5, c[20];
DP4 R2.y, R5, c[19];
DP4 R2.x, R5, c[18];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[15];
MAD R1.xyz, R0.x, c[14], R1;
MAD R0.xyz, R0.z, c[16], R1;
MAD R1.xyz, R0.w, c[17], R0;
MUL R0, R5.xyzz, R5.yzzx;
MUL R1.w, R4.z, R4.z;
DP4 R5.w, R0, c[23];
DP4 R5.z, R0, c[22];
DP4 R5.y, R0, c[21];
MAD R1.w, R5.x, R5.x, -R1;
MUL R0.xyz, R1.w, c[24];
ADD R2.xyz, R2, R5.yzww;
ADD R0.xyz, R2, R0;
MOV R3.x, R4.w;
MOV R3.y, R4;
ADD result.texcoord[3].xyz, R0, R1;
ADD result.texcoord[0].xyz, -R3.wxyw, c[9];
MOV result.texcoord[1].xyz, vertex.position;
MOV result.texcoord[2].z, R3;
MOV result.texcoord[2].y, R4.z;
MOV result.texcoord[2].x, R5;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 60 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 60 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c25, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r3.xyz, v1, c24.w
dp3 r5.x, r3, c4
dp4 r4.zw, v0, c5
add r2, -r4.z, c10
dp3 r4.z, r3, c5
dp3 r3.z, r3, c6
dp4 r3.w, v0, c4
mul r0, r4.z, r2
add r1, -r3.w, c9
dp4 r4.xy, v0, c6
mul r2, r2, r2
mov r5.y, r4.z
mov r5.z, r3
mov r5.w, c25.x
mad r0, r5.x, r1, r0
mad r2, r1, r1, r2
add r1, -r4.x, c11
mad r2, r1, r1, r2
mad r0, r3.z, r1, r0
mul r1, r2, c12
add r1, r1, c25.x
rsq r2.x, r2.x
rsq r2.y, r2.y
rsq r2.z, r2.z
rsq r2.w, r2.w
mul r0, r0, r2
dp4 r2.z, r5, c19
dp4 r2.y, r5, c18
dp4 r2.x, r5, c17
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c25.y
mul r0, r0, r1
mul r1.xyz, r0.y, c14
mad r1.xyz, r0.x, c13, r1
mad r0.xyz, r0.z, c15, r1
mad r1.xyz, r0.w, c16, r0
mul r0, r5.xyzz, r5.yzzx
mul r1.w, r4.z, r4.z
dp4 r5.w, r0, c22
dp4 r5.z, r0, c21
dp4 r5.y, r0, c20
mad r1.w, r5.x, r5.x, -r1
mul r0.xyz, r1.w, c23
add r2.xyz, r2, r5.yzww
add r0.xyz, r2, r0
mov r3.x, r4.w
mov r3.y, r4
add o4.xyz, r0, r1
add o1.xyz, -r3.wxyw, c8
mov o2.xyz, v0
mov o3.z, r3
mov o3.y, r4.z
mov o3.x, r5
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1 = tmpvar_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1 = tmpvar_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
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
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1 = tmpvar_57;
  c_1.xyz = (c_1.xyz + (tmpvar_3 * xlv_TEXCOORD3));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
// Stats: 442 math, 45 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
MAD R4.w, R5.z, R4, R5.x;
MUL R2.w, R2, c[8].x;
ADD R2.xyz, R1, c[10].wzzw;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R3.w, R2, R4, R3;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R2.y, R1.x, R5, R2;
MAD R4.x, R1, R5, R4.w;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.x, R1.z, R0, R0.z;
MAD R0.w, R2.z, R2.x, R1;
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MUL R0.y, R0, c[8].x;
MAD R0.w, R0.x, R0.y, R0;
DP3 R0.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R0.x, R0.x;
MUL R0.xyz, R0.x, fragment.texcoord[0];
ADD R2.xyz, R0.w, -c[0];
MOV R1, c[0];
MAD R1.xyz, R2, c[3].x, R1;
DP3_SAT R2.x, R0, -fragment.texcoord[2];
DP3_SAT R0.x, R0, fragment.texcoord[2];
MAX R0.y, R0.x, R2.x;
ADD R0.x, R0.w, -c[0].w;
POW R0.y, R0.y, c[2].x;
MAD R0.x, R0, c[5], R1.w;
MUL result.color.w, R0.x, R0.y;
MAD result.color.xyz, R1, fragment.texcoord[3], R1;
END
# 442 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 95 math, 9 textures, 5 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r1.x, r0, r0.w
pow_pp r0, r1.x, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mad_pp r1.xyz, r2, c3.x, r1
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mad_pp oC0.xyz, r1, v3, r1
mul_pp oC0.w, r0.x, r0.z
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
// Stats: 445 math, 46 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
MUL R2.w, R2, c[8].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MAD R4.w, R5.z, R4, R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
ADD R2.xyz, R1, c[10].wzzw;
MAD R3.w, R2, R4, R3;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R2.y, R1.x, R5, R2;
MAD R4.x, R1, R5, R4.w;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.w, R2.z, R2.x, R1;
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MOV R2, c[0];
MAD R0.x, R1.z, R0, R0.z;
MUL R0.y, R0, c[8].x;
MAD R1.w, R0.x, R0.y, R0;
ADD R0.xyz, R1.w, -c[0];
MAD R1.xyz, R0, c[3].x, R2;
TEX R0, fragment.texcoord[3], texture[2], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
DP3 R2.x, fragment.texcoord[0], fragment.texcoord[0];
RSQ R2.x, R2.x;
MUL R2.xyz, R2.x, fragment.texcoord[0];
DP3_SAT R0.w, R2, fragment.texcoord[2];
DP3_SAT R1.x, R2, -fragment.texcoord[2];
MAX R1.x, R0.w, R1;
ADD R0.w, R1, -c[0];
POW R1.x, R1.x, c[2].x;
MAD R0.w, R0, c[5].x, R2;
MUL result.color.w, R0, R1.x;
MUL result.color.xyz, R0, c[11].y;
END
# 445 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 97 math, 10 textures, 5 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [unity_Lightmap] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 8.00000000, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r2.w, r0.x, r0
pow_pp r0, r2.w, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mad_pp r2.xyz, r2, c3.x, r1
texld r1, v3, s2
mul_pp r1.xyz, r1.w, r1
mul_pp r1.xyz, r1, r2
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mul_pp oC0.xyz, r1, c11.z
mul_pp oC0.w, r0.x, r0.z
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
}
 }


 // Stats for Vertex shader:
 //        d3d9 : 17 avg math (14..19)
 //      opengl : 17 avg math (14..19)
 // Stats for Fragment shader:
 //        d3d9 : 94 math, 9 texture, 5 branch
 //      opengl : 441 math, 45 texture
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
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
// Stats: 18 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[15].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
ADD result.texcoord[0].xyz, -R0, c[13];
MOV result.texcoord[1].xyz, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 18 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c14.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
add o1.xyz, -r0, c12
mov o2.xyz, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
add o4.xyz, -r0, c13
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 14 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[12] = { program.local[0],
		state.matrix.mvp,
		program.local[5..11] };
TEMP R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
ADD result.texcoord[0].xyz, -R0, c[9];
MUL R0.xyz, vertex.normal, c[11].w;
MOV result.texcoord[1].xyz, vertex.position;
DP3 result.texcoord[2].z, R0, c[7];
DP3 result.texcoord[2].y, R0, c[6];
DP3 result.texcoord[2].x, R0, c[5];
MOV result.texcoord[3].xyz, c[10];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceCameraPos]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
add o1.xyz, -r0, c8
mul r0.xyz, v1, c10.w
mov o2.xyz, v0
dp3 o3.z, r0, c6
dp3 o3.y, r0, c5
dp3 o3.x, r0, c4
mov o4.xyz, c9
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 19 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[15].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].w, R0, c[12];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
ADD result.texcoord[0].xyz, -R0, c[13];
MOV result.texcoord[1].xyz, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[14];
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
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c14.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o5.w, r0, c11
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
add o1.xyz, -r0, c12
mov o2.xyz, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
add o4.xyz, -r0, c13
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 18 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[15].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
ADD result.texcoord[0].xyz, -R0, c[13];
MOV result.texcoord[1].xyz, vertex.position;
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 18 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c14.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o5.z, r0, c10
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
add o1.xyz, -r0, c12
mov o2.xyz, v0
dp3 o3.z, r1, c6
dp3 o3.y, r1, c5
dp3 o3.x, r1, c4
add o4.xyz, -r0, c13
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 17 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[16] = { program.local[0],
		state.matrix.mvp,
		program.local[5..15] };
TEMP R0;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
ADD result.texcoord[0].xyz, -R0, c[13];
MUL R0.xyz, vertex.normal, c[15].w;
MOV result.texcoord[1].xyz, vertex.position;
DP3 result.texcoord[2].z, R0, c[7];
DP3 result.texcoord[2].y, R0, c[6];
DP3 result.texcoord[2].x, R0, c[5];
MOV result.texcoord[3].xyz, c[14];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceCameraPos]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
dcl_position0 v0
dcl_normal0 v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 o5.y, r0, c9
dp4 o5.x, r0, c8
add o1.xyz, -r0, c12
mul r0.xyz, v1, c14.w
mov o2.xyz, v0
dp3 o3.z, r0, c6
dp3 o3.y, r0, c5
dp3 o3.x, r0, c4
mov o4.xyz, c13
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture2D (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
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
  xlv_TEXCOORD0 = (_WorldSpaceCameraPos - (_Object2World * _glesVertex).xyz);
  xlv_TEXCOORD1 = _glesVertex.xyz;
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform lowp vec4 _TintColor;
uniform highp float _Evolution;
uniform mediump float _RimPower;
uniform mediump float _Distortion;
uniform mediump float _ZDistortion;
uniform mediump float _AlphaDistortion;
uniform highp float _Frequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
in highp vec3 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = xlv_TEXCOORD1.xy;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_4 = 0.0;
  mediump float rim2_5;
  mediump float rim1_6;
  mediump vec3 color_7;
  tmpvar_2.z = (xlv_TEXCOORD1.z * _ZDistortion);
  highp vec3 tmpvar_8;
  tmpvar_8.xy = vec2(0.0, 0.0);
  tmpvar_8.z = _Evolution;
  highp vec3 p_9;
  p_9 = (tmpvar_2 + tmpvar_8);
  int i_10;
  highp float sum_11;
  highp float amp_12;
  highp float freq_13;
  freq_13 = _Frequency;
  amp_12 = 0.5;
  sum_11 = 0.0;
  i_10 = 0;
  for (int i_10 = 0; i_10 < 5; ) {
    highp vec3 p_14;
    p_14 = (p_9 * freq_13);
    highp vec3 tmpvar_15;
    tmpvar_15 = (floor(p_14) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_16;
    tmpvar_16 = (fract(abs(tmpvar_15)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_17;
    if ((tmpvar_15.x >= 0.0)) {
      tmpvar_17 = tmpvar_16.x;
    } else {
      tmpvar_17 = -(tmpvar_16.x);
    };
    highp float tmpvar_18;
    if ((tmpvar_15.y >= 0.0)) {
      tmpvar_18 = tmpvar_16.y;
    } else {
      tmpvar_18 = -(tmpvar_16.y);
    };
    highp float tmpvar_19;
    if ((tmpvar_15.z >= 0.0)) {
      tmpvar_19 = tmpvar_16.z;
    } else {
      tmpvar_19 = -(tmpvar_16.z);
    };
    highp vec3 tmpvar_20;
    tmpvar_20.x = tmpvar_17;
    tmpvar_20.y = tmpvar_18;
    tmpvar_20.z = tmpvar_19;
    highp vec3 tmpvar_21;
    tmpvar_21 = (p_14 - floor(p_14));
    p_14 = tmpvar_21;
    highp vec3 tmpvar_22;
    tmpvar_22 = ((tmpvar_21 * tmpvar_21) * (3.0 - (2.0 * tmpvar_21)));
    highp vec3 tmpvar_23;
    tmpvar_23 = (tmpvar_20 / 256.0);
    highp vec4 tmpvar_24;
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture (_PermTable2D, tmpvar_23.xy);
    tmpvar_24 = tmpvar_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_24 + tmpvar_23.z);
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_26.x;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_26.z;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_26.y;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = tmpvar_26.w;
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_26.x + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_26.z + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_26.y + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    highp vec3 g_48;
    highp vec2 tmpvar_49;
    tmpvar_49.y = 0.0;
    tmpvar_49.x = (tmpvar_26.w + 0.00390625);
    lowp vec3 tmpvar_50;
    tmpvar_50 = ((texture (_Gradient3D, tmpvar_49).xyz * 2.0) - 1.0);
    g_48 = tmpvar_50;
    sum_11 = (sum_11 + (mix (mix (mix (dot (g_27, tmpvar_21), dot (g_30, (tmpvar_21 + vec3(-1.0, 0.0, 0.0))), tmpvar_22.x), mix (dot (g_33, (tmpvar_21 + vec3(0.0, -1.0, 0.0))), dot (g_36, (tmpvar_21 + vec3(-1.0, -1.0, 0.0))), tmpvar_22.x), tmpvar_22.y), mix (mix (dot (g_39, (tmpvar_21 + vec3(0.0, 0.0, -1.0))), dot (g_42, (tmpvar_21 + vec3(-1.0, 0.0, -1.0))), tmpvar_22.x), mix (dot (g_45, (tmpvar_21 + vec3(0.0, -1.0, -1.0))), dot (g_48, (tmpvar_21 + vec3(-1.0, -1.0, -1.0))), tmpvar_22.x), tmpvar_22.y), tmpvar_22.z) * amp_12));
    freq_13 = (freq_13 * _Lacunarity);
    amp_12 = (amp_12 * _Gain);
    i_10 = (i_10 + 1);
  };
  highp vec3 tmpvar_51;
  tmpvar_51 = mix (_TintColor.xyz, vec3(sum_11), vec3(_Distortion));
  color_7 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (normalize(xlv_TEXCOORD0), xlv_TEXCOORD2), 0.0, 1.0);
  rim1_6 = tmpvar_52;
  lowp vec3 arg1_53;
  arg1_53 = -(xlv_TEXCOORD2);
  highp float tmpvar_54;
  tmpvar_54 = clamp (dot (normalize(xlv_TEXCOORD0), arg1_53), 0.0, 1.0);
  rim2_5 = tmpvar_54;
  tmpvar_3 = color_7;
  mediump float tmpvar_55;
  tmpvar_55 = pow (max (rim1_6, rim2_5), _RimPower);
  highp float tmpvar_56;
  tmpvar_56 = (mix (_TintColor.w, sum_11, _AlphaDistortion) * tmpvar_55);
  tmpvar_4 = tmpvar_56;
  mediump vec4 tmpvar_57;
  lowp vec4 tmpvar_58;
  tmpvar_58.xyz = tmpvar_3;
  tmpvar_58.w = tmpvar_4;
  tmpvar_57 = tmpvar_58;
  c_1.xyz = tmpvar_57.xyz;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
// Platform d3d11 skipped due to earlier errors
SubProgram "opengl " {
// Stats: 441 math, 45 textures
Keywords { "POINT" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
MAD R4.w, R5.z, R4, R5.x;
MUL R2.w, R2, c[8].x;
ADD R2.xyz, R1, c[10].wzzw;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R3.w, R2, R4, R3;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R4.x, R1, R5, R4.w;
MAD R2.y, R1.x, R5, R2;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.x, R1.z, R0, R0.z;
DP3 R0.z, fragment.texcoord[0], fragment.texcoord[0];
RSQ R1.x, R0.z;
MUL R1.xyz, R1.x, fragment.texcoord[0];
MAD R0.w, R2.z, R2.x, R1;
DP3_SAT R1.w, R1, -fragment.texcoord[2];
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MUL R0.y, R0, c[8].x;
MAD R0.w, R0.x, R0.y, R0;
ADD R0.xyz, R0.w, -c[0];
DP3_SAT R1.x, R1, fragment.texcoord[2];
MAX R2.x, R1, R1.w;
MOV R1, c[0];
ADD R0.w, R0, -c[0];
POW R2.x, R2.x, c[2].x;
MAD R0.w, R0, c[5].x, R1;
MUL result.color.w, R0, R2.x;
MAD result.color.xyz, R0, c[3].x, R1;
END
# 441 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 94 math, 9 textures, 5 branches
Keywords { "POINT" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r1.x, r0, r0.w
pow_pp r0, r1.x, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mad_pp oC0.xyz, r2, c3.x, r1
mul_pp oC0.w, r0.x, r0.z
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
// Stats: 441 math, 45 textures
Keywords { "DIRECTIONAL" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
MAD R4.w, R5.z, R4, R5.x;
MUL R2.w, R2, c[8].x;
ADD R2.xyz, R1, c[10].wzzw;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R3.w, R2, R4, R3;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R4.x, R1, R5, R4.w;
MAD R2.y, R1.x, R5, R2;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.x, R1.z, R0, R0.z;
DP3 R0.z, fragment.texcoord[0], fragment.texcoord[0];
RSQ R1.x, R0.z;
MUL R1.xyz, R1.x, fragment.texcoord[0];
MAD R0.w, R2.z, R2.x, R1;
DP3_SAT R1.w, R1, -fragment.texcoord[2];
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MUL R0.y, R0, c[8].x;
MAD R0.w, R0.x, R0.y, R0;
ADD R0.xyz, R0.w, -c[0];
DP3_SAT R1.x, R1, fragment.texcoord[2];
MAX R2.x, R1, R1.w;
MOV R1, c[0];
ADD R0.w, R0, -c[0];
POW R2.x, R2.x, c[2].x;
MAD R0.w, R0, c[5].x, R1;
MUL result.color.w, R0, R2.x;
MAD result.color.xyz, R0, c[3].x, R1;
END
# 441 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 94 math, 9 textures, 5 branches
Keywords { "DIRECTIONAL" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r1.x, r0, r0.w
pow_pp r0, r1.x, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mad_pp oC0.xyz, r2, c3.x, r1
mul_pp oC0.w, r0.x, r0.z
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
// Stats: 441 math, 45 textures
Keywords { "SPOT" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
MAD R4.w, R5.z, R4, R5.x;
MUL R2.w, R2, c[8].x;
ADD R2.xyz, R1, c[10].wzzw;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R3.w, R2, R4, R3;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R4.x, R1, R5, R4.w;
MAD R2.y, R1.x, R5, R2;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.x, R1.z, R0, R0.z;
DP3 R0.z, fragment.texcoord[0], fragment.texcoord[0];
RSQ R1.x, R0.z;
MUL R1.xyz, R1.x, fragment.texcoord[0];
MAD R0.w, R2.z, R2.x, R1;
DP3_SAT R1.w, R1, -fragment.texcoord[2];
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MUL R0.y, R0, c[8].x;
MAD R0.w, R0.x, R0.y, R0;
ADD R0.xyz, R0.w, -c[0];
DP3_SAT R1.x, R1, fragment.texcoord[2];
MAX R2.x, R1, R1.w;
MOV R1, c[0];
ADD R0.w, R0, -c[0];
POW R2.x, R2.x, c[2].x;
MAD R0.w, R0, c[5].x, R1;
MUL result.color.w, R0, R2.x;
MAD result.color.xyz, R0, c[3].x, R1;
END
# 441 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 94 math, 9 textures, 5 branches
Keywords { "SPOT" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r1.x, r0, r0.w
pow_pp r0, r1.x, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mad_pp oC0.xyz, r2, c3.x, r1
mul_pp oC0.w, r0.x, r0.z
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
// Stats: 441 math, 45 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
MAD R4.w, R5.z, R4, R5.x;
MUL R2.w, R2, c[8].x;
ADD R2.xyz, R1, c[10].wzzw;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R3.w, R2, R4, R3;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R4.x, R1, R5, R4.w;
MAD R2.y, R1.x, R5, R2;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.x, R1.z, R0, R0.z;
DP3 R0.z, fragment.texcoord[0], fragment.texcoord[0];
RSQ R1.x, R0.z;
MUL R1.xyz, R1.x, fragment.texcoord[0];
MAD R0.w, R2.z, R2.x, R1;
DP3_SAT R1.w, R1, -fragment.texcoord[2];
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MUL R0.y, R0, c[8].x;
MAD R0.w, R0.x, R0.y, R0;
ADD R0.xyz, R0.w, -c[0];
DP3_SAT R1.x, R1, fragment.texcoord[2];
MAX R2.x, R1, R1.w;
MOV R1, c[0];
ADD R0.w, R0, -c[0];
POW R2.x, R2.x, c[2].x;
MAD R0.w, R0, c[5].x, R1;
MUL result.color.w, R0, R2.x;
MAD result.color.xyz, R0, c[3].x, R1;
END
# 441 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 94 math, 9 textures, 5 branches
Keywords { "POINT_COOKIE" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r1.x, r0, r0.w
pow_pp r0, r1.x, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mad_pp oC0.xyz, r2, c3.x, r1
mul_pp oC0.w, r0.x, r0.z
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
// Stats: 441 math, 45 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"3.0-!!ARBfp1.0
PARAM c[12] = { program.local[0..8],
		{ 0, 2, 3, 0.00390625 },
		{ 256, 1, -1, 0 },
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R1.xy, fragment.texcoord[1];
MOV R0.xy, c[9].x;
MOV R0.z, c[1].x;
MUL R1.z, fragment.texcoord[1], c[4].x;
ADD R3.xyz, R1, R0;
MUL R0.xyz, R3, c[6].x;
FLR R5.xyz, R0;
MUL R1.xyz, R5, c[9].w;
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
MUL R2.xyz, R1, c[9].w;
TEX R1, R2, texture[0], 2D;
ADD R1, R1, R2.z;
ADD R0.xyz, R0, -R5;
ADD R2.x, R1.w, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
ADD R4.x, R1.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R2.w, R2.x, -R0;
ADD R2.x, R1, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
ADD R2.x, R1.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R0, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R4.w, R2.x, -R3;
MAD R4.xyz, -R0, c[9].y, c[9].z;
MUL R2.xyz, R0, R0;
MUL R2.xyz, R2, R4;
MAD R3.w, R2.x, R4, R3;
MAD R0.w, R2.x, R2, R0;
ADD R0.w, R0, -R3;
MAD R2.w, R2.y, R0, R3;
MOV R4.x, R1.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
MOV R4.x, R1.w;
MOV R4.y, c[9].x;
ADD R5.xyz, R0, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.w, R6, R5;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R0, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.y, R5, R4;
MOV R1.w, c[9].x;
TEX R4.xyz, R1.zwzw, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R1.y, R1, -R0.w;
MAD R1.w, R2.x, R1.y, R0;
MOV R0.w, c[7].x;
ADD R4.xyz, R0, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R3.w, R5, R4;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R0.w, R0, c[6].x;
MUL R1.xyz, R3, R0.w;
FLR R5.xyz, R1;
MUL R4.xyz, R4, c[9].y;
ADD R4.xyz, R4, -c[10].y;
DP3 R4.x, R0, R4;
ADD R3.w, R3, -R4.x;
MAD R2.x, R2, R3.w, R4;
MUL R6.xyz, R5, c[9].w;
ADD R1.w, R1, -R2.x;
MAD R1.w, R2.y, R1, R2.x;
ADD R2.x, R2.w, -R1.w;
ABS R0.xyz, R6;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R5, -R0, R0;
MUL R0.xyz, R0, c[9].w;
TEX R4, R0, texture[0], 2D;
MAD R3.w, R2.z, R2.x, R1;
ADD R2, R4, R0.z;
ADD R1.xyz, R1, -R5;
ADD R0.x, R2.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.x, R2.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.w, R5, R4;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R4.w, R0.x, -R1;
ADD R0.x, R2, c[9].w;
MOV R0.y, c[9].x;
TEX R4.xyz, R0, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R1, c[10].wwzw;
DP3 R5.x, R5, R4;
ADD R0.x, R2.z, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R4.xyz, R0, c[9].y;
ADD R0.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R0.x, R4, R0;
ADD R5.y, R0.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R0.xyz, R1, R1;
MUL R0.xyz, R0, R4;
MAD R5.w, R0.x, R5.y, R5.x;
MAD R1.w, R0.x, R4, R1;
ADD R1.w, R1, -R5;
MOV R4.x, R2.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R6.xyz, R6, -c[10].y;
ADD R5.xyz, R1, c[10].wzww;
DP3 R2.y, R6, R5;
MOV R4.x, R2.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R2.w, R5, R4;
ADD R4.x, R2.w, -R2.y;
MAD R4.w, R0.x, R4.x, R2.y;
MAD R2.w, R0.y, R1, R5;
MUL R1.w, R0, c[7].x;
MOV R4.x, R2.z;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R2.xyz, R2, c[9].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R1, R2;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R4.xyz, R3, R1.w;
FLR R5.xyz, R4;
ADD R2.x, R5.w, -R0.w;
MAD R0.x, R0, R2, R0.w;
ADD R0.w, R4, -R0.x;
MAD R0.x, R0.y, R0.w, R0;
ADD R0.y, R2.w, -R0.x;
MUL R1.xyz, R5, c[9].w;
MOV R2.x, c[11];
ABS R1.xyz, R1;
FRC R1.xyz, R1;
MUL R1.xyz, R1, c[10].x;
CMP R1.xyz, R5, -R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.xyz, R1, c[9].w;
MAD R2.y, R0.z, R0, R0.x;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
MUL R2.w, R2.x, c[8].x;
MUL R4.w, R2, R2.y;
MAD R3.w, R3, c[11].x, R4;
MUL R1.w, R1, c[7].x;
ADD R1.x, R0.w, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
ADD R2.x, R0.y, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].z;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.x, R1, -R5.w;
ADD R1.x, R0, c[9].w;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R5.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R6.y, R5, R2;
ADD R1.x, R0.z, c[9].w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zwzw;
ADD R2.xyz, R2, -c[10].y;
DP3 R1.x, R2, R1;
ADD R6.z, R1.x, -R6.y;
MUL R1.xyz, R4, R4;
MAD R2.xyz, -R4, c[9].y, c[9].z;
MUL R5.xyz, R1, R2;
MAD R1.y, R5.x, R6.z, R6;
MAD R1.x, R5, R6, R5.w;
ADD R1.x, R1, -R1.y;
MAD R4.w, R5.y, R1.x, R1.y;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R2.xyz, R1, texture[1], 2D;
MUL R6.xyz, R2, c[9].y;
ADD R2.xyz, R4, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R2;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R2.xyz, R1, c[9].y;
ADD R1.xyz, R4, c[10].zzww;
ADD R2.xyz, R2, -c[10].y;
DP3 R0.w, R2, R1;
ADD R2.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R1.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R5.x, R2.x, R0.y;
MUL R2.xyz, R1, c[9].y;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.xyz, R0, c[9].y;
ADD R1.xyz, R4, c[10].zwww;
ADD R6.xyz, R0, -c[10].y;
ADD R2.xyz, R2, -c[10].y;
DP3 R5.w, R2, R1;
DP3 R4.x, R4, R6;
MUL R2.xyz, R3, R1.w;
FLR R1.xyz, R2;
ADD R4.y, R5.w, -R4.x;
MAD R4.x, R5, R4.y, R4;
ADD R0.w, R0, -R4.x;
MAD R5.x, R5.y, R0.w, R4;
ADD R4.w, R4, -R5.x;
MUL R0.xyz, R1, c[9].w;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R1, -R0, R0;
ADD R1.xyz, R2, -R1;
MUL R4.xyz, R0, c[9].w;
TEX R0, R4, texture[0], 2D;
ADD R0, R0, R4.z;
MAD R4.w, R5.z, R4, R5.x;
MUL R2.w, R2, c[8].x;
ADD R2.xyz, R1, c[10].wzzw;
ADD R4.x, R0.w, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R4.xyz, R4, c[9].y;
ADD R5.x, R0.y, c[9].w;
MOV R5.y, c[9].x;
TEX R5.xyz, R5, texture[1], 2D;
MUL R5.xyz, R5, c[9].y;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R2;
ADD R2.xyz, R1, c[10].z;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R6.x, R2, -R5.w;
ADD R2.x, R0, c[9].w;
MOV R2.y, c[9].x;
TEX R4.xyz, R2, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].wwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.x, R5, R4;
ADD R2.x, R0.z, c[9].w;
MOV R2.y, c[9].x;
TEX R2.xyz, R2, texture[1], 2D;
MUL R4.xyz, R2, c[9].y;
ADD R2.xyz, R1, c[10].zwzw;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.x, R4, R2;
ADD R5.y, R2.x, -R5.x;
MAD R4.xyz, -R1, c[9].y, c[9].z;
MUL R2.xyz, R1, R1;
MUL R2.xyz, R2, R4;
MAD R4.y, R2.x, R5, R5.x;
MAD R4.x, R2, R6, R5.w;
ADD R4.x, R4, -R4.y;
MAD R3.w, R2, R4, R3;
MAD R4.w, R2.y, R4.x, R4.y;
MOV R4.x, R0.y;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R1, c[10].wzww;
ADD R6.xyz, R6, -c[10].y;
DP3 R0.y, R6, R5;
MOV R4.x, R0.w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R1, c[10].zzww;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.w, R5, R4;
ADD R5.x, R0.w, -R0.y;
MOV R0.w, c[9].x;
TEX R4.xyz, R0.zwzw, texture[1], 2D;
MAD R0.w, R2.x, R5.x, R0.y;
MUL R5.xyz, R4, c[9].y;
MUL R0.z, R1.w, c[7].x;
ADD R4.xyz, R1, c[10].zwww;
ADD R5.xyz, R5, -c[10].y;
DP3 R5.w, R5, R4;
MUL R3.xyz, R3, R0.z;
FLR R4.xyz, R3;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
MUL R5.xyz, R0, c[9].y;
MUL R0.xyz, R4, c[9].w;
ADD R5.xyz, R5, -c[10].y;
DP3 R1.x, R1, R5;
ADD R1.y, R5.w, -R1.x;
MAD R1.w, R2.x, R1.y, R1.x;
ADD R0.w, R0, -R1;
MAD R1.w, R2.y, R0, R1;
ABS R0.xyz, R0;
FRC R0.xyz, R0;
MUL R0.xyz, R0, c[10].x;
CMP R0.xyz, R4, -R0, R0;
MUL R1.xyz, R0, c[9].w;
TEX R0, R1, texture[0], 2D;
ADD R0, R0, R1.z;
ADD R3.xyz, R3, -R4;
ADD R2.x, R4.w, -R1.w;
MOV R1.x, R0.w;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zzww;
ADD R4.xyz, R4, -c[10].y;
DP3 R2.y, R4, R1;
MOV R1.x, R0.y;
MOV R1.y, c[9].x;
TEX R4.xyz, R1, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R5.xyz, R5, -c[10].y;
ADD R4.xyz, R3, c[10].wzww;
DP3 R4.w, R5, R4;
ADD R5.x, R2.y, -R4.w;
MOV R1.x, R0;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R1.xyz, R1, c[9].y;
ADD R4.xyz, R1, -c[10].y;
DP3 R2.y, R3, R4;
MOV R1.x, R0.z;
MOV R1.y, c[9].x;
TEX R1.xyz, R1, texture[1], 2D;
MUL R4.xyz, R1, c[9].y;
ADD R1.xyz, R3, c[10].zwww;
ADD R4.xyz, R4, -c[10].y;
DP3 R1.x, R4, R1;
ADD R5.y, R1.x, -R2;
MAD R4.xyz, -R3, c[9].y, c[9].z;
MUL R1.xyz, R3, R3;
MUL R1.xyz, R1, R4;
MAD R4.x, R1, R5, R4.w;
MAD R2.y, R1.x, R5, R2;
ADD R4.w, R4.x, -R2.y;
ADD R4.x, R0, c[9].w;
MOV R4.y, c[9].x;
TEX R5.xyz, R4, texture[1], 2D;
MUL R6.xyz, R5, c[9].y;
ADD R5.xyz, R3, c[10].wwzw;
ADD R6.xyz, R6, -c[10].y;
DP3 R5.w, R6, R5;
ADD R4.x, R0.z, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].zwzw;
ADD R5.xyz, R5, -c[10].y;
DP3 R0.x, R5, R4;
ADD R6.x, R0, -R5.w;
ADD R4.x, R0.y, c[9].w;
MOV R4.y, c[9].x;
TEX R4.xyz, R4, texture[1], 2D;
MUL R5.xyz, R4, c[9].y;
ADD R4.xyz, R3, c[10].wzzw;
ADD R0.x, R0.w, c[9].w;
MOV R0.y, c[9].x;
TEX R0.xyz, R0, texture[1], 2D;
ADD R5.xyz, R5, -c[10].y;
MUL R0.xyz, R0, c[9].y;
ADD R0.xyz, R0, -c[10].y;
ADD R3.xyz, R3, c[10].z;
DP3 R0.x, R0, R3;
DP3 R0.w, R5, R4;
ADD R0.x, R0, -R0.w;
MAD R0.x, R1, R0, R0.w;
MAD R0.y, R1.x, R6.x, R5.w;
ADD R0.x, R0, -R0.y;
MAD R0.x, R1.y, R0, R0.y;
MAD R0.z, R1.y, R4.w, R2.y;
ADD R0.x, R0, -R0.z;
MAD R0.x, R1.z, R0, R0.z;
DP3 R0.z, fragment.texcoord[0], fragment.texcoord[0];
RSQ R1.x, R0.z;
MUL R1.xyz, R1.x, fragment.texcoord[0];
MAD R0.w, R2.z, R2.x, R1;
DP3_SAT R1.w, R1, -fragment.texcoord[2];
MUL R0.y, R2.w, c[8].x;
MAD R0.w, R0.y, R0, R3;
MUL R0.y, R0, c[8].x;
MAD R0.w, R0.x, R0.y, R0;
ADD R0.xyz, R0.w, -c[0];
DP3_SAT R1.x, R1, fragment.texcoord[2];
MAX R2.x, R1, R1.w;
MOV R1, c[0];
ADD R0.w, R0, -c[0];
POW R2.x, R2.x, c[2].x;
MAD R0.w, R0, c[5].x, R1;
MUL result.color.w, R0, R2.x;
MAD result.color.xyz, R0, c[3].x, R1;
END
# 441 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 94 math, 9 textures, 5 branches
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_TintColor]
Float 1 [_Evolution]
Float 2 [_RimPower]
Float 3 [_Distortion]
Float 4 [_ZDistortion]
Float 5 [_AlphaDistortion]
Float 6 [_Frequency]
Float 7 [_Lacunarity]
Float 8 [_Gain]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
dcl_2d s0
dcl_2d s1
def c9, 0.00000000, 0.50000000, 2.00000000, 3.00000000
defi i0, 5, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r1.xy, v1
mov r0.xy, c9.x
mov r0.z, c1.x
mul r1.z, v1, c4.x
add r2.xyz, r1, r0
mov r0.w, c6.x
mov r2.w, c9.y
mov r3.w, c9.x
loop aL, i0
mul r0.xyz, r2, r0.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r4.xyz, r3, c11.yxyw
mov r0.x, r1
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c10.z, c10.w
dp3 r4.w, r3, r5
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c11.xxyw
mov r0.y, c9.x
mov r0.x, r1.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c11.xyyw
mov r0.x, r1.z
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
add r4.x, r1, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c11.xyxw
add r4.x, r1.z, c10
mov r4.y, c9.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c10.z, c10.w
dp3 r1.x, r4, r5
add r4.x, r1.y, c10
add r5.x, r1, -r6
mov r4.y, c9.x
texld r1.xyz, r4, s1
add r4.xyz, r3, c11.yxxw
mad r1.xyz, r1, c10.z, c10.w
dp3 r4.x, r1, r4
mov r1.y, c9.x
add r1.x, r1.w, c10
texld r1.xyz, r1, s1
mad r1.xyz, r1, c10.z, c10.w
add r3.xyz, r3, c11.x
dp3 r1.x, r1, r3
mad r1.y, r0.x, r5.x, r6.x
add r1.x, r1, -r4
mad r0.x, r0, r1, r4
add r0.x, r0, -r1.y
mad r1.x, r0.y, r5.w, r4.w
mad r0.x, r0.y, r0, r1.y
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
mad r3.w, r0.x, r2, r3
mul r0.w, r0, c7.x
mul r2.w, r2, c8.x
endloop
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul r0.xyz, r0.x, v0
dp3_sat r0.w, r0, -v2
dp3_sat r0.x, r0, v2
max_pp r1.x, r0, r0.w
pow_pp r0, r1.x, c2.x
mov_pp r0.z, r0.x
mov_pp r1.xyz, c0
add_pp r2.xyz, r3.w, -c0
mov_pp r0.x, c0.w
add_pp r0.y, r3.w, -c0.w
mad_pp r0.x, r0.y, c5, r0
mad_pp oC0.xyz, r2, c3.x, r1
mul_pp oC0.w, r0.x, r0.z
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
Fallback "Particles/Alpha Blended"
}