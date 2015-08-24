// Compiled shader for all platforms, uncompressed size: 913.8KB

Shader "Surface/ProceduralGasGiant" {
Properties {
 _MainTex ("Ramp Texture", 2D) = "white" {}
 _PlanetOpacity ("Opacity", Float) = 1
 _Evolution ("Time", Float) = 0
 _StormFrequency ("Storm Frequency", Float) = 5
 _StormThreshold ("Storm Threshold", Float) = 0.85
 _Distortion ("Distortion", Range(0,0.05)) = 0.02
 _MainFrequency ("Frequency", Float) = 25
 _Lacunarity ("Lacunarity", Float) = 1.3
 _Gain ("Gain", Float) = 0.9
 _PermTable2D ("2D Perm Table", 2D) = "white" {}
 _Gradient3D ("3D Gradient", 2D) = "white" {}
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 21 avg math (8..46)
 //        d3d9 : 26 avg math (8..59)
 //      opengl : 26 avg math (8..59)
 // Stats for Fragment shader:
 //       d3d11 : 268 avg math (268..270), 46 avg texture (46..47), 2 branch
 //        d3d9 : 372 avg math (371..374), 46 avg texture (46..47), 10 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
// Stats: 29 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [unity_Scale]
"3.0-!!ARBvp1.0
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
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
ADD result.texcoord[2].xyz, R2, R1;
MUL result.texcoord[0].xyz, R0.y, vertex.position;
MOV result.texcoord[1].z, R2.w;
MOV result.texcoord[1].y, R3.x;
MOV result.texcoord[1].x, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 29 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 29 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c15.w
dp3 r3.x, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.x
mov r0.z, r2.w
mov r0.w, c16.x
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
add o3.xyz, r2, r1
mul o1.xyz, r0.y, v0
mov o2.z, r2.w
mov o2.y, r3.x
mov o2.x, r0
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityLighting" 720
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgckmpajegogdobdepkjadbgdbkjemmflabaaaaaaaeafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
iaadaaaaeaaaabaaoaaaaaaafjaaaaaeegiocaaaaaaaaaaacnaaaaaafjaaaaae
egiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaaaaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaaaaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaaaaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaaaaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaaaaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaaaaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaaaaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 c_211;
  c_211.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_211.w = _PlanetOpacity;
  c_1.xyz = (c_211.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = _PlanetOpacity;
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
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 c_211;
  c_211.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_211.w = _PlanetOpacity;
  c_1.xyz = (c_211.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = _PlanetOpacity;
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
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 c_211;
  c_211.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_211.w = _PlanetOpacity;
  c_1.xyz = (c_211.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MUL result.texcoord[0].xyz, R0.x, vertex.position;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_position0 v0
dcl_texcoord1 v2
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o1.xyz, r0.x, v0
mad o2.xy, v2, c8, c8.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 112
Vector 96 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhbkdmnapponjhgjmfbipiampcghiefjcabaaaaaapaacaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
uniform sampler2D unity_Lightmap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  c_1.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = _PlanetOpacity;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
uniform sampler2D unity_Lightmap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 tmpvar_211;
  tmpvar_211 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  c_1.xyz = (tmpvar_2 * ((8.0 * tmpvar_211.w) * tmpvar_211.xyz));
  c_1.w = _PlanetOpacity;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
uniform sampler2D unity_Lightmap;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  c_1.xyz = (tmpvar_2 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
"3.0-!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
DP3 R0.x, vertex.position, vertex.position;
RSQ R0.x, R0.x;
MUL result.texcoord[0].xyz, R0.x, vertex.position;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_position0 v0
dcl_texcoord1 v2
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o1.xyz, r0.x, v0
mad o2.xy, v2, c8, c8.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 112
Vector 96 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhbkdmnapponjhgjmfbipiampcghiefjcabaaaaaapaacaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcieabaaaaeaaaabaagbaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahhccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaa
dcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaa
ogikcaaaaaaaaaaaagaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
uniform sampler2D unity_Lightmap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  mediump vec3 lm_211;
  lowp vec3 tmpvar_212;
  tmpvar_212 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_211 = tmpvar_212;
  mediump vec3 tmpvar_213;
  tmpvar_213 = (tmpvar_2 * lm_211);
  c_1.xyz = tmpvar_213;
  c_1.w = _PlanetOpacity;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
uniform sampler2D unity_Lightmap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 tmpvar_211;
  tmpvar_211 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_212;
  lowp vec3 tmpvar_213;
  tmpvar_213 = ((8.0 * tmpvar_211.w) * tmpvar_211.xyz);
  lm_212 = tmpvar_213;
  mediump vec3 tmpvar_214;
  tmpvar_214 = (tmpvar_2 * lm_212);
  c_1.xyz = tmpvar_214;
  c_1.w = _PlanetOpacity;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
out highp vec3 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
uniform sampler2D unity_Lightmap;
in highp vec3 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  mediump vec3 lm_211;
  lowp vec3 tmpvar_212;
  tmpvar_212 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_211 = tmpvar_212;
  mediump vec3 tmpvar_213;
  tmpvar_213 = (tmpvar_2 * lm_211);
  c_1.xyz = tmpvar_213;
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 59 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
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
"3.0-!!ARBvp1.0
PARAM c[25] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..24] };
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
ADD result.texcoord[2].xyz, R0, R1;
MUL result.texcoord[0].xyz, R0.w, vertex.position;
MOV result.texcoord[1].z, R3.x;
MOV result.texcoord[1].y, R3.w;
MOV result.texcoord[1].x, R4;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 59 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 59 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c24, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
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
mov r4.w, c24.x
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
add r1, r2, c24.x
dp4 r2.z, r4, c18
dp4 r2.y, r4, c17
dp4 r2.x, r4, c16
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c24.y
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
add o3.xyz, r0, r1
mul o1.xyz, r0.w, v0
mov o2.z, r3.x
mov o2.y, r3.w
mov o2.x, r4
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 46 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityLighting" 720
Vector 32 [unity_4LightPosX0]
Vector 48 [unity_4LightPosY0]
Vector 64 [unity_4LightPosZ0]
Vector 80 [unity_4LightAtten0]
Vector 96 [unity_LightColor0]
Vector 112 [unity_LightColor1]
Vector 128 [unity_LightColor2]
Vector 144 [unity_LightColor3]
Vector 160 [unity_LightColor4]
Vector 176 [unity_LightColor5]
Vector 192 [unity_LightColor6]
Vector 208 [unity_LightColor7]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedaligemmdeheanjikjiodmcnbaihioefnabaaaaaafeaiaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
naagaaaaeaaaabaaleabaaaafjaaaaaeegiocaaaaaaaaaaacnaaaaaafjaaaaae
egiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacagaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaabaaaaaaegiocaaaaaaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaai
ccaabaaaabaaaaaaegiocaaaaaaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaai
ecaabaaaabaaaaaaegiocaaaaaaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaaaaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaaaaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaaaaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaa
bkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaihcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaa
adaaaaaafgafbaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaah
pcaabaaaaeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaa
adaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaa
agaabaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaa
acaaaaaakgakbaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaa
aeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaa
egaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaa
dcaaaaanpcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaafaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaa
ajaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaadaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
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
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 c_211;
  c_211.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_211.w = _PlanetOpacity;
  c_1.xyz = (c_211.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = _PlanetOpacity;
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
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture2D (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture2D (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture2D (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture2D (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture2D (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture2D (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture2D (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture2D (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture2D (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture2D (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture2D (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture2D (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture2D (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture2D (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture2D (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture2D (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture2D (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture2D (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture2D (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture2D (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture2D (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture2D (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture2D (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture2D (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture2D (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture2D (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture2D (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture2D (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture2D (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture2D (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture2D (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture2D (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture2D (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture2D (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture2D (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture2D (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture2D (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture2D (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture2D (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture2D (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture2D (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture2D (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture2D (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture2D (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture2D (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture2D (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 c_211;
  c_211.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_211.w = _PlanetOpacity;
  c_1.xyz = (c_211.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = _PlanetOpacity;
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
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  highp float s_3;
  mediump vec3 c_4;
  highp vec3 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _Evolution;
  tmpvar_5.z = _Evolution;
  highp vec3 p_6;
  p_6 = (xlv_TEXCOORD0 + tmpvar_5);
  int i_7;
  highp float amp_8;
  highp float freq_9;
  highp float sum_10;
  sum_10 = 0.0;
  freq_9 = _MainFrequency;
  amp_8 = 1.0;
  i_7 = 0;
  for (int i_7 = 0; i_7 < 6; ) {
    highp vec3 p_11;
    p_11 = (p_6 * freq_9);
    highp vec3 tmpvar_12;
    tmpvar_12 = (floor(p_11) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_13;
    tmpvar_13 = (fract(abs(tmpvar_12)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_14;
    if ((tmpvar_12.x >= 0.0)) {
      tmpvar_14 = tmpvar_13.x;
    } else {
      tmpvar_14 = -(tmpvar_13.x);
    };
    highp float tmpvar_15;
    if ((tmpvar_12.y >= 0.0)) {
      tmpvar_15 = tmpvar_13.y;
    } else {
      tmpvar_15 = -(tmpvar_13.y);
    };
    highp float tmpvar_16;
    if ((tmpvar_12.z >= 0.0)) {
      tmpvar_16 = tmpvar_13.z;
    } else {
      tmpvar_16 = -(tmpvar_13.z);
    };
    highp vec3 tmpvar_17;
    tmpvar_17.x = tmpvar_14;
    tmpvar_17.y = tmpvar_15;
    tmpvar_17.z = tmpvar_16;
    highp vec3 tmpvar_18;
    tmpvar_18 = (p_11 - floor(p_11));
    p_11 = tmpvar_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((tmpvar_18 * tmpvar_18) * (3.0 - (2.0 * tmpvar_18)));
    highp vec3 tmpvar_20;
    tmpvar_20 = (tmpvar_17 / 256.0);
    highp vec4 tmpvar_21;
    lowp vec4 tmpvar_22;
    tmpvar_22 = texture (_PermTable2D, tmpvar_20.xy);
    tmpvar_21 = tmpvar_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_21 + tmpvar_20.z);
    highp vec3 g_24;
    highp vec2 tmpvar_25;
    tmpvar_25.y = 0.0;
    tmpvar_25.x = tmpvar_23.x;
    lowp vec3 tmpvar_26;
    tmpvar_26 = ((texture (_Gradient3D, tmpvar_25).xyz * 2.0) - 1.0);
    g_24 = tmpvar_26;
    highp vec3 g_27;
    highp vec2 tmpvar_28;
    tmpvar_28.y = 0.0;
    tmpvar_28.x = tmpvar_23.z;
    lowp vec3 tmpvar_29;
    tmpvar_29 = ((texture (_Gradient3D, tmpvar_28).xyz * 2.0) - 1.0);
    g_27 = tmpvar_29;
    highp vec3 g_30;
    highp vec2 tmpvar_31;
    tmpvar_31.y = 0.0;
    tmpvar_31.x = tmpvar_23.y;
    lowp vec3 tmpvar_32;
    tmpvar_32 = ((texture (_Gradient3D, tmpvar_31).xyz * 2.0) - 1.0);
    g_30 = tmpvar_32;
    highp vec3 g_33;
    highp vec2 tmpvar_34;
    tmpvar_34.y = 0.0;
    tmpvar_34.x = tmpvar_23.w;
    lowp vec3 tmpvar_35;
    tmpvar_35 = ((texture (_Gradient3D, tmpvar_34).xyz * 2.0) - 1.0);
    g_33 = tmpvar_35;
    highp vec3 g_36;
    highp vec2 tmpvar_37;
    tmpvar_37.y = 0.0;
    tmpvar_37.x = (tmpvar_23.x + 0.00390625);
    lowp vec3 tmpvar_38;
    tmpvar_38 = ((texture (_Gradient3D, tmpvar_37).xyz * 2.0) - 1.0);
    g_36 = tmpvar_38;
    highp vec3 g_39;
    highp vec2 tmpvar_40;
    tmpvar_40.y = 0.0;
    tmpvar_40.x = (tmpvar_23.z + 0.00390625);
    lowp vec3 tmpvar_41;
    tmpvar_41 = ((texture (_Gradient3D, tmpvar_40).xyz * 2.0) - 1.0);
    g_39 = tmpvar_41;
    highp vec3 g_42;
    highp vec2 tmpvar_43;
    tmpvar_43.y = 0.0;
    tmpvar_43.x = (tmpvar_23.y + 0.00390625);
    lowp vec3 tmpvar_44;
    tmpvar_44 = ((texture (_Gradient3D, tmpvar_43).xyz * 2.0) - 1.0);
    g_42 = tmpvar_44;
    highp vec3 g_45;
    highp vec2 tmpvar_46;
    tmpvar_46.y = 0.0;
    tmpvar_46.x = (tmpvar_23.w + 0.00390625);
    lowp vec3 tmpvar_47;
    tmpvar_47 = ((texture (_Gradient3D, tmpvar_46).xyz * 2.0) - 1.0);
    g_45 = tmpvar_47;
    sum_10 = (sum_10 + (abs(mix (mix (mix (dot (g_24, tmpvar_18), dot (g_27, (tmpvar_18 + vec3(-1.0, 0.0, 0.0))), tmpvar_19.x), mix (dot (g_30, (tmpvar_18 + vec3(0.0, -1.0, 0.0))), dot (g_33, (tmpvar_18 + vec3(-1.0, -1.0, 0.0))), tmpvar_19.x), tmpvar_19.y), mix (mix (dot (g_36, (tmpvar_18 + vec3(0.0, 0.0, -1.0))), dot (g_39, (tmpvar_18 + vec3(-1.0, 0.0, -1.0))), tmpvar_19.x), mix (dot (g_42, (tmpvar_18 + vec3(0.0, -1.0, -1.0))), dot (g_45, (tmpvar_18 + vec3(-1.0, -1.0, -1.0))), tmpvar_19.x), tmpvar_19.y), tmpvar_19.z)) * amp_8));
    freq_9 = (freq_9 * _Lacunarity);
    amp_8 = (amp_8 * _Gain);
    i_7 = (i_7 + 1);
  };
  highp float tmpvar_48;
  tmpvar_48 = (sum_10 * _Distortion);
  mediump float tmpvar_49;
  tmpvar_49 = (_StormThreshold * 2.0);
  s_3 = tmpvar_49;
  highp float sum_50;
  sum_50 = 0.0;
  highp vec3 p_51;
  p_51 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_52;
  tmpvar_52 = (floor(p_51) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_53;
  tmpvar_53 = (fract(abs(tmpvar_52)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_54;
  if ((tmpvar_52.x >= 0.0)) {
    tmpvar_54 = tmpvar_53.x;
  } else {
    tmpvar_54 = -(tmpvar_53.x);
  };
  highp float tmpvar_55;
  if ((tmpvar_52.y >= 0.0)) {
    tmpvar_55 = tmpvar_53.y;
  } else {
    tmpvar_55 = -(tmpvar_53.y);
  };
  highp float tmpvar_56;
  if ((tmpvar_52.z >= 0.0)) {
    tmpvar_56 = tmpvar_53.z;
  } else {
    tmpvar_56 = -(tmpvar_53.z);
  };
  highp vec3 tmpvar_57;
  tmpvar_57.x = tmpvar_54;
  tmpvar_57.y = tmpvar_55;
  tmpvar_57.z = tmpvar_56;
  highp vec3 tmpvar_58;
  tmpvar_58 = (p_51 - floor(p_51));
  p_51 = tmpvar_58;
  highp vec3 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (3.0 - (2.0 * tmpvar_58)));
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_57 / 256.0);
  highp vec4 tmpvar_61;
  lowp vec4 tmpvar_62;
  tmpvar_62 = texture (_PermTable2D, tmpvar_60.xy);
  tmpvar_61 = tmpvar_62;
  highp vec4 tmpvar_63;
  tmpvar_63 = (tmpvar_61 + tmpvar_60.z);
  highp vec3 g_64;
  highp vec2 tmpvar_65;
  tmpvar_65.y = 0.0;
  tmpvar_65.x = tmpvar_63.x;
  lowp vec3 tmpvar_66;
  tmpvar_66 = ((texture (_Gradient3D, tmpvar_65).xyz * 2.0) - 1.0);
  g_64 = tmpvar_66;
  highp vec3 g_67;
  highp vec2 tmpvar_68;
  tmpvar_68.y = 0.0;
  tmpvar_68.x = tmpvar_63.z;
  lowp vec3 tmpvar_69;
  tmpvar_69 = ((texture (_Gradient3D, tmpvar_68).xyz * 2.0) - 1.0);
  g_67 = tmpvar_69;
  highp vec3 g_70;
  highp vec2 tmpvar_71;
  tmpvar_71.y = 0.0;
  tmpvar_71.x = tmpvar_63.y;
  lowp vec3 tmpvar_72;
  tmpvar_72 = ((texture (_Gradient3D, tmpvar_71).xyz * 2.0) - 1.0);
  g_70 = tmpvar_72;
  highp vec3 g_73;
  highp vec2 tmpvar_74;
  tmpvar_74.y = 0.0;
  tmpvar_74.x = tmpvar_63.w;
  lowp vec3 tmpvar_75;
  tmpvar_75 = ((texture (_Gradient3D, tmpvar_74).xyz * 2.0) - 1.0);
  g_73 = tmpvar_75;
  highp vec3 g_76;
  highp vec2 tmpvar_77;
  tmpvar_77.y = 0.0;
  tmpvar_77.x = (tmpvar_63.x + 0.00390625);
  lowp vec3 tmpvar_78;
  tmpvar_78 = ((texture (_Gradient3D, tmpvar_77).xyz * 2.0) - 1.0);
  g_76 = tmpvar_78;
  highp vec3 g_79;
  highp vec2 tmpvar_80;
  tmpvar_80.y = 0.0;
  tmpvar_80.x = (tmpvar_63.z + 0.00390625);
  lowp vec3 tmpvar_81;
  tmpvar_81 = ((texture (_Gradient3D, tmpvar_80).xyz * 2.0) - 1.0);
  g_79 = tmpvar_81;
  highp vec3 g_82;
  highp vec2 tmpvar_83;
  tmpvar_83.y = 0.0;
  tmpvar_83.x = (tmpvar_63.y + 0.00390625);
  lowp vec3 tmpvar_84;
  tmpvar_84 = ((texture (_Gradient3D, tmpvar_83).xyz * 2.0) - 1.0);
  g_82 = tmpvar_84;
  highp vec3 g_85;
  highp vec2 tmpvar_86;
  tmpvar_86.y = 0.0;
  tmpvar_86.x = (tmpvar_63.w + 0.00390625);
  lowp vec3 tmpvar_87;
  tmpvar_87 = ((texture (_Gradient3D, tmpvar_86).xyz * 2.0) - 1.0);
  g_85 = tmpvar_87;
  sum_50 = abs(mix (mix (mix (dot (g_64, tmpvar_58), dot (g_67, (tmpvar_58 + vec3(-1.0, 0.0, 0.0))), tmpvar_59.x), mix (dot (g_70, (tmpvar_58 + vec3(0.0, -1.0, 0.0))), dot (g_73, (tmpvar_58 + vec3(-1.0, -1.0, 0.0))), tmpvar_59.x), tmpvar_59.y), mix (mix (dot (g_76, (tmpvar_58 + vec3(0.0, 0.0, -1.0))), dot (g_79, (tmpvar_58 + vec3(-1.0, 0.0, -1.0))), tmpvar_59.x), mix (dot (g_82, (tmpvar_58 + vec3(0.0, -1.0, -1.0))), dot (g_85, (tmpvar_58 + vec3(-1.0, -1.0, -1.0))), tmpvar_59.x), tmpvar_59.y), tmpvar_59.z));
  highp float tmpvar_88;
  tmpvar_88 = (sum_50 - s_3);
  highp float sum_89;
  sum_89 = 0.0;
  highp vec3 p_90;
  p_90 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_91;
  tmpvar_91 = (floor(p_90) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_92;
  tmpvar_92 = (fract(abs(tmpvar_91)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_93;
  if ((tmpvar_91.x >= 0.0)) {
    tmpvar_93 = tmpvar_92.x;
  } else {
    tmpvar_93 = -(tmpvar_92.x);
  };
  highp float tmpvar_94;
  if ((tmpvar_91.y >= 0.0)) {
    tmpvar_94 = tmpvar_92.y;
  } else {
    tmpvar_94 = -(tmpvar_92.y);
  };
  highp float tmpvar_95;
  if ((tmpvar_91.z >= 0.0)) {
    tmpvar_95 = tmpvar_92.z;
  } else {
    tmpvar_95 = -(tmpvar_92.z);
  };
  highp vec3 tmpvar_96;
  tmpvar_96.x = tmpvar_93;
  tmpvar_96.y = tmpvar_94;
  tmpvar_96.z = tmpvar_95;
  highp vec3 tmpvar_97;
  tmpvar_97 = (p_90 - floor(p_90));
  p_90 = tmpvar_97;
  highp vec3 tmpvar_98;
  tmpvar_98 = ((tmpvar_97 * tmpvar_97) * (3.0 - (2.0 * tmpvar_97)));
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_96 / 256.0);
  highp vec4 tmpvar_100;
  lowp vec4 tmpvar_101;
  tmpvar_101 = texture (_PermTable2D, tmpvar_99.xy);
  tmpvar_100 = tmpvar_101;
  highp vec4 tmpvar_102;
  tmpvar_102 = (tmpvar_100 + tmpvar_99.z);
  highp vec3 g_103;
  highp vec2 tmpvar_104;
  tmpvar_104.y = 0.0;
  tmpvar_104.x = tmpvar_102.x;
  lowp vec3 tmpvar_105;
  tmpvar_105 = ((texture (_Gradient3D, tmpvar_104).xyz * 2.0) - 1.0);
  g_103 = tmpvar_105;
  highp vec3 g_106;
  highp vec2 tmpvar_107;
  tmpvar_107.y = 0.0;
  tmpvar_107.x = tmpvar_102.z;
  lowp vec3 tmpvar_108;
  tmpvar_108 = ((texture (_Gradient3D, tmpvar_107).xyz * 2.0) - 1.0);
  g_106 = tmpvar_108;
  highp vec3 g_109;
  highp vec2 tmpvar_110;
  tmpvar_110.y = 0.0;
  tmpvar_110.x = tmpvar_102.y;
  lowp vec3 tmpvar_111;
  tmpvar_111 = ((texture (_Gradient3D, tmpvar_110).xyz * 2.0) - 1.0);
  g_109 = tmpvar_111;
  highp vec3 g_112;
  highp vec2 tmpvar_113;
  tmpvar_113.y = 0.0;
  tmpvar_113.x = tmpvar_102.w;
  lowp vec3 tmpvar_114;
  tmpvar_114 = ((texture (_Gradient3D, tmpvar_113).xyz * 2.0) - 1.0);
  g_112 = tmpvar_114;
  highp vec3 g_115;
  highp vec2 tmpvar_116;
  tmpvar_116.y = 0.0;
  tmpvar_116.x = (tmpvar_102.x + 0.00390625);
  lowp vec3 tmpvar_117;
  tmpvar_117 = ((texture (_Gradient3D, tmpvar_116).xyz * 2.0) - 1.0);
  g_115 = tmpvar_117;
  highp vec3 g_118;
  highp vec2 tmpvar_119;
  tmpvar_119.y = 0.0;
  tmpvar_119.x = (tmpvar_102.z + 0.00390625);
  lowp vec3 tmpvar_120;
  tmpvar_120 = ((texture (_Gradient3D, tmpvar_119).xyz * 2.0) - 1.0);
  g_118 = tmpvar_120;
  highp vec3 g_121;
  highp vec2 tmpvar_122;
  tmpvar_122.y = 0.0;
  tmpvar_122.x = (tmpvar_102.y + 0.00390625);
  lowp vec3 tmpvar_123;
  tmpvar_123 = ((texture (_Gradient3D, tmpvar_122).xyz * 2.0) - 1.0);
  g_121 = tmpvar_123;
  highp vec3 g_124;
  highp vec2 tmpvar_125;
  tmpvar_125.y = 0.0;
  tmpvar_125.x = (tmpvar_102.w + 0.00390625);
  lowp vec3 tmpvar_126;
  tmpvar_126 = ((texture (_Gradient3D, tmpvar_125).xyz * 2.0) - 1.0);
  g_124 = tmpvar_126;
  sum_89 = abs(mix (mix (mix (dot (g_103, tmpvar_97), dot (g_106, (tmpvar_97 + vec3(-1.0, 0.0, 0.0))), tmpvar_98.x), mix (dot (g_109, (tmpvar_97 + vec3(0.0, -1.0, 0.0))), dot (g_112, (tmpvar_97 + vec3(-1.0, -1.0, 0.0))), tmpvar_98.x), tmpvar_98.y), mix (mix (dot (g_115, (tmpvar_97 + vec3(0.0, 0.0, -1.0))), dot (g_118, (tmpvar_97 + vec3(-1.0, 0.0, -1.0))), tmpvar_98.x), mix (dot (g_121, (tmpvar_97 + vec3(0.0, -1.0, -1.0))), dot (g_124, (tmpvar_97 + vec3(-1.0, -1.0, -1.0))), tmpvar_98.x), tmpvar_98.y), tmpvar_98.z));
  highp float tmpvar_127;
  tmpvar_127 = (sum_89 - s_3);
  highp float sum_128;
  sum_128 = 0.0;
  highp vec3 p_129;
  p_129 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_130;
  tmpvar_130 = (floor(p_129) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_131;
  tmpvar_131 = (fract(abs(tmpvar_130)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_132;
  if ((tmpvar_130.x >= 0.0)) {
    tmpvar_132 = tmpvar_131.x;
  } else {
    tmpvar_132 = -(tmpvar_131.x);
  };
  highp float tmpvar_133;
  if ((tmpvar_130.y >= 0.0)) {
    tmpvar_133 = tmpvar_131.y;
  } else {
    tmpvar_133 = -(tmpvar_131.y);
  };
  highp float tmpvar_134;
  if ((tmpvar_130.z >= 0.0)) {
    tmpvar_134 = tmpvar_131.z;
  } else {
    tmpvar_134 = -(tmpvar_131.z);
  };
  highp vec3 tmpvar_135;
  tmpvar_135.x = tmpvar_132;
  tmpvar_135.y = tmpvar_133;
  tmpvar_135.z = tmpvar_134;
  highp vec3 tmpvar_136;
  tmpvar_136 = (p_129 - floor(p_129));
  p_129 = tmpvar_136;
  highp vec3 tmpvar_137;
  tmpvar_137 = ((tmpvar_136 * tmpvar_136) * (3.0 - (2.0 * tmpvar_136)));
  highp vec3 tmpvar_138;
  tmpvar_138 = (tmpvar_135 / 256.0);
  highp vec4 tmpvar_139;
  lowp vec4 tmpvar_140;
  tmpvar_140 = texture (_PermTable2D, tmpvar_138.xy);
  tmpvar_139 = tmpvar_140;
  highp vec4 tmpvar_141;
  tmpvar_141 = (tmpvar_139 + tmpvar_138.z);
  highp vec3 g_142;
  highp vec2 tmpvar_143;
  tmpvar_143.y = 0.0;
  tmpvar_143.x = tmpvar_141.x;
  lowp vec3 tmpvar_144;
  tmpvar_144 = ((texture (_Gradient3D, tmpvar_143).xyz * 2.0) - 1.0);
  g_142 = tmpvar_144;
  highp vec3 g_145;
  highp vec2 tmpvar_146;
  tmpvar_146.y = 0.0;
  tmpvar_146.x = tmpvar_141.z;
  lowp vec3 tmpvar_147;
  tmpvar_147 = ((texture (_Gradient3D, tmpvar_146).xyz * 2.0) - 1.0);
  g_145 = tmpvar_147;
  highp vec3 g_148;
  highp vec2 tmpvar_149;
  tmpvar_149.y = 0.0;
  tmpvar_149.x = tmpvar_141.y;
  lowp vec3 tmpvar_150;
  tmpvar_150 = ((texture (_Gradient3D, tmpvar_149).xyz * 2.0) - 1.0);
  g_148 = tmpvar_150;
  highp vec3 g_151;
  highp vec2 tmpvar_152;
  tmpvar_152.y = 0.0;
  tmpvar_152.x = tmpvar_141.w;
  lowp vec3 tmpvar_153;
  tmpvar_153 = ((texture (_Gradient3D, tmpvar_152).xyz * 2.0) - 1.0);
  g_151 = tmpvar_153;
  highp vec3 g_154;
  highp vec2 tmpvar_155;
  tmpvar_155.y = 0.0;
  tmpvar_155.x = (tmpvar_141.x + 0.00390625);
  lowp vec3 tmpvar_156;
  tmpvar_156 = ((texture (_Gradient3D, tmpvar_155).xyz * 2.0) - 1.0);
  g_154 = tmpvar_156;
  highp vec3 g_157;
  highp vec2 tmpvar_158;
  tmpvar_158.y = 0.0;
  tmpvar_158.x = (tmpvar_141.z + 0.00390625);
  lowp vec3 tmpvar_159;
  tmpvar_159 = ((texture (_Gradient3D, tmpvar_158).xyz * 2.0) - 1.0);
  g_157 = tmpvar_159;
  highp vec3 g_160;
  highp vec2 tmpvar_161;
  tmpvar_161.y = 0.0;
  tmpvar_161.x = (tmpvar_141.y + 0.00390625);
  lowp vec3 tmpvar_162;
  tmpvar_162 = ((texture (_Gradient3D, tmpvar_161).xyz * 2.0) - 1.0);
  g_160 = tmpvar_162;
  highp vec3 g_163;
  highp vec2 tmpvar_164;
  tmpvar_164.y = 0.0;
  tmpvar_164.x = (tmpvar_141.w + 0.00390625);
  lowp vec3 tmpvar_165;
  tmpvar_165 = ((texture (_Gradient3D, tmpvar_164).xyz * 2.0) - 1.0);
  g_163 = tmpvar_165;
  sum_128 = abs(mix (mix (mix (dot (g_142, tmpvar_136), dot (g_145, (tmpvar_136 + vec3(-1.0, 0.0, 0.0))), tmpvar_137.x), mix (dot (g_148, (tmpvar_136 + vec3(0.0, -1.0, 0.0))), dot (g_151, (tmpvar_136 + vec3(-1.0, -1.0, 0.0))), tmpvar_137.x), tmpvar_137.y), mix (mix (dot (g_154, (tmpvar_136 + vec3(0.0, 0.0, -1.0))), dot (g_157, (tmpvar_136 + vec3(-1.0, 0.0, -1.0))), tmpvar_137.x), mix (dot (g_160, (tmpvar_136 + vec3(0.0, -1.0, -1.0))), dot (g_163, (tmpvar_136 + vec3(-1.0, -1.0, -1.0))), tmpvar_137.x), tmpvar_137.y), tmpvar_137.z));
  highp float tmpvar_166;
  tmpvar_166 = (max (0.0, ((tmpvar_88 * tmpvar_127) * (sum_128 - s_3))) * 50.0);
  highp vec3 p_167;
  p_167 = (xlv_TEXCOORD0 * 0.1);
  int i_168;
  highp float sum_169;
  highp float amp_170;
  highp float freq_171;
  freq_171 = _StormFrequency;
  amp_170 = 0.5;
  sum_169 = 0.0;
  i_168 = 0;
  for (int i_168 = 0; i_168 < 4; ) {
    highp vec3 p_172;
    p_172 = (p_167 * freq_171);
    highp vec3 tmpvar_173;
    tmpvar_173 = (floor(p_172) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_174;
    tmpvar_174 = (fract(abs(tmpvar_173)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_175;
    if ((tmpvar_173.x >= 0.0)) {
      tmpvar_175 = tmpvar_174.x;
    } else {
      tmpvar_175 = -(tmpvar_174.x);
    };
    highp float tmpvar_176;
    if ((tmpvar_173.y >= 0.0)) {
      tmpvar_176 = tmpvar_174.y;
    } else {
      tmpvar_176 = -(tmpvar_174.y);
    };
    highp float tmpvar_177;
    if ((tmpvar_173.z >= 0.0)) {
      tmpvar_177 = tmpvar_174.z;
    } else {
      tmpvar_177 = -(tmpvar_174.z);
    };
    highp vec3 tmpvar_178;
    tmpvar_178.x = tmpvar_175;
    tmpvar_178.y = tmpvar_176;
    tmpvar_178.z = tmpvar_177;
    highp vec3 tmpvar_179;
    tmpvar_179 = (p_172 - floor(p_172));
    p_172 = tmpvar_179;
    highp vec3 tmpvar_180;
    tmpvar_180 = ((tmpvar_179 * tmpvar_179) * (3.0 - (2.0 * tmpvar_179)));
    highp vec3 tmpvar_181;
    tmpvar_181 = (tmpvar_178 / 256.0);
    highp vec4 tmpvar_182;
    lowp vec4 tmpvar_183;
    tmpvar_183 = texture (_PermTable2D, tmpvar_181.xy);
    tmpvar_182 = tmpvar_183;
    highp vec4 tmpvar_184;
    tmpvar_184 = (tmpvar_182 + tmpvar_181.z);
    highp vec3 g_185;
    highp vec2 tmpvar_186;
    tmpvar_186.y = 0.0;
    tmpvar_186.x = tmpvar_184.x;
    lowp vec3 tmpvar_187;
    tmpvar_187 = ((texture (_Gradient3D, tmpvar_186).xyz * 2.0) - 1.0);
    g_185 = tmpvar_187;
    highp vec3 g_188;
    highp vec2 tmpvar_189;
    tmpvar_189.y = 0.0;
    tmpvar_189.x = tmpvar_184.z;
    lowp vec3 tmpvar_190;
    tmpvar_190 = ((texture (_Gradient3D, tmpvar_189).xyz * 2.0) - 1.0);
    g_188 = tmpvar_190;
    highp vec3 g_191;
    highp vec2 tmpvar_192;
    tmpvar_192.y = 0.0;
    tmpvar_192.x = tmpvar_184.y;
    lowp vec3 tmpvar_193;
    tmpvar_193 = ((texture (_Gradient3D, tmpvar_192).xyz * 2.0) - 1.0);
    g_191 = tmpvar_193;
    highp vec3 g_194;
    highp vec2 tmpvar_195;
    tmpvar_195.y = 0.0;
    tmpvar_195.x = tmpvar_184.w;
    lowp vec3 tmpvar_196;
    tmpvar_196 = ((texture (_Gradient3D, tmpvar_195).xyz * 2.0) - 1.0);
    g_194 = tmpvar_196;
    highp vec3 g_197;
    highp vec2 tmpvar_198;
    tmpvar_198.y = 0.0;
    tmpvar_198.x = (tmpvar_184.x + 0.00390625);
    lowp vec3 tmpvar_199;
    tmpvar_199 = ((texture (_Gradient3D, tmpvar_198).xyz * 2.0) - 1.0);
    g_197 = tmpvar_199;
    highp vec3 g_200;
    highp vec2 tmpvar_201;
    tmpvar_201.y = 0.0;
    tmpvar_201.x = (tmpvar_184.z + 0.00390625);
    lowp vec3 tmpvar_202;
    tmpvar_202 = ((texture (_Gradient3D, tmpvar_201).xyz * 2.0) - 1.0);
    g_200 = tmpvar_202;
    highp vec3 g_203;
    highp vec2 tmpvar_204;
    tmpvar_204.y = 0.0;
    tmpvar_204.x = (tmpvar_184.y + 0.00390625);
    lowp vec3 tmpvar_205;
    tmpvar_205 = ((texture (_Gradient3D, tmpvar_204).xyz * 2.0) - 1.0);
    g_203 = tmpvar_205;
    highp vec3 g_206;
    highp vec2 tmpvar_207;
    tmpvar_207.y = 0.0;
    tmpvar_207.x = (tmpvar_184.w + 0.00390625);
    lowp vec3 tmpvar_208;
    tmpvar_208 = ((texture (_Gradient3D, tmpvar_207).xyz * 2.0) - 1.0);
    g_206 = tmpvar_208;
    sum_169 = (sum_169 + (mix (mix (mix (dot (g_185, tmpvar_179), dot (g_188, (tmpvar_179 + vec3(-1.0, 0.0, 0.0))), tmpvar_180.x), mix (dot (g_191, (tmpvar_179 + vec3(0.0, -1.0, 0.0))), dot (g_194, (tmpvar_179 + vec3(-1.0, -1.0, 0.0))), tmpvar_180.x), tmpvar_180.y), mix (mix (dot (g_197, (tmpvar_179 + vec3(0.0, 0.0, -1.0))), dot (g_200, (tmpvar_179 + vec3(-1.0, 0.0, -1.0))), tmpvar_180.x), mix (dot (g_203, (tmpvar_179 + vec3(0.0, -1.0, -1.0))), dot (g_206, (tmpvar_179 + vec3(-1.0, -1.0, -1.0))), tmpvar_180.x), tmpvar_180.y), tmpvar_180.z) * amp_170));
    freq_171 = (freq_171 * _Lacunarity);
    amp_170 = (amp_170 * _Gain);
    i_168 = (i_168 + 1);
  };
  highp vec2 tmpvar_209;
  tmpvar_209.y = 0.0;
  tmpvar_209.x = ((((xlv_TEXCOORD0.y + tmpvar_48) + (sum_169 * tmpvar_166)) * 0.5) - 0.5);
  lowp vec3 tmpvar_210;
  tmpvar_210 = texture (_MainTex, tmpvar_209).xyz;
  c_4 = tmpvar_210;
  c_4.x = max (0.05, c_4.x);
  c_4.y = max (0.05, c_4.y);
  c_4.z = max (0.05, c_4.z);
  tmpvar_2 = c_4;
  lowp vec4 c_211;
  c_211.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_211.w = _PlanetOpacity;
  c_1.xyz = (c_211.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
// Platform opengl had shader errors
//   Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
//   Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SubProgram "d3d9 " {
// Stats: 374 math, 46 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Float 2 [_PlanetOpacity]
Float 3 [_MainFrequency]
Float 4 [_Lacunarity]
Float 5 [_Gain]
Float 6 [_Distortion]
Float 7 [_Evolution]
Float 8 [_StormFrequency]
Float 9 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c10, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c11, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c12, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c13, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r0.xz, c7.x
mov r0.y, c10.x
add r1.xyz, v0, r0
mov r0.w, c10.x
mov r1.w, c3.x
mov r3.w, c10.y
loop aL, i0
mul r0.xyz, r1, r1.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c11.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c11.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c11.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c12.yxyw
mov r0.x, r2
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c11.z, c11.w
dp3 r4.w, r3, r5
mov r0.x, r2.y
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r5.w, r0, r4
add r4.xyz, r3, c12.xxyw
mov r0.y, c10.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r4
add r6.x, r0, -r5.w
add r4.xyz, r3, c12.xyyw
mov r0.x, r2.z
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r4
add r5.x, r0, -r4.w
mad r4.xyz, -r3, c10.z, c10.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r4.w, r0.x, r5.x, r4
mad r4.x, r0, r6, r5.w
add r5.w, r4.x, -r4
add r5.xyz, r3, c12.yyxw
add r4.x, r2, c11
mov r4.y, c10.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c11.z, c11.w
dp3 r6.x, r4, r5
add r5.xyz, r3, c12.xyxw
add r4.x, r2.z, c11
mov r4.y, c10.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c11.z, c11.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c11
add r5.x, r2, -r6
mov r4.y, c10.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c12.yxxw
mad r2.xyz, r2, c11.z, c11.w
dp3 r4.x, r2, r4
mov r2.y, c10.x
add r2.x, r2.w, c11
texld r2.xyz, r2, s1
mad r2.xyz, r2, c11.z, c11.w
add r3.xyz, r3, c12.x
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
mul r1.w, r1, c4.x
mul r3.w, r3, c5.x
endloop
add r0.xyz, v0, c12.wyww
mul r0.xyz, r0, c8.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c11.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c11.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c11.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c12.yxxw
add r0.x, r1.y, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c12.x
add r0.x, r1.w, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c12.yyxw
add r0.x, r1, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c12.xyxw
add r0.x, r1.z, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c10.z, c10.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c12.yxyw
mov r0.x, r1.y
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c10.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c12.xxyw
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c12.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c12.zyzw
mul r1.xyz, r0, c8.x
mov r4.y, c10.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c11.z, c11.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c11.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c11.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c11.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c12.yyxw
mov r6.x, r2
add r0.x, r2, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c12.xyxw
add r0.x, r2.z, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c12.yxxw
add r0.x, r2.y, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c12.x
add r0.x, r2.w, c11
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c10.z, c10.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c9
mul_pp r1.w, c10.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c12.yxyw
add r3.xyz, r4, c12.xyyw
mov r0.x, r2.y
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c12.xxyw
mov r0.x, r2.w
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c11.z, c11.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c8.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c11.x
mov r6.y, c10.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c11.z, c11.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c11.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c11.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c12.yxyw
mov r0.x, r2
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c11.z, c11.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c12.xxyw
mov r0.y, c10.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c12.xyyw
mov r0.x, r2.z
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c10.z, c10.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c12.yyxw
add r3.x, r2, c11
mov r3.y, c10.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c11.z, c11.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c12.xyxw
add r3.x, r2.z, c11
mov r3.y, c10.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c11.z, c11.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c11
add r4.x, r2, -r6
mov r3.y, c10.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c12.yxxw
mad r2.xyz, r2, c11.z, c11.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c12.x
mov r2.y, c10.x
add r2.x, r2.w, c11
texld r2.xyz, r2, s1
mad r2.xyz, r2, c11.z, c11.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c10
mul r1.w, r0.x, c13.x
mul r1.xyz, v0, c13.y
mul r0.w, r0, c6.x
mov r3.w, c8.x
mov r4.w, c13.z
mov r5.w, c10.x
loop aL, i1
mul r0.xyz, r1, r3.w
frc r3.xyz, r0
add r0.xyz, -r3, r0
mul r2.xyz, r0, c11.x
abs r2.xyz, r2
frc r2.xyz, r2
mul r2.xyz, r2, c11.y
cmp r0.xyz, r0, r2, -r2
mul r0.xyz, r0, c11.x
texld r2, r0, s0
add r2, r2, r0.z
add r4.xyz, r3, c12.yxyw
mov r0.x, r2
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r5.xyz, r0, c11.z, c11.w
dp3 r5.x, r3, r5
mov r0.x, r2.y
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r6.y, r0, r4
add r4.xyz, r3, c12.xxyw
mov r0.y, c10.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r4
add r6.z, r0.x, -r6.y
add r4.xyz, r3, c12.xyyw
mov r0.x, r2.z
mov r0.y, c10.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c11.z, c11.w
dp3 r0.x, r0, r4
add r5.y, r0.x, -r5.x
mad r4.xyz, -r3, c10.z, c10.w
mul r0.xyz, r3, r3
mul r0.xyz, r0, r4
mad r6.x, r0, r5.y, r5
mad r4.x, r0, r6.z, r6.y
add r6.y, r4.x, -r6.x
add r5.xyz, r3, c12.yyxw
add r4.x, r2, c11
mov r4.y, c10.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c11.z, c11.w
dp3 r6.z, r4, r5
add r5.xyz, r3, c12.xyxw
add r4.x, r2.z, c11
mov r4.y, c10.x
texld r4.xyz, r4, s1
mad r4.xyz, r4, c11.z, c11.w
dp3 r2.x, r4, r5
add r4.x, r2.y, c11
add r5.x, r2, -r6.z
mov r4.y, c10.x
texld r2.xyz, r4, s1
add r4.xyz, r3, c12.yxxw
mad r2.xyz, r2, c11.z, c11.w
dp3 r4.x, r2, r4
mov r2.y, c10.x
add r2.x, r2.w, c11
texld r2.xyz, r2, s1
mad r2.xyz, r2, c11.z, c11.w
add r3.xyz, r3, c12.x
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
mul r3.w, r3, c4.x
mul r4.w, r4, c5.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
dp3_pp r0.w, v1, c0
mov r0.y, c10.x
mad r0.x, r0, c13.z, -c13.z
texld r0.xyz, r0, s2
max_pp r1.xyz, r0, c13.w
mul_pp r0.xyz, r1, v2
mul_pp r1.xyz, r1, c1
max_pp r0.w, r0, c10.x
mul_pp r1.xyz, r0.w, r1
mad_pp oC0.xyz, r1, c10.z, r0
mov_pp oC0.w, c2.x
"
}
SubProgram "d3d11 " {
// Stats: 270 math, 46 textures, 2 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 96
Vector 16 [_LightColor0]
Float 48 [_PlanetOpacity]
Float 52 [_MainFrequency]
Float 60 [_Lacunarity]
Float 64 [_Gain]
Float 68 [_Distortion]
Float 72 [_Evolution]
Float 76 [_StormFrequency]
Float 80 [_StormThreshold]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedggnpccgjbhcpmeocphimlbkmfoeopigbabaaaaaalidfaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmideaaaaeaaaaaaadcanaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
amaaaaaadgaaaaagfcaabaaaaaaaaaaakgikcaaaaaaaaaaaaeaaaaaadgaaaaaf
ccaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaadgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaafaaaaaabkiacaaaaaaaaaaa
adaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaaigcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaagaaaaaaadaaaeaddkaabaaa
afaaaaaadiaaaaahhcaabaaaagaaaaaaegacbaaaaaaaaaaaagaabaaaafaaaaaa
ebaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaadiaaaaakhcaabaaaahaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaabkaaaaag
hcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaakhcaabaaaahaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaadcaaaaak
hcaabaaaagaaaaaaegacbaaaaaaaaaaaagaabaaaafaaaaaaegacbaiaebaaaaaa
agaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaagaaaaaaegacbaaaagaaaaaa
dcaaaabahcaabaaaajaaaaaaegacbaiaebaaaaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaaefaaaaaj
pcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaaajaaaaaadgaaaaaf
fcaabaaaabaaaaaaagabbaaaahaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaajaaaaaa
egacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
ajaaaaaaegacbaaaagaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaakaaaaaa
ogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
aiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaacaaaaaakgalbaaaahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaakaaaaaa
ogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaa
aiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
bkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaakpcaabaaa
ahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaaahaaaaaaefaaaaaj
pcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaa
ajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaa
efaaaaajpcaabaaaakaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
bcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaa
aaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaakgalbaaaahaaaaaaefaaaaaj
pcaabaaaahaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaa
agaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaahaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaaagaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaa
abaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaiaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaiaibaaaaaaabaaaaaa
bkaabaaaafaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaaafaaaaaaakaabaaa
afaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaafaaaaaabkaabaaa
afaaaaaaakiacaaaaaaaaaaaaeaaaaaaboaaaaahecaabaaaafaaaaaackaabaaa
afaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaaihcaabaaaaaaaaaaaegbcbaaa
abaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaabkaaaaaghcaabaaaabaaaaaaegacbaiaibaaaaaa
abaaaaaadhaaaaakhcaabaaaabaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaalhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
pgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaabahcaabaaaadaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
kgakbaaaabaaaaaaiganbaaaadaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaa
abaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaaegacbaaaaaaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaa
aeaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaa
adaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaadaaaaaa
dkaabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaaeaaaaaakgalbaaa
abaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaa
aaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaa
adaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaa
adaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaa
akaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaabkaabaaaacaaaaaaakaabaaa
adaaaaaadkaabaaaacaaaaaaaaaaaaakpcaabaaaabaaaaaacgahbaaaabaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaadaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaafgahbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
afaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaialpefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaaadaaaaaa
egacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaia
ebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaakocaabaaaadaaaaaa
agajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaialpdgaaaaai
kcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaapocaabaaaabaaaaaaagajbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialp
baaaaaahbcaabaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaaaaaaaaaaaaaaaai
bcaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaaabaaaaaa
aaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaaakaabaaaaaaaaaaa
dcaaaaajbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaaaaaaaaaakaabaaa
adaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaacaaaaaaakaabaaaaaaaaaaa
dkaabaaaacaaaaaadcaaaaambcaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
afaaaaaaabeaaaaaaaaaaaeaakaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaamieeaaaaaaaaaaaamieeaaaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaa
ebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaag
hcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaa
dgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
aaaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
akaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
agaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaa
aaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaaaaaaaak
pcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
acaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
ckaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaamccaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeabkaabaia
ibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaeiefaaaaaaaaaaaaeiefaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaa
acaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaa
adaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaa
kgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
adaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaa
aaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaa
afaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
ckaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaa
adaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
acaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaaacaaaaaadkaabaaa
abaaaaaackaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaa
aaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaaakaabaaaabaaaaaa
ckaabaaaaaaaaaaadcaaaaamecaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
afaaaaaaabeaaaaaaaaaaaeackaabaiaibaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
ckaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaeiecdiaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
mnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaadkiacaaa
aaaaaaaaaeaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaai
gcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaab
cbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaaaeaaaaaaadaaaead
dkaabaaaabaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaa
agaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaa
aiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaa
bnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaa
bkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaa
aiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaa
dcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaegacbaia
ebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaa
ahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaa
efaaaaajpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaaakaaaaaa
dgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaefaaaaajpcaabaaaakaaaaaa
egaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
alaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
alaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
alaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaak
pcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaaiaaaaaa
efaaaaajpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaa
efaaaaajpcaabaaaaiaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaefaaaaajpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaa
aaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaaakaabaaaadaaaaaackaabaaa
acaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaackaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaaabaaaaaa
bkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaaagaaaaaaakaabaaa
agaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaaagaaaaaabkaabaaa
agaaaaaaakiacaaaaaaaaaaaaeaaaaaaboaaaaahecaabaaaaaaaaaaackaabaaa
aaaaaaaaabeaaaaaabaaaaaabgaaaaabdcaaaaakecaabaaaaaaaaaaadkaabaaa
aaaaaaaabkiacaaaaaaaaaaaaeaaaaaabkbabaaaabaaaaaadcaaaaajbcaabaaa
aaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaalp
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaabaaaaaaiicaabaaa
aaaaaaaaegbcbaaaacaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdnmnmmemdnmnmmemdnaaaaaaaa
diaaaaaihcaabaaaabaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaadaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaag
iccabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadoaaaaab"
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
SubProgram "d3d9 " {
// Stats: 371 math, 47 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Float 0 [_PlanetOpacity]
Float 1 [_MainFrequency]
Float 2 [_Lacunarity]
Float 3 [_Gain]
Float 4 [_Distortion]
Float 5 [_Evolution]
Float 6 [_StormFrequency]
Float 7 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c11, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
def c12, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xy
mov r0.xz, c5.x
mov r0.y, c8.x
add r1.xyz, v0, r0
mov r0.w, c8.x
mov r1.w, c1.x
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
mul r1.w, r1, c2.x
mul r3.w, r3, c3.x
endloop
add r0.xyz, v0, c10.wyww
mul r0.xyz, r0, c6.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c9.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c9.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c9.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c10.yxxw
add r0.x, r1.y, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c10.x
add r0.x, r1.w, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c10.yyxw
add r0.x, r1, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c10.xyxw
add r0.x, r1.z, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c8.z, c8.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c10.yxyw
mov r0.x, r1.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c8.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c10.xxyw
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c10.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c10.zyzw
mul r1.xyz, r0, c6.x
mov r4.y, c8.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c9.z, c9.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c9.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c9.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c9.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c10.yyxw
mov r6.x, r2
add r0.x, r2, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c10.xyxw
add r0.x, r2.z, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c10.yxxw
add r0.x, r2.y, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c10.x
add r0.x, r2.w, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c8.z, c8.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c7
mul_pp r1.w, c8.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c10.yxyw
add r3.xyz, r4, c10.xyyw
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c10.xxyw
mov r0.x, r2.w
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c9.z, c9.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c6.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c9.x
mov r6.y, c8.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c9.z, c9.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c9.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c9.z, c9.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c8.z, c8.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c10.yyxw
add r3.x, r2, c9
mov r3.y, c8.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c9.z, c9.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c10.xyxw
add r3.x, r2.z, c9
mov r3.y, c8.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c9.z, c9.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c9
add r4.x, r2, -r6
mov r3.y, c8.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c10.x
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c8
mul r1.w, r0.x, c11.x
mul r1.xyz, v0, c11.y
mul r0.w, r0, c4.x
mov r3.w, c6.x
mov r4.w, c11.z
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
mul r3.w, r3, c2.x
mul r4.w, r4, c3.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
mov r0.y, c8.x
mad r0.x, r0, c11.z, -c11.z
texld r1.xyz, r0, s2
texld r0, v1, s3
max_pp r1.xyz, r1, c11.w
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c12.x
mov_pp oC0.w, c0.x
"
}
SubProgram "d3d11 " {
// Stats: 268 math, 47 textures, 2 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 112
Float 48 [_PlanetOpacity]
Float 52 [_MainFrequency]
Float 60 [_Lacunarity]
Float 64 [_Gain]
Float 68 [_Distortion]
Float 72 [_Evolution]
Float 76 [_StormFrequency]
Float 80 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbkaikecjjgndnpcmbdmkglafokmebaakabaaaaaahmdfaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckedeaaaaeaaaaaaacjanaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaakgikcaaaaaaaaaaa
aeaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaikcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaafaaaaaa
bkiacaaaaaaaaaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaagaaaaaa
adaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaaegacbaaaaaaaaaaa
agaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaadiaaaaak
hcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaa
ahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaak
hcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaa
ahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaaagaabaaaafaaaaaa
egacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaagaaaaaa
egacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaiaebaaaaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaa
ajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaa
ajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaaefaaaaajpcaabaaa
ajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaakhcaabaaaajaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaiecaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaaefaaaaajpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaa
acaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaa
abaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaai
ecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaa
ahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaa
ckaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaakgalbaaa
ahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaa
aaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaa
agaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaaakaabaaa
acaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaiaaaaaa
ckaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaia
ibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
afaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
afaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaeaaaaaaboaaaaahecaabaaa
afaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaaghcaabaaaabaaaaaa
egacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaalhcaabaaaaaaaaaaa
egbcbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaba
hcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaadgaaaaaffcaabaaa
adaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
aeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaa
egacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaa
aeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaa
adaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaacaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakpcaabaaaabaaaaaa
cgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaa
agajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaialpefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaak
ocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapocaabaaaabaaaaaaagajbaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaaabaaaaaaegacbaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaacaaaaaa
akaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeaakaabaiaibaaaaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaamieeaaaaaaaa
aaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaa
aaaaaaaaaeaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaak
hcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaa
adaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaak
hcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaa
aeaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaa
iganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaa
afaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaai
icaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaa
fgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaa
aeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaa
acaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaa
egacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaa
egacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaa
egacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaba
hcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaa
aeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaafaaaaaa
egacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
afaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
afaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaa
cgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaa
akaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeackaabaiaibaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaaabaaaaaaegbcbaaa
abaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaadgaaaaaikcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaa
agaaaaaadkiacaaaaaaaaaaaaeaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaa
aaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaa
diaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaa
dhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaa
agaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaa
egacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaa
iganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaefaaaaaj
pcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
bcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaaefaaaaaj
pcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaa
agabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaa
kgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaaogakbaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaaiaaaaaa
egacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaaakaabaaa
adaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaaajaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaackaabaaa
ajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaa
agaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
agaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaeaaaaaaboaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabdcaaaaakecaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaabkbabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
deaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdnmnmmemdn
mnmmemdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadoaaaaab"
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
SubProgram "d3d9 " {
// Stats: 371 math, 47 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Float 0 [_PlanetOpacity]
Float 1 [_MainFrequency]
Float 2 [_Lacunarity]
Float 3 [_Gain]
Float 4 [_Distortion]
Float 5 [_Evolution]
Float 6 [_StormFrequency]
Float 7 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c8, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c9, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c10, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c11, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
def c12, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xy
mov r0.xz, c5.x
mov r0.y, c8.x
add r1.xyz, v0, r0
mov r0.w, c8.x
mov r1.w, c1.x
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
mul r1.w, r1, c2.x
mul r3.w, r3, c3.x
endloop
add r0.xyz, v0, c10.wyww
mul r0.xyz, r0, c6.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c9.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c9.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c9.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c10.yxxw
add r0.x, r1.y, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c10.x
add r0.x, r1.w, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c10.yyxw
add r0.x, r1, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c10.xyxw
add r0.x, r1.z, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c8.z, c8.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c10.yxyw
mov r0.x, r1.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c8.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c10.xxyw
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c10.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c10.zyzw
mul r1.xyz, r0, c6.x
mov r4.y, c8.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c9.z, c9.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c9.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c9.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c9.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c10.yyxw
mov r6.x, r2
add r0.x, r2, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c10.xyxw
add r0.x, r2.z, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c10.yxxw
add r0.x, r2.y, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c10.x
add r0.x, r2.w, c9
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c8.z, c8.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c7
mul_pp r1.w, c8.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c10.yxyw
add r3.xyz, r4, c10.xyyw
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c10.xxyw
mov r0.x, r2.w
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c9.z, c9.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c6.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c9.x
mov r6.y, c8.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c9.z, c9.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c9.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c9.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c10.yxyw
mov r0.x, r2
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c9.z, c9.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c10.xxyw
mov r0.y, c8.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c10.xyyw
mov r0.x, r2.z
mov r0.y, c8.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c9.z, c9.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c8.z, c8.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c10.yyxw
add r3.x, r2, c9
mov r3.y, c8.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c9.z, c9.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c10.xyxw
add r3.x, r2.z, c9
mov r3.y, c8.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c9.z, c9.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c9
add r4.x, r2, -r6
mov r3.y, c8.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c10.yxxw
mad r2.xyz, r2, c9.z, c9.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c10.x
mov r2.y, c8.x
add r2.x, r2.w, c9
texld r2.xyz, r2, s1
mad r2.xyz, r2, c9.z, c9.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c8
mul r1.w, r0.x, c11.x
mul r1.xyz, v0, c11.y
mul r0.w, r0, c4.x
mov r3.w, c6.x
mov r4.w, c11.z
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
mul r3.w, r3, c2.x
mul r4.w, r4, c3.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
mov r0.y, c8.x
mad r0.x, r0, c11.z, -c11.z
texld r1.xyz, r0, s2
texld r0, v1, s3
max_pp r1.xyz, r1, c11.w
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r0, c12.x
mov_pp oC0.w, c0.x
"
}
SubProgram "d3d11 " {
// Stats: 268 math, 47 textures, 2 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [unity_Lightmap] 2D 3
ConstBuffer "$Globals" 112
Float 48 [_PlanetOpacity]
Float 52 [_MainFrequency]
Float 60 [_Lacunarity]
Float 64 [_Gain]
Float 68 [_Distortion]
Float 72 [_Evolution]
Float 76 [_StormFrequency]
Float 80 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbkaikecjjgndnpcmbdmkglafokmebaakabaaaaaahmdfaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckedeaaaaeaaaaaaacjanaaaa
fjaaaaaeegiocaaaaaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaakgikcaaaaaaaaaaa
aeaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaikcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaafaaaaaa
bkiacaaaaaaaaaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaa
dgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaa
daaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaagaaaaaa
adaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaaegacbaaaaaaaaaaa
agaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaadiaaaaak
hcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaa
ahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaak
hcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaa
ahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaaagaabaaaafaaaaaa
egacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaagaaaaaa
egacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaiaebaaaaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaa
ajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaa
ajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaaefaaaaajpcaabaaa
ajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaakhcaabaaaajaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaiecaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaaefaaaaajpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaa
acaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaa
abaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaai
ecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaa
ahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaa
ckaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaakgalbaaa
ahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaa
aaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaa
agaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaaakaabaaa
acaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaiaaaaaa
ckaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaia
ibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaadiaaaaaibcaabaaa
afaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
afaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaeaaaaaaboaaaaahecaabaaa
afaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaaihcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaaghcaabaaaabaaaaaa
egacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaalhcaabaaaaaaaaaaa
egbcbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaba
hcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaefaaaaajpcaabaaa
adaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaadgaaaaaffcaabaaa
adaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaaeaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaaacaaaaaa
akaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
aeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaa
egacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaa
aeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaa
adaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaacaaaaaa
bkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaabkaabaaa
acaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakpcaabaaaabaaaaaa
cgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaa
agajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaialpefaaaaaj
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaak
ocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaa
aaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaapocaabaaaabaaaaaaagajbaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaaabaaaaaaegacbaaa
aaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaaakaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaaaaaaaaaa
akaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaadaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaaacaaaaaa
akaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeaakaabaiaibaaaaaaaaaaaaaa
aaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaamieeaaaaaaaa
aaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaa
aaaaaaaaaeaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaak
hcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaa
adaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaak
hcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaa
adaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaa
aeaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaa
iganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaa
afaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaai
icaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaa
fgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaa
aeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
abaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
akaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaai
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaadcaaaaaj
ccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaa
aaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaadiaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaa
acaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaa
egacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaa
egacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaa
egacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaa
egacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaaba
hcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaa
aeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaa
aeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaafaaaaaa
egacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
aeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
afaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
afaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaa
dkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaabkaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaa
cgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
agaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaacaaaaaaakaabaaa
abaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaaacaaaaaa
akaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaaaaaaaaaaakiacaia
ebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeackaabaiaibaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaaabaaaaaaegbcbaaa
abaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaadgaaaaaikcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaa
agaaaaaadkiacaaaaaaaaaaaaeaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaa
aaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaaabeaaaaa
aeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaa
diaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaa
dhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaa
agaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaa
egacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaa
iganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaefaaaaaj
pcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
bcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaaefaaaaaj
pcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaa
agabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaa
kgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaaogakbaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaaiaaaaaa
egacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaaakaabaaa
adaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaaajaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaackaabaaa
ajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaaaaaaaaaa
dkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaibcaabaaa
agaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaadaaaaaadiaaaaaiccaabaaa
agaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaeaaaaaaboaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabdcaaaaakecaabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaabkbabaaaabaaaaaa
dcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
deaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdnmnmmemdn
mnmmemdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
adaaaaaaaagabaaaadaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadoaaaaab"
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
 //       d3d11 : 20 avg math (11..24)
 //        d3d9 : 17 avg math (12..20)
 // Stats for Fragment shader:
 //       d3d11 : 273 avg math (269..280), 47 avg texture (46..48), 2 branch
 //        d3d9 : 377 avg math (374..383), 47 avg texture (46..48), 10 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
// Platform opengl skipped due to earlier errors
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rsq r0.w, r1.x
mul r1.xyz, v1, c13.w
mul o1.xyz, r0.w, v0
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
add o3.xyz, -r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 160
Matrix 48 [_LightMatrix0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddkejaflcglgpldnkddgdlnffgmjignliabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmadaaaaeaaaabaa
ppaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp float tmpvar_213;
  tmpvar_213 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_214;
  c_214.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_213)).w) * 2.0));
  c_214.w = _PlanetOpacity;
  c_1.xyz = c_214.xyz;
  c_1.w = _PlanetOpacity;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp float tmpvar_213;
  tmpvar_213 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_214;
  c_214.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_213)).w) * 2.0));
  c_214.w = _PlanetOpacity;
  c_1.xyz = c_214.xyz;
  c_1.w = _PlanetOpacity;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp float tmpvar_213;
  tmpvar_213 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_214;
  c_214.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture (_LightTexture0, vec2(tmpvar_213)).w) * 2.0));
  c_214.w = _PlanetOpacity;
  c_1.xyz = c_214.xyz;
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "d3d9 " {
// Stats: 12 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_position0 v0
dcl_normal0 v1
mul r0.yzw, v1.xxyz, c9.w
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o1.xyz, r0.x, v0
dp3 o2.z, r0.yzww, c6
dp3 o2.y, r0.yzww, c5
dp3 o2.x, r0.yzww, c4
mov o3.xyz, c8
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 11 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedjadppbacbejniafodgdfjpadpjigkgagabaaaaaajaadaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
amacaaaaeaaaabaaidaaaaaafjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaae
egiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaa
aaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaa
egiccaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_212;
  c_212.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_212.w = _PlanetOpacity;
  c_1.xyz = c_212.xyz;
  c_1.w = _PlanetOpacity;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_212;
  c_212.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_212.w = _PlanetOpacity;
  c_1.xyz = c_212.xyz;
  c_1.w = _PlanetOpacity;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_212;
  c_212.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * 2.0));
  c_212.w = _PlanetOpacity;
  c_1.xyz = c_212.xyz;
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "d3d9 " {
// Stats: 20 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o4.w, r0, c11
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rsq r0.w, r1.x
mul r1.xyz, v1, c13.w
mul o1.xyz, r0.w, v0
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
add o3.xyz, -r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 160
Matrix 48 [_LightMatrix0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedfcfpolopmimolopibigfbajhggainjlcabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmadaaaaeaaaabaa
ppaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaafgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegaobaaaabaaaaaadcaaaaakpccabaaaaeaaaaaaegiocaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp vec2 P_213;
  P_213 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_214;
  tmpvar_214 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_215;
  atten_215 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_213).w) * texture2D (_LightTextureB0, vec2(tmpvar_214)).w);
  lowp vec4 c_216;
  c_216.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_215) * 2.0));
  c_216.w = _PlanetOpacity;
  c_1.xyz = c_216.xyz;
  c_1.w = _PlanetOpacity;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp vec2 P_213;
  P_213 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_214;
  tmpvar_214 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_215;
  atten_215 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture2D (_LightTexture0, P_213).w) * texture2D (_LightTextureB0, vec2(tmpvar_214)).w);
  lowp vec4 c_216;
  c_216.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_215) * 2.0));
  c_216.w = _PlanetOpacity;
  c_1.xyz = c_216.xyz;
  c_1.w = _PlanetOpacity;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp vec2 P_213;
  P_213 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_214;
  tmpvar_214 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_215;
  atten_215 = ((float((xlv_TEXCOORD3.z > 0.0)) * texture (_LightTexture0, P_213).w) * texture (_LightTextureB0, vec2(tmpvar_214)).w);
  lowp vec4 c_216;
  c_216.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * atten_215) * 2.0));
  c_216.w = _PlanetOpacity;
  c_1.xyz = c_216.xyz;
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "d3d9 " {
// Stats: 19 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o4.z, r0, c10
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rsq r0.w, r1.x
mul r1.xyz, v1, c13.w
mul o1.xyz, r0.w, v0
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
add o3.xyz, -r0, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 24 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 160
Matrix 48 [_LightMatrix0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefieceddkejaflcglgpldnkddgdlnffgmjignliabaaaaaajiafaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpmadaaaaeaaaabaa
ppaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
aaaaaaajhccabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaa
aaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
anaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaa
aaaaaaaaegacbaaaabaaaaaadcaaaaakhccabaaaaeaaaaaaegiccaaaaaaaaaaa
agaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp float tmpvar_213;
  tmpvar_213 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_214;
  c_214.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_213)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_214.w = _PlanetOpacity;
  c_1.xyz = c_214.xyz;
  c_1.w = _PlanetOpacity;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp float tmpvar_213;
  tmpvar_213 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_214;
  c_214.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_213)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_214.w = _PlanetOpacity;
  c_1.xyz = c_214.xyz;
  c_1.w = _PlanetOpacity;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  mediump vec3 tmpvar_212;
  tmpvar_212 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_212;
  highp float tmpvar_213;
  tmpvar_213 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_214;
  c_214.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * (texture (_LightTextureB0, vec2(tmpvar_213)).w * texture (_LightTexture0, xlv_TEXCOORD3).w)) * 2.0));
  c_214.w = _PlanetOpacity;
  c_1.xyz = c_214.xyz;
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "d3d9 " {
// Stats: 18 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_position0 v0
dcl_normal0 v1
dp4 r0.x, v0, c4
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.y, v0, c5
dp3 r1.x, v0, v0
dp4 o4.y, r0, c9
dp4 o4.x, r0, c8
rsq r0.x, r1.x
mul r1.xyz, v1, c13.w
mul o1.xyz, r0.x, v0
dp3 o2.z, r1, c6
dp3 o2.y, r1, c5
dp3 o2.x, r1, c4
mov o3.xyz, c12
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 19 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 160
Matrix 48 [_LightMatrix0]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Vector 320 [unity_Scale]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedpcepbagaodlpoabdbeoahlckghmjmbibabaaaaaapeaeaaaaadaaaaaa
cmaaaaaapeaaaaaajeabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcfiadaaaaeaaaabaa
ngaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaaddccabaaaaeaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaah
hccabaaaabaaaaaaagaabaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaa
aaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaa
dcaaaaakhccabaaaacaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaa
egadbaaaaaaaaaaadgaaaaaghccabaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaidcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaabaaaabaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaa
egaabaaaaaaaaaaadcaaaaakdccabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaa
pgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaab"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_212;
  c_212.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_212.w = _PlanetOpacity;
  c_1.xyz = c_212.xyz;
  c_1.w = _PlanetOpacity;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
varying highp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture2D (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture2D (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture2D (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture2D (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture2D (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture2D (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture2D (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture2D (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture2D (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture2D (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture2D (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture2D (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture2D (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture2D (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture2D (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture2D (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture2D (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture2D (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture2D (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture2D (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture2D (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture2D (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture2D (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture2D (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture2D (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture2D (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture2D (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture2D (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture2D (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture2D (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture2D (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture2D (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture2D (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture2D (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture2D (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture2D (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture2D (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture2D (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture2D (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture2D (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture2D (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture2D (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture2D (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture2D (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture2D (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_212;
  c_212.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_212.w = _PlanetOpacity;
  c_1.xyz = c_212.xyz;
  c_1.w = _PlanetOpacity;
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
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
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
  xlv_TEXCOORD0 = normalize(_glesVertex.xyz);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _PermTable2D;
uniform sampler2D _Gradient3D;
uniform sampler2D _MainTex;
uniform lowp float _PlanetOpacity;
uniform highp float _MainFrequency;
uniform highp float _Lacunarity;
uniform highp float _Gain;
uniform mediump float _Distortion;
uniform highp float _Evolution;
uniform highp float _StormFrequency;
uniform mediump float _StormThreshold;
in highp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  highp float s_4;
  mediump vec3 c_5;
  highp vec3 tmpvar_6;
  tmpvar_6.y = 0.0;
  tmpvar_6.x = _Evolution;
  tmpvar_6.z = _Evolution;
  highp vec3 p_7;
  p_7 = (xlv_TEXCOORD0 + tmpvar_6);
  int i_8;
  highp float amp_9;
  highp float freq_10;
  highp float sum_11;
  sum_11 = 0.0;
  freq_10 = _MainFrequency;
  amp_9 = 1.0;
  i_8 = 0;
  for (int i_8 = 0; i_8 < 6; ) {
    highp vec3 p_12;
    p_12 = (p_7 * freq_10);
    highp vec3 tmpvar_13;
    tmpvar_13 = (floor(p_12) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_14;
    tmpvar_14 = (fract(abs(tmpvar_13)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_15;
    if ((tmpvar_13.x >= 0.0)) {
      tmpvar_15 = tmpvar_14.x;
    } else {
      tmpvar_15 = -(tmpvar_14.x);
    };
    highp float tmpvar_16;
    if ((tmpvar_13.y >= 0.0)) {
      tmpvar_16 = tmpvar_14.y;
    } else {
      tmpvar_16 = -(tmpvar_14.y);
    };
    highp float tmpvar_17;
    if ((tmpvar_13.z >= 0.0)) {
      tmpvar_17 = tmpvar_14.z;
    } else {
      tmpvar_17 = -(tmpvar_14.z);
    };
    highp vec3 tmpvar_18;
    tmpvar_18.x = tmpvar_15;
    tmpvar_18.y = tmpvar_16;
    tmpvar_18.z = tmpvar_17;
    highp vec3 tmpvar_19;
    tmpvar_19 = (p_12 - floor(p_12));
    p_12 = tmpvar_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((tmpvar_19 * tmpvar_19) * (3.0 - (2.0 * tmpvar_19)));
    highp vec3 tmpvar_21;
    tmpvar_21 = (tmpvar_18 / 256.0);
    highp vec4 tmpvar_22;
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture (_PermTable2D, tmpvar_21.xy);
    tmpvar_22 = tmpvar_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_22 + tmpvar_21.z);
    highp vec3 g_25;
    highp vec2 tmpvar_26;
    tmpvar_26.y = 0.0;
    tmpvar_26.x = tmpvar_24.x;
    lowp vec3 tmpvar_27;
    tmpvar_27 = ((texture (_Gradient3D, tmpvar_26).xyz * 2.0) - 1.0);
    g_25 = tmpvar_27;
    highp vec3 g_28;
    highp vec2 tmpvar_29;
    tmpvar_29.y = 0.0;
    tmpvar_29.x = tmpvar_24.z;
    lowp vec3 tmpvar_30;
    tmpvar_30 = ((texture (_Gradient3D, tmpvar_29).xyz * 2.0) - 1.0);
    g_28 = tmpvar_30;
    highp vec3 g_31;
    highp vec2 tmpvar_32;
    tmpvar_32.y = 0.0;
    tmpvar_32.x = tmpvar_24.y;
    lowp vec3 tmpvar_33;
    tmpvar_33 = ((texture (_Gradient3D, tmpvar_32).xyz * 2.0) - 1.0);
    g_31 = tmpvar_33;
    highp vec3 g_34;
    highp vec2 tmpvar_35;
    tmpvar_35.y = 0.0;
    tmpvar_35.x = tmpvar_24.w;
    lowp vec3 tmpvar_36;
    tmpvar_36 = ((texture (_Gradient3D, tmpvar_35).xyz * 2.0) - 1.0);
    g_34 = tmpvar_36;
    highp vec3 g_37;
    highp vec2 tmpvar_38;
    tmpvar_38.y = 0.0;
    tmpvar_38.x = (tmpvar_24.x + 0.00390625);
    lowp vec3 tmpvar_39;
    tmpvar_39 = ((texture (_Gradient3D, tmpvar_38).xyz * 2.0) - 1.0);
    g_37 = tmpvar_39;
    highp vec3 g_40;
    highp vec2 tmpvar_41;
    tmpvar_41.y = 0.0;
    tmpvar_41.x = (tmpvar_24.z + 0.00390625);
    lowp vec3 tmpvar_42;
    tmpvar_42 = ((texture (_Gradient3D, tmpvar_41).xyz * 2.0) - 1.0);
    g_40 = tmpvar_42;
    highp vec3 g_43;
    highp vec2 tmpvar_44;
    tmpvar_44.y = 0.0;
    tmpvar_44.x = (tmpvar_24.y + 0.00390625);
    lowp vec3 tmpvar_45;
    tmpvar_45 = ((texture (_Gradient3D, tmpvar_44).xyz * 2.0) - 1.0);
    g_43 = tmpvar_45;
    highp vec3 g_46;
    highp vec2 tmpvar_47;
    tmpvar_47.y = 0.0;
    tmpvar_47.x = (tmpvar_24.w + 0.00390625);
    lowp vec3 tmpvar_48;
    tmpvar_48 = ((texture (_Gradient3D, tmpvar_47).xyz * 2.0) - 1.0);
    g_46 = tmpvar_48;
    sum_11 = (sum_11 + (abs(mix (mix (mix (dot (g_25, tmpvar_19), dot (g_28, (tmpvar_19 + vec3(-1.0, 0.0, 0.0))), tmpvar_20.x), mix (dot (g_31, (tmpvar_19 + vec3(0.0, -1.0, 0.0))), dot (g_34, (tmpvar_19 + vec3(-1.0, -1.0, 0.0))), tmpvar_20.x), tmpvar_20.y), mix (mix (dot (g_37, (tmpvar_19 + vec3(0.0, 0.0, -1.0))), dot (g_40, (tmpvar_19 + vec3(-1.0, 0.0, -1.0))), tmpvar_20.x), mix (dot (g_43, (tmpvar_19 + vec3(0.0, -1.0, -1.0))), dot (g_46, (tmpvar_19 + vec3(-1.0, -1.0, -1.0))), tmpvar_20.x), tmpvar_20.y), tmpvar_20.z)) * amp_9));
    freq_10 = (freq_10 * _Lacunarity);
    amp_9 = (amp_9 * _Gain);
    i_8 = (i_8 + 1);
  };
  highp float tmpvar_49;
  tmpvar_49 = (sum_11 * _Distortion);
  mediump float tmpvar_50;
  tmpvar_50 = (_StormThreshold * 2.0);
  s_4 = tmpvar_50;
  highp float sum_51;
  sum_51 = 0.0;
  highp vec3 p_52;
  p_52 = (xlv_TEXCOORD0 * _StormFrequency);
  highp vec3 tmpvar_53;
  tmpvar_53 = (floor(p_52) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_54;
  tmpvar_54 = (fract(abs(tmpvar_53)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_55;
  if ((tmpvar_53.x >= 0.0)) {
    tmpvar_55 = tmpvar_54.x;
  } else {
    tmpvar_55 = -(tmpvar_54.x);
  };
  highp float tmpvar_56;
  if ((tmpvar_53.y >= 0.0)) {
    tmpvar_56 = tmpvar_54.y;
  } else {
    tmpvar_56 = -(tmpvar_54.y);
  };
  highp float tmpvar_57;
  if ((tmpvar_53.z >= 0.0)) {
    tmpvar_57 = tmpvar_54.z;
  } else {
    tmpvar_57 = -(tmpvar_54.z);
  };
  highp vec3 tmpvar_58;
  tmpvar_58.x = tmpvar_55;
  tmpvar_58.y = tmpvar_56;
  tmpvar_58.z = tmpvar_57;
  highp vec3 tmpvar_59;
  tmpvar_59 = (p_52 - floor(p_52));
  p_52 = tmpvar_59;
  highp vec3 tmpvar_60;
  tmpvar_60 = ((tmpvar_59 * tmpvar_59) * (3.0 - (2.0 * tmpvar_59)));
  highp vec3 tmpvar_61;
  tmpvar_61 = (tmpvar_58 / 256.0);
  highp vec4 tmpvar_62;
  lowp vec4 tmpvar_63;
  tmpvar_63 = texture (_PermTable2D, tmpvar_61.xy);
  tmpvar_62 = tmpvar_63;
  highp vec4 tmpvar_64;
  tmpvar_64 = (tmpvar_62 + tmpvar_61.z);
  highp vec3 g_65;
  highp vec2 tmpvar_66;
  tmpvar_66.y = 0.0;
  tmpvar_66.x = tmpvar_64.x;
  lowp vec3 tmpvar_67;
  tmpvar_67 = ((texture (_Gradient3D, tmpvar_66).xyz * 2.0) - 1.0);
  g_65 = tmpvar_67;
  highp vec3 g_68;
  highp vec2 tmpvar_69;
  tmpvar_69.y = 0.0;
  tmpvar_69.x = tmpvar_64.z;
  lowp vec3 tmpvar_70;
  tmpvar_70 = ((texture (_Gradient3D, tmpvar_69).xyz * 2.0) - 1.0);
  g_68 = tmpvar_70;
  highp vec3 g_71;
  highp vec2 tmpvar_72;
  tmpvar_72.y = 0.0;
  tmpvar_72.x = tmpvar_64.y;
  lowp vec3 tmpvar_73;
  tmpvar_73 = ((texture (_Gradient3D, tmpvar_72).xyz * 2.0) - 1.0);
  g_71 = tmpvar_73;
  highp vec3 g_74;
  highp vec2 tmpvar_75;
  tmpvar_75.y = 0.0;
  tmpvar_75.x = tmpvar_64.w;
  lowp vec3 tmpvar_76;
  tmpvar_76 = ((texture (_Gradient3D, tmpvar_75).xyz * 2.0) - 1.0);
  g_74 = tmpvar_76;
  highp vec3 g_77;
  highp vec2 tmpvar_78;
  tmpvar_78.y = 0.0;
  tmpvar_78.x = (tmpvar_64.x + 0.00390625);
  lowp vec3 tmpvar_79;
  tmpvar_79 = ((texture (_Gradient3D, tmpvar_78).xyz * 2.0) - 1.0);
  g_77 = tmpvar_79;
  highp vec3 g_80;
  highp vec2 tmpvar_81;
  tmpvar_81.y = 0.0;
  tmpvar_81.x = (tmpvar_64.z + 0.00390625);
  lowp vec3 tmpvar_82;
  tmpvar_82 = ((texture (_Gradient3D, tmpvar_81).xyz * 2.0) - 1.0);
  g_80 = tmpvar_82;
  highp vec3 g_83;
  highp vec2 tmpvar_84;
  tmpvar_84.y = 0.0;
  tmpvar_84.x = (tmpvar_64.y + 0.00390625);
  lowp vec3 tmpvar_85;
  tmpvar_85 = ((texture (_Gradient3D, tmpvar_84).xyz * 2.0) - 1.0);
  g_83 = tmpvar_85;
  highp vec3 g_86;
  highp vec2 tmpvar_87;
  tmpvar_87.y = 0.0;
  tmpvar_87.x = (tmpvar_64.w + 0.00390625);
  lowp vec3 tmpvar_88;
  tmpvar_88 = ((texture (_Gradient3D, tmpvar_87).xyz * 2.0) - 1.0);
  g_86 = tmpvar_88;
  sum_51 = abs(mix (mix (mix (dot (g_65, tmpvar_59), dot (g_68, (tmpvar_59 + vec3(-1.0, 0.0, 0.0))), tmpvar_60.x), mix (dot (g_71, (tmpvar_59 + vec3(0.0, -1.0, 0.0))), dot (g_74, (tmpvar_59 + vec3(-1.0, -1.0, 0.0))), tmpvar_60.x), tmpvar_60.y), mix (mix (dot (g_77, (tmpvar_59 + vec3(0.0, 0.0, -1.0))), dot (g_80, (tmpvar_59 + vec3(-1.0, 0.0, -1.0))), tmpvar_60.x), mix (dot (g_83, (tmpvar_59 + vec3(0.0, -1.0, -1.0))), dot (g_86, (tmpvar_59 + vec3(-1.0, -1.0, -1.0))), tmpvar_60.x), tmpvar_60.y), tmpvar_60.z));
  highp float tmpvar_89;
  tmpvar_89 = (sum_51 - s_4);
  highp float sum_90;
  sum_90 = 0.0;
  highp vec3 p_91;
  p_91 = ((xlv_TEXCOORD0 + vec3(1600.0, 0.0, 1600.0)) * _StormFrequency);
  highp vec3 tmpvar_92;
  tmpvar_92 = (floor(p_91) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_93;
  tmpvar_93 = (fract(abs(tmpvar_92)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_94;
  if ((tmpvar_92.x >= 0.0)) {
    tmpvar_94 = tmpvar_93.x;
  } else {
    tmpvar_94 = -(tmpvar_93.x);
  };
  highp float tmpvar_95;
  if ((tmpvar_92.y >= 0.0)) {
    tmpvar_95 = tmpvar_93.y;
  } else {
    tmpvar_95 = -(tmpvar_93.y);
  };
  highp float tmpvar_96;
  if ((tmpvar_92.z >= 0.0)) {
    tmpvar_96 = tmpvar_93.z;
  } else {
    tmpvar_96 = -(tmpvar_93.z);
  };
  highp vec3 tmpvar_97;
  tmpvar_97.x = tmpvar_94;
  tmpvar_97.y = tmpvar_95;
  tmpvar_97.z = tmpvar_96;
  highp vec3 tmpvar_98;
  tmpvar_98 = (p_91 - floor(p_91));
  p_91 = tmpvar_98;
  highp vec3 tmpvar_99;
  tmpvar_99 = ((tmpvar_98 * tmpvar_98) * (3.0 - (2.0 * tmpvar_98)));
  highp vec3 tmpvar_100;
  tmpvar_100 = (tmpvar_97 / 256.0);
  highp vec4 tmpvar_101;
  lowp vec4 tmpvar_102;
  tmpvar_102 = texture (_PermTable2D, tmpvar_100.xy);
  tmpvar_101 = tmpvar_102;
  highp vec4 tmpvar_103;
  tmpvar_103 = (tmpvar_101 + tmpvar_100.z);
  highp vec3 g_104;
  highp vec2 tmpvar_105;
  tmpvar_105.y = 0.0;
  tmpvar_105.x = tmpvar_103.x;
  lowp vec3 tmpvar_106;
  tmpvar_106 = ((texture (_Gradient3D, tmpvar_105).xyz * 2.0) - 1.0);
  g_104 = tmpvar_106;
  highp vec3 g_107;
  highp vec2 tmpvar_108;
  tmpvar_108.y = 0.0;
  tmpvar_108.x = tmpvar_103.z;
  lowp vec3 tmpvar_109;
  tmpvar_109 = ((texture (_Gradient3D, tmpvar_108).xyz * 2.0) - 1.0);
  g_107 = tmpvar_109;
  highp vec3 g_110;
  highp vec2 tmpvar_111;
  tmpvar_111.y = 0.0;
  tmpvar_111.x = tmpvar_103.y;
  lowp vec3 tmpvar_112;
  tmpvar_112 = ((texture (_Gradient3D, tmpvar_111).xyz * 2.0) - 1.0);
  g_110 = tmpvar_112;
  highp vec3 g_113;
  highp vec2 tmpvar_114;
  tmpvar_114.y = 0.0;
  tmpvar_114.x = tmpvar_103.w;
  lowp vec3 tmpvar_115;
  tmpvar_115 = ((texture (_Gradient3D, tmpvar_114).xyz * 2.0) - 1.0);
  g_113 = tmpvar_115;
  highp vec3 g_116;
  highp vec2 tmpvar_117;
  tmpvar_117.y = 0.0;
  tmpvar_117.x = (tmpvar_103.x + 0.00390625);
  lowp vec3 tmpvar_118;
  tmpvar_118 = ((texture (_Gradient3D, tmpvar_117).xyz * 2.0) - 1.0);
  g_116 = tmpvar_118;
  highp vec3 g_119;
  highp vec2 tmpvar_120;
  tmpvar_120.y = 0.0;
  tmpvar_120.x = (tmpvar_103.z + 0.00390625);
  lowp vec3 tmpvar_121;
  tmpvar_121 = ((texture (_Gradient3D, tmpvar_120).xyz * 2.0) - 1.0);
  g_119 = tmpvar_121;
  highp vec3 g_122;
  highp vec2 tmpvar_123;
  tmpvar_123.y = 0.0;
  tmpvar_123.x = (tmpvar_103.y + 0.00390625);
  lowp vec3 tmpvar_124;
  tmpvar_124 = ((texture (_Gradient3D, tmpvar_123).xyz * 2.0) - 1.0);
  g_122 = tmpvar_124;
  highp vec3 g_125;
  highp vec2 tmpvar_126;
  tmpvar_126.y = 0.0;
  tmpvar_126.x = (tmpvar_103.w + 0.00390625);
  lowp vec3 tmpvar_127;
  tmpvar_127 = ((texture (_Gradient3D, tmpvar_126).xyz * 2.0) - 1.0);
  g_125 = tmpvar_127;
  sum_90 = abs(mix (mix (mix (dot (g_104, tmpvar_98), dot (g_107, (tmpvar_98 + vec3(-1.0, 0.0, 0.0))), tmpvar_99.x), mix (dot (g_110, (tmpvar_98 + vec3(0.0, -1.0, 0.0))), dot (g_113, (tmpvar_98 + vec3(-1.0, -1.0, 0.0))), tmpvar_99.x), tmpvar_99.y), mix (mix (dot (g_116, (tmpvar_98 + vec3(0.0, 0.0, -1.0))), dot (g_119, (tmpvar_98 + vec3(-1.0, 0.0, -1.0))), tmpvar_99.x), mix (dot (g_122, (tmpvar_98 + vec3(0.0, -1.0, -1.0))), dot (g_125, (tmpvar_98 + vec3(-1.0, -1.0, -1.0))), tmpvar_99.x), tmpvar_99.y), tmpvar_99.z));
  highp float tmpvar_128;
  tmpvar_128 = (sum_90 - s_4);
  highp float sum_129;
  sum_129 = 0.0;
  highp vec3 p_130;
  p_130 = ((xlv_TEXCOORD0 + vec3(3200.0, 0.0, 3200.0)) * _StormFrequency);
  highp vec3 tmpvar_131;
  tmpvar_131 = (floor(p_130) / vec3(256.0, 256.0, 256.0));
  highp vec3 tmpvar_132;
  tmpvar_132 = (fract(abs(tmpvar_131)) * vec3(256.0, 256.0, 256.0));
  highp float tmpvar_133;
  if ((tmpvar_131.x >= 0.0)) {
    tmpvar_133 = tmpvar_132.x;
  } else {
    tmpvar_133 = -(tmpvar_132.x);
  };
  highp float tmpvar_134;
  if ((tmpvar_131.y >= 0.0)) {
    tmpvar_134 = tmpvar_132.y;
  } else {
    tmpvar_134 = -(tmpvar_132.y);
  };
  highp float tmpvar_135;
  if ((tmpvar_131.z >= 0.0)) {
    tmpvar_135 = tmpvar_132.z;
  } else {
    tmpvar_135 = -(tmpvar_132.z);
  };
  highp vec3 tmpvar_136;
  tmpvar_136.x = tmpvar_133;
  tmpvar_136.y = tmpvar_134;
  tmpvar_136.z = tmpvar_135;
  highp vec3 tmpvar_137;
  tmpvar_137 = (p_130 - floor(p_130));
  p_130 = tmpvar_137;
  highp vec3 tmpvar_138;
  tmpvar_138 = ((tmpvar_137 * tmpvar_137) * (3.0 - (2.0 * tmpvar_137)));
  highp vec3 tmpvar_139;
  tmpvar_139 = (tmpvar_136 / 256.0);
  highp vec4 tmpvar_140;
  lowp vec4 tmpvar_141;
  tmpvar_141 = texture (_PermTable2D, tmpvar_139.xy);
  tmpvar_140 = tmpvar_141;
  highp vec4 tmpvar_142;
  tmpvar_142 = (tmpvar_140 + tmpvar_139.z);
  highp vec3 g_143;
  highp vec2 tmpvar_144;
  tmpvar_144.y = 0.0;
  tmpvar_144.x = tmpvar_142.x;
  lowp vec3 tmpvar_145;
  tmpvar_145 = ((texture (_Gradient3D, tmpvar_144).xyz * 2.0) - 1.0);
  g_143 = tmpvar_145;
  highp vec3 g_146;
  highp vec2 tmpvar_147;
  tmpvar_147.y = 0.0;
  tmpvar_147.x = tmpvar_142.z;
  lowp vec3 tmpvar_148;
  tmpvar_148 = ((texture (_Gradient3D, tmpvar_147).xyz * 2.0) - 1.0);
  g_146 = tmpvar_148;
  highp vec3 g_149;
  highp vec2 tmpvar_150;
  tmpvar_150.y = 0.0;
  tmpvar_150.x = tmpvar_142.y;
  lowp vec3 tmpvar_151;
  tmpvar_151 = ((texture (_Gradient3D, tmpvar_150).xyz * 2.0) - 1.0);
  g_149 = tmpvar_151;
  highp vec3 g_152;
  highp vec2 tmpvar_153;
  tmpvar_153.y = 0.0;
  tmpvar_153.x = tmpvar_142.w;
  lowp vec3 tmpvar_154;
  tmpvar_154 = ((texture (_Gradient3D, tmpvar_153).xyz * 2.0) - 1.0);
  g_152 = tmpvar_154;
  highp vec3 g_155;
  highp vec2 tmpvar_156;
  tmpvar_156.y = 0.0;
  tmpvar_156.x = (tmpvar_142.x + 0.00390625);
  lowp vec3 tmpvar_157;
  tmpvar_157 = ((texture (_Gradient3D, tmpvar_156).xyz * 2.0) - 1.0);
  g_155 = tmpvar_157;
  highp vec3 g_158;
  highp vec2 tmpvar_159;
  tmpvar_159.y = 0.0;
  tmpvar_159.x = (tmpvar_142.z + 0.00390625);
  lowp vec3 tmpvar_160;
  tmpvar_160 = ((texture (_Gradient3D, tmpvar_159).xyz * 2.0) - 1.0);
  g_158 = tmpvar_160;
  highp vec3 g_161;
  highp vec2 tmpvar_162;
  tmpvar_162.y = 0.0;
  tmpvar_162.x = (tmpvar_142.y + 0.00390625);
  lowp vec3 tmpvar_163;
  tmpvar_163 = ((texture (_Gradient3D, tmpvar_162).xyz * 2.0) - 1.0);
  g_161 = tmpvar_163;
  highp vec3 g_164;
  highp vec2 tmpvar_165;
  tmpvar_165.y = 0.0;
  tmpvar_165.x = (tmpvar_142.w + 0.00390625);
  lowp vec3 tmpvar_166;
  tmpvar_166 = ((texture (_Gradient3D, tmpvar_165).xyz * 2.0) - 1.0);
  g_164 = tmpvar_166;
  sum_129 = abs(mix (mix (mix (dot (g_143, tmpvar_137), dot (g_146, (tmpvar_137 + vec3(-1.0, 0.0, 0.0))), tmpvar_138.x), mix (dot (g_149, (tmpvar_137 + vec3(0.0, -1.0, 0.0))), dot (g_152, (tmpvar_137 + vec3(-1.0, -1.0, 0.0))), tmpvar_138.x), tmpvar_138.y), mix (mix (dot (g_155, (tmpvar_137 + vec3(0.0, 0.0, -1.0))), dot (g_158, (tmpvar_137 + vec3(-1.0, 0.0, -1.0))), tmpvar_138.x), mix (dot (g_161, (tmpvar_137 + vec3(0.0, -1.0, -1.0))), dot (g_164, (tmpvar_137 + vec3(-1.0, -1.0, -1.0))), tmpvar_138.x), tmpvar_138.y), tmpvar_138.z));
  highp float tmpvar_167;
  tmpvar_167 = (max (0.0, ((tmpvar_89 * tmpvar_128) * (sum_129 - s_4))) * 50.0);
  highp vec3 p_168;
  p_168 = (xlv_TEXCOORD0 * 0.1);
  int i_169;
  highp float sum_170;
  highp float amp_171;
  highp float freq_172;
  freq_172 = _StormFrequency;
  amp_171 = 0.5;
  sum_170 = 0.0;
  i_169 = 0;
  for (int i_169 = 0; i_169 < 4; ) {
    highp vec3 p_173;
    p_173 = (p_168 * freq_172);
    highp vec3 tmpvar_174;
    tmpvar_174 = (floor(p_173) / vec3(256.0, 256.0, 256.0));
    highp vec3 tmpvar_175;
    tmpvar_175 = (fract(abs(tmpvar_174)) * vec3(256.0, 256.0, 256.0));
    highp float tmpvar_176;
    if ((tmpvar_174.x >= 0.0)) {
      tmpvar_176 = tmpvar_175.x;
    } else {
      tmpvar_176 = -(tmpvar_175.x);
    };
    highp float tmpvar_177;
    if ((tmpvar_174.y >= 0.0)) {
      tmpvar_177 = tmpvar_175.y;
    } else {
      tmpvar_177 = -(tmpvar_175.y);
    };
    highp float tmpvar_178;
    if ((tmpvar_174.z >= 0.0)) {
      tmpvar_178 = tmpvar_175.z;
    } else {
      tmpvar_178 = -(tmpvar_175.z);
    };
    highp vec3 tmpvar_179;
    tmpvar_179.x = tmpvar_176;
    tmpvar_179.y = tmpvar_177;
    tmpvar_179.z = tmpvar_178;
    highp vec3 tmpvar_180;
    tmpvar_180 = (p_173 - floor(p_173));
    p_173 = tmpvar_180;
    highp vec3 tmpvar_181;
    tmpvar_181 = ((tmpvar_180 * tmpvar_180) * (3.0 - (2.0 * tmpvar_180)));
    highp vec3 tmpvar_182;
    tmpvar_182 = (tmpvar_179 / 256.0);
    highp vec4 tmpvar_183;
    lowp vec4 tmpvar_184;
    tmpvar_184 = texture (_PermTable2D, tmpvar_182.xy);
    tmpvar_183 = tmpvar_184;
    highp vec4 tmpvar_185;
    tmpvar_185 = (tmpvar_183 + tmpvar_182.z);
    highp vec3 g_186;
    highp vec2 tmpvar_187;
    tmpvar_187.y = 0.0;
    tmpvar_187.x = tmpvar_185.x;
    lowp vec3 tmpvar_188;
    tmpvar_188 = ((texture (_Gradient3D, tmpvar_187).xyz * 2.0) - 1.0);
    g_186 = tmpvar_188;
    highp vec3 g_189;
    highp vec2 tmpvar_190;
    tmpvar_190.y = 0.0;
    tmpvar_190.x = tmpvar_185.z;
    lowp vec3 tmpvar_191;
    tmpvar_191 = ((texture (_Gradient3D, tmpvar_190).xyz * 2.0) - 1.0);
    g_189 = tmpvar_191;
    highp vec3 g_192;
    highp vec2 tmpvar_193;
    tmpvar_193.y = 0.0;
    tmpvar_193.x = tmpvar_185.y;
    lowp vec3 tmpvar_194;
    tmpvar_194 = ((texture (_Gradient3D, tmpvar_193).xyz * 2.0) - 1.0);
    g_192 = tmpvar_194;
    highp vec3 g_195;
    highp vec2 tmpvar_196;
    tmpvar_196.y = 0.0;
    tmpvar_196.x = tmpvar_185.w;
    lowp vec3 tmpvar_197;
    tmpvar_197 = ((texture (_Gradient3D, tmpvar_196).xyz * 2.0) - 1.0);
    g_195 = tmpvar_197;
    highp vec3 g_198;
    highp vec2 tmpvar_199;
    tmpvar_199.y = 0.0;
    tmpvar_199.x = (tmpvar_185.x + 0.00390625);
    lowp vec3 tmpvar_200;
    tmpvar_200 = ((texture (_Gradient3D, tmpvar_199).xyz * 2.0) - 1.0);
    g_198 = tmpvar_200;
    highp vec3 g_201;
    highp vec2 tmpvar_202;
    tmpvar_202.y = 0.0;
    tmpvar_202.x = (tmpvar_185.z + 0.00390625);
    lowp vec3 tmpvar_203;
    tmpvar_203 = ((texture (_Gradient3D, tmpvar_202).xyz * 2.0) - 1.0);
    g_201 = tmpvar_203;
    highp vec3 g_204;
    highp vec2 tmpvar_205;
    tmpvar_205.y = 0.0;
    tmpvar_205.x = (tmpvar_185.y + 0.00390625);
    lowp vec3 tmpvar_206;
    tmpvar_206 = ((texture (_Gradient3D, tmpvar_205).xyz * 2.0) - 1.0);
    g_204 = tmpvar_206;
    highp vec3 g_207;
    highp vec2 tmpvar_208;
    tmpvar_208.y = 0.0;
    tmpvar_208.x = (tmpvar_185.w + 0.00390625);
    lowp vec3 tmpvar_209;
    tmpvar_209 = ((texture (_Gradient3D, tmpvar_208).xyz * 2.0) - 1.0);
    g_207 = tmpvar_209;
    sum_170 = (sum_170 + (mix (mix (mix (dot (g_186, tmpvar_180), dot (g_189, (tmpvar_180 + vec3(-1.0, 0.0, 0.0))), tmpvar_181.x), mix (dot (g_192, (tmpvar_180 + vec3(0.0, -1.0, 0.0))), dot (g_195, (tmpvar_180 + vec3(-1.0, -1.0, 0.0))), tmpvar_181.x), tmpvar_181.y), mix (mix (dot (g_198, (tmpvar_180 + vec3(0.0, 0.0, -1.0))), dot (g_201, (tmpvar_180 + vec3(-1.0, 0.0, -1.0))), tmpvar_181.x), mix (dot (g_204, (tmpvar_180 + vec3(0.0, -1.0, -1.0))), dot (g_207, (tmpvar_180 + vec3(-1.0, -1.0, -1.0))), tmpvar_181.x), tmpvar_181.y), tmpvar_181.z) * amp_171));
    freq_172 = (freq_172 * _Lacunarity);
    amp_171 = (amp_171 * _Gain);
    i_169 = (i_169 + 1);
  };
  highp vec2 tmpvar_210;
  tmpvar_210.y = 0.0;
  tmpvar_210.x = ((((xlv_TEXCOORD0.y + tmpvar_49) + (sum_170 * tmpvar_167)) * 0.5) - 0.5);
  lowp vec3 tmpvar_211;
  tmpvar_211 = texture (_MainTex, tmpvar_210).xyz;
  c_5 = tmpvar_211;
  c_5.x = max (0.05, c_5.x);
  c_5.y = max (0.05, c_5.y);
  c_5.z = max (0.05, c_5.z);
  tmpvar_3 = c_5;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_212;
  c_212.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD1, lightDir_2)) * texture (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_212.w = _PlanetOpacity;
  c_1.xyz = c_212.xyz;
  c_1.w = _PlanetOpacity;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
// Platform opengl had shader errors
//   Keywords { "POINT" }
//   Keywords { "DIRECTIONAL" }
//   Keywords { "SPOT" }
//   Keywords { "POINT_COOKIE" }
//   Keywords { "DIRECTIONAL_COOKIE" }
SubProgram "d3d9 " {
// Stats: 378 math, 47 textures, 10 branches
Keywords { "POINT" }
Vector 0 [_LightColor0]
Float 1 [_PlanetOpacity]
Float 2 [_MainFrequency]
Float 3 [_Lacunarity]
Float 4 [_Gain]
Float 5 [_Distortion]
Float 6 [_Evolution]
Float 7 [_StormFrequency]
Float 8 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c12, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.xz, c6.x
mov r0.y, c9.x
add r1.xyz, v0, r0
mov r0.w, c9.x
mov r1.w, c2.x
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
mul r1.w, r1, c3.x
mul r3.w, r3, c4.x
endloop
add r0.xyz, v0, c11.wyww
mul r0.xyz, r0, c7.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c11.yxxw
add r0.x, r1.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c11.x
add r0.x, r1.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c11.yyxw
add r0.x, r1, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c11.xyxw
add r0.x, r1.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c9.z, c9.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c11.yxyw
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c11.xxyw
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c11.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c11.zyzw
mul r1.xyz, r0, c7.x
mov r4.y, c9.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c10.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c10.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c10.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c11.yyxw
mov r6.x, r2
add r0.x, r2, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c11.xyxw
add r0.x, r2.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c11.yxxw
add r0.x, r2.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c11.x
add r0.x, r2.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c9.z, c9.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c8
mul_pp r1.w, c9.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c11.yxyw
add r3.xyz, r4, c11.xyyw
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c11.xxyw
mov r0.x, r2.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c10.z, c10.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c7.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c10.x
mov r6.y, c9.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c10.z, c10.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c10.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c10.z, c10.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c9.z, c9.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c11.yyxw
add r3.x, r2, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c11.xyxw
add r3.x, r2.z, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c10
add r4.x, r2, -r6
mov r3.y, c9.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c11.x
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c9
mul r1.w, r0.x, c12.x
mul r1.xyz, v0, c12.y
mul r0.w, r0, c5.x
mov r3.w, c7.x
mov r4.w, c12.z
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
mul r3.w, r3, c3.x
mul r4.w, r4, c4.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mov r0.y, c9.x
mad r0.x, r0, c12.z, -c12.z
texld r0.xyz, r0, s2
max_pp r0.xyz, r0, c12.w
mul_pp r2.xyz, r0, c0
mul_pp r1.xyz, r0.w, v2
dp3 r0.x, v3, v3
dp3_pp r0.y, v1, r1
max_pp r0.y, r0, c9.x
texld r0.x, r0.x, s3
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c9.z
mov_pp oC0.w, c1.x
"
}
SubProgram "d3d11 " {
// Stats: 273 math, 47 textures, 2 branches
Keywords { "POINT" }
SetTexture 0 [_PermTable2D] 2D 1
SetTexture 1 [_Gradient3D] 2D 2
SetTexture 2 [_MainTex] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 160
Vector 16 [_LightColor0]
Float 112 [_PlanetOpacity]
Float 116 [_MainFrequency]
Float 124 [_Lacunarity]
Float 128 [_Gain]
Float 132 [_Distortion]
Float 136 [_Evolution]
Float 140 [_StormFrequency]
Float 144 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedofanmbbgnpggfdcenkafjjhmogheheapabaaaaaaemdgaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefceedfaaaaeaaaaaaafbanaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaa
kgikcaaaaaaaaaaaaiaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaai
kcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
bcaabaaaafaaaaaabkiacaaaaaaaaaaaahaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaaaaadgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaagaaaaaaadaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaa
egacbaaaaaaaaaaaagaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaa
agaaaaaadiaaaaakhcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaa
ahaaaaaadhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaa
agaabaaaafaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaa
egacbaaaagaaaaaaegacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaia
ebaaaaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
aiaaaaaaegacbaaaajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaa
ahaaaaaaiganbaaaajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaa
efaaaaajpcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaa
efaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaa
abaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
adaaaaaaagabbaaaahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaa
akaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
aeaaaaaakgalbaaaahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
ahaaaaaaegacbaaaagaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
aiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaiaibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaahaaaaaa
diaaaaaiccaabaaaafaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaiaaaaaa
boaaaaahecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaab
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaa
ebaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaag
hcaabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaal
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahpcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaa
dgaaaaaffcaabaaaadaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaa
adaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaaeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaa
adaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaa
adaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaak
pcaabaaaabaaaaaacgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaak
ocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaialpefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaa
aaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaa
jgahbaaaadaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapocaabaaaabaaaaaa
agajbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaa
abaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaadaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
acaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
ckaabaaaacaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeaakaabaia
ibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaamieeaaaaaaaaaaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaapgipcaaaaaaaaaaaaiaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaa
acaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaa
adaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaadaaaaaa
kgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
adaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaa
aaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
afaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaa
adaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
ajaaaaaaabeaaaaaaaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaa
ebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaag
hcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaa
dgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
agaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaak
pcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaa
acaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeackaabaia
ibaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaagbcaabaaaagaaaaaadkiacaaaaaaaaaaaaiaaaaaadgaaaaafccaabaaa
agaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaaeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaa
ahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaa
egacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaa
aiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaia
ibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaa
aiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaa
ajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaa
egacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaa
egacbaaaajaaaaaaegacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaa
aiaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaaiaaaaaa
kgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaa
aiaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaa
aiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaaagabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
alaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaa
egacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaakgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
aiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
aiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaa
ajaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
bkaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaackaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaagaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaahaaaaaa
diaaaaaiccaabaaaagaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaiaaaaaa
boaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaab
dcaaaaakecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
bkbabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaa
abaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaapgapbaaa
aaaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaamnmmemdnmnmmemdnmnmmemdnaaaaaaaadiaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaabaaaaaaapaaaaahicaabaaa
aaaaaaaapgapbaaaaaaaaaaaagaabaaaacaaaaaadiaaaaahhccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaa
aaaaaaaaahaaaaaadoaaaaab"
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
SubProgram "d3d9 " {
// Stats: 374 math, 46 textures, 10 branches
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Float 1 [_PlanetOpacity]
Float 2 [_MainFrequency]
Float 3 [_Lacunarity]
Float 4 [_Gain]
Float 5 [_Distortion]
Float 6 [_Evolution]
Float 7 [_StormFrequency]
Float 8 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c9, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c12, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
mov r0.xz, c6.x
mov r0.y, c9.x
add r1.xyz, v0, r0
mov r0.w, c9.x
mov r1.w, c2.x
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
mul r1.w, r1, c3.x
mul r3.w, r3, c4.x
endloop
add r0.xyz, v0, c11.wyww
mul r0.xyz, r0, c7.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c11.yxxw
add r0.x, r1.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c11.x
add r0.x, r1.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c11.yyxw
add r0.x, r1, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c11.xyxw
add r0.x, r1.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c9.z, c9.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c11.yxyw
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c11.xxyw
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c11.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c11.zyzw
mul r1.xyz, r0, c7.x
mov r4.y, c9.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c10.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c10.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c10.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c11.yyxw
mov r6.x, r2
add r0.x, r2, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c11.xyxw
add r0.x, r2.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c11.yxxw
add r0.x, r2.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c11.x
add r0.x, r2.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c9.z, c9.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c8
mul_pp r1.w, c9.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c11.yxyw
add r3.xyz, r4, c11.xyyw
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c11.xxyw
mov r0.x, r2.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c10.z, c10.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c7.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c10.x
mov r6.y, c9.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c10.z, c10.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c10.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c10.z, c10.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c9.z, c9.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c11.yyxw
add r3.x, r2, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c11.xyxw
add r3.x, r2.z, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c10
add r4.x, r2, -r6
mov r3.y, c9.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c11.x
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c9
mul r1.w, r0.x, c12.x
mul r1.xyz, v0, c12.y
mul r0.w, r0, c5.x
mov r3.w, c7.x
mov r4.w, c12.z
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
mul r3.w, r3, c3.x
mul r4.w, r4, c4.x
endloop
add r0.x, v0.y, r0.w
mov_pp r1.xyz, v2
mad r0.x, r5.w, r1.w, r0
dp3_pp r0.w, v1, r1
mov r0.y, c9.x
mad r0.x, r0, c12.z, -c12.z
texld r0.xyz, r0, s2
max_pp r0.xyz, r0, c12.w
mul_pp r1.xyz, r0, c0
max_pp r0.x, r0.w, c9
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c9.z
mov_pp oC0.w, c1.x
"
}
SubProgram "d3d11 " {
// Stats: 269 math, 46 textures, 2 branches
Keywords { "DIRECTIONAL" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 96
Vector 16 [_LightColor0]
Float 48 [_PlanetOpacity]
Float 52 [_MainFrequency]
Float 60 [_Lacunarity]
Float 64 [_Gain]
Float 68 [_Distortion]
Float 72 [_Evolution]
Float 76 [_StormFrequency]
Float 80 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedchnehihoaceghoccmfpdohcegeeopeclabaaaaaaiadfaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjadeaaaaeaaaaaaaceanaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
hcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaa
kgikcaaaaaaaaaaaaeaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaai
kcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
bcaabaaaafaaaaaabkiacaaaaaaaaaaaadaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaaaaadgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaagaaaaaaadaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaa
egacbaaaaaaaaaaaagaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaa
agaaaaaadiaaaaakhcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaa
ahaaaaaadhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaa
agaabaaaafaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaa
egacbaaaagaaaaaaegacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaia
ebaaaaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
aiaaaaaaegacbaaaajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaa
ahaaaaaaiganbaaaajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaa
efaaaaajpcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaa
efaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaa
abaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
adaaaaaaagabbaaaahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaa
akaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
aeaaaaaakgalbaaaahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
ahaaaaaaegacbaaaagaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
aiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaiaibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaadaaaaaa
diaaaaaiccaabaaaafaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaeaaaaaa
boaaaaahecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaab
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaa
ebaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaag
hcaabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaal
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaa
dgaaaaaffcaabaaaadaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaa
adaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaaeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaa
adaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaa
adaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaak
pcaabaaaabaaaaaacgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaak
ocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaialpefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaa
aaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaa
jgahbaaaadaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaapocaabaaaabaaaaaa
agajbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaa
abaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaadaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
acaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
ckaabaaaacaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeaakaabaia
ibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaamieeaaaaaaaaaaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaapgipcaaaaaaaaaaaaeaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaa
acaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaa
adaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaaeaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaa
kgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
adaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaa
aaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
afaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaa
adaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
afaaaaaaabeaaaaaaaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaa
ebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaag
hcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaeaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaa
dgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
agaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaak
pcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaa
acaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaafaaaaaaabeaaaaaaaaaaaeackaabaia
ibaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaagbcaabaaaagaaaaaadkiacaaaaaaaaaaaaeaaaaaadgaaaaafccaabaaa
agaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaaeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaa
ahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaa
egacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaa
aiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaia
ibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaa
aiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaa
ajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaa
egacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaa
egacbaaaajaaaaaaegacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaa
aiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaa
kgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaa
aiaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaa
aiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaaagabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
alaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaa
egacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaakgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
aiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaphcaabaaa
aiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaa
ajaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
bkaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaackaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaagaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaadaaaaaa
diaaaaaiccaabaaaagaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaeaaaaaa
boaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaab
dcaaaaakecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaeaaaaaa
bkbabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaa
adaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaamnmmemdn
mnmmemdnmnmmemdnaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaadaaaaaadoaaaaab
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
SubProgram "d3d9 " {
// Stats: 383 math, 48 textures, 10 branches
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Float 1 [_PlanetOpacity]
Float 2 [_MainFrequency]
Float 3 [_Lacunarity]
Float 4 [_Gain]
Float 5 [_Distortion]
Float 6 [_Evolution]
Float 7 [_StormFrequency]
Float 8 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
SetTexture 4 [_LightTextureB0] 2D 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c9, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c12, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
mov r0.xz, c6.x
mov r0.y, c9.x
add r1.xyz, v0, r0
mov r0.w, c9.x
mov r1.w, c2.x
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
mul r1.w, r1, c3.x
mul r3.w, r3, c4.x
endloop
add r0.xyz, v0, c11.wyww
mul r0.xyz, r0, c7.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c11.yxxw
add r0.x, r1.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c11.x
add r0.x, r1.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c11.yyxw
add r0.x, r1, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c11.xyxw
add r0.x, r1.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c9.z, c9.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c11.yxyw
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c11.xxyw
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c11.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c11.zyzw
mul r1.xyz, r0, c7.x
mov r4.y, c9.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c10.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c10.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c10.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c11.yyxw
mov r6.x, r2
add r0.x, r2, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c11.xyxw
add r0.x, r2.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c11.yxxw
add r0.x, r2.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c11.x
add r0.x, r2.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c9.z, c9.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c8
mul_pp r1.w, c9.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c11.yxyw
add r3.xyz, r4, c11.xyyw
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c11.xxyw
mov r0.x, r2.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c10.z, c10.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c7.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c10.x
mov r6.y, c9.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c10.z, c10.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c10.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c10.z, c10.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c9.z, c9.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c11.yyxw
add r3.x, r2, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c11.xyxw
add r3.x, r2.z, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c10
add r4.x, r2, -r6
mov r3.y, c9.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c11.x
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c9
mul r1.w, r0.x, c12.x
mul r1.xyz, v0, c12.y
mul r0.w, r0, c5.x
mov r3.w, c7.x
mov r4.w, c12.z
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
mul r3.w, r3, c3.x
mul r4.w, r4, c4.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
mov r0.y, c9.x
mad r0.x, r0, c12.z, -c12.z
texld r1.xyz, r0, s2
max_pp r1.xyz, r1, c12.w
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, v2
dp3_pp r0.y, v1, r0
dp3 r0.x, v3, v3
mul_pp r2.xyz, r1, c0
rcp r0.w, v3.w
mad r1.xy, v3, r0.w, c12.z
texld r0.x, r0.x, s4
texld r0.w, r1, s3
cmp r0.z, -v3, c9.x, c9.y
mul_pp r0.z, r0, r0.w
mul_pp r0.z, r0, r0.x
max_pp r0.x, r0.y, c9
mul_pp r0.x, r0, r0.z
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c9.z
mov_pp oC0.w, c1.x
"
}
SubProgram "d3d11 " {
// Stats: 280 math, 48 textures, 2 branches
Keywords { "SPOT" }
SetTexture 0 [_PermTable2D] 2D 2
SetTexture 1 [_Gradient3D] 2D 3
SetTexture 2 [_MainTex] 2D 4
SetTexture 3 [_LightTexture0] 2D 0
SetTexture 4 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 160
Vector 16 [_LightColor0]
Float 112 [_PlanetOpacity]
Float 116 [_MainFrequency]
Float 124 [_Lacunarity]
Float 128 [_Gain]
Float 132 [_Distortion]
Float 136 [_Evolution]
Float 140 [_StormFrequency]
Float 144 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcklmbaoiihdoglcedahpfnddaeldbpiiabaaaaaafmdhaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfedgaaaaeaaaaaaajfanaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadpcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaakgikcaaa
aaaaaaaaaiaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaikcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaa
afaaaaaabkiacaaaaaaaaaaaahaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaaaaadgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaa
agaaaaaaadaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaaegacbaaa
aaaaaaaaagaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaa
diaaaaakhcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaia
ebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaa
dhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaia
ebaaaaaaahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaaagaabaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
agaaaaaaegacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaiaebaaaaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaa
egacbaaaajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaa
iganbaaaajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaaefaaaaaj
pcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaakhcaabaaa
ajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
ecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaaefaaaaaj
pcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaa
ajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
bcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaa
aaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaaaaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaa
agabbaaaahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaa
acaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaa
kgalbaaaahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaa
ajaaaaaaaaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaa
egacbaaaagaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaa
akaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
aiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaiaibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaafaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaafaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaiaaaaaaboaaaaah
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaai
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaebaaaaaf
hcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaaghcaabaaa
abaaaaaaegacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaalhcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaahpcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaadgaaaaaf
fcaabaaaadaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaeaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
adaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
afaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaaadaaaaaa
egacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaia
ebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakpcaabaaa
abaaaaaacgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaa
adaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaialp
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaai
ccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
aaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaajgahbaaa
adaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapocaabaaaabaaaaaaagajbaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
adaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaia
ebaaaaaaacaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
acaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeaakaabaiaibaaaaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaamiee
aaaaaaaaaaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
diaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaa
dhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaa
adaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaak
hcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
afaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
afaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
abeaaaaaaaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaebaaaaaf
hcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaa
aeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaa
adaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaiaebaaaaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
dcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaf
fcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
afaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakpcaabaaa
adaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaai
icaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaacaaaaaa
akaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeackaabaiaibaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaaabaaaaaa
egbcbaaaabaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaadgaaaaai
kcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
bcaabaaaagaaaaaadkiacaaaaaaaaaaaaiaaaaaadgaaaaafccaabaaaagaaaaaa
abeaaaaaaaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaaahaaaaaa
egacbaaaabaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaa
ahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaa
aiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaa
agaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaa
egacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaia
ebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ajaaaaaaegacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaaiaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaa
aiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaa
efaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaa
efaaaaajpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
aeaaaaaaagabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
afaaaaaakgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaaogakbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
aiaaaaaaegacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
ckaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaai
bcaabaaaagaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaagaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaiaaaaaaboaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabdcaaaaak
ecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabkbabaaa
abaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadeaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdn
mnmmemdnmnmmemdnaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaadbaaaaahicaabaaa
aaaaaaaaabeaaaaaaaaaaaaackbabaaaaeaaaaaaabaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaaacaaaaaaegbabaaa
aeaaaaaapgbpbaaaaeaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaa
egaabaaaacaaaaaaeghobaaaadaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkaabaaaacaaaaaabaaaaaahicaabaaaabaaaaaa
egbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaapgapbaaa
abaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaabaaaaaahbcaabaaaabaaaaaaegbcbaaa
acaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaaabaaaaaapgapbaaa
aaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaadoaaaaab"
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
SubProgram "d3d9 " {
// Stats: 379 math, 48 textures, 10 branches
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_PlanetOpacity]
Float 2 [_MainFrequency]
Float 3 [_Lacunarity]
Float 4 [_Gain]
Float 5 [_Distortion]
Float 6 [_Evolution]
Float 7 [_StormFrequency]
Float 8 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_LightTextureB0] 2D 3
SetTexture 4 [_LightTexture0] CUBE 4
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_cube s4
def c9, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c12, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
mov r0.xz, c6.x
mov r0.y, c9.x
add r1.xyz, v0, r0
mov r0.w, c9.x
mov r1.w, c2.x
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
mul r1.w, r1, c3.x
mul r3.w, r3, c4.x
endloop
add r0.xyz, v0, c11.wyww
mul r0.xyz, r0, c7.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c11.yxxw
add r0.x, r1.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c11.x
add r0.x, r1.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c11.yyxw
add r0.x, r1, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c11.xyxw
add r0.x, r1.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c9.z, c9.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c11.yxyw
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c11.xxyw
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c11.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c11.zyzw
mul r1.xyz, r0, c7.x
mov r4.y, c9.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c10.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c10.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c10.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c11.yyxw
mov r6.x, r2
add r0.x, r2, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c11.xyxw
add r0.x, r2.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c11.yxxw
add r0.x, r2.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c11.x
add r0.x, r2.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c9.z, c9.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c8
mul_pp r1.w, c9.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c11.yxyw
add r3.xyz, r4, c11.xyyw
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c11.xxyw
mov r0.x, r2.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c10.z, c10.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c7.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c10.x
mov r6.y, c9.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c10.z, c10.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c10.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c10.z, c10.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c9.z, c9.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c11.yyxw
add r3.x, r2, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c11.xyxw
add r3.x, r2.z, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c10
add r4.x, r2, -r6
mov r3.y, c9.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c11.x
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c9
mul r1.w, r0.x, c12.x
mul r1.xyz, v0, c12.y
mul r0.w, r0, c5.x
mov r3.w, c7.x
mov r4.w, c12.z
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
mul r3.w, r3, c3.x
mul r4.w, r4, c4.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
dp3_pp r0.w, v2, v2
rsq_pp r0.w, r0.w
mul_pp r2.xyz, r0.w, v2
mad r0.x, r0, c12.z, -c12.z
mov r0.y, c9.x
texld r0.xyz, r0, s2
max_pp r0.xyz, r0, c12.w
mul_pp r1.xyz, r0, c0
dp3_pp r0.y, v1, r2
dp3 r0.x, v3, v3
max_pp r0.y, r0, c9.x
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul_pp r0.x, r0.y, r0
mul_pp r0.xyz, r0.x, r1
mul_pp oC0.xyz, r0, c9.z
mov_pp oC0.w, c1.x
"
}
SubProgram "d3d11 " {
// Stats: 275 math, 48 textures, 2 branches
Keywords { "POINT_COOKIE" }
SetTexture 0 [_PermTable2D] 2D 2
SetTexture 1 [_Gradient3D] 2D 3
SetTexture 2 [_MainTex] 2D 4
SetTexture 3 [_LightTextureB0] 2D 1
SetTexture 4 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 160
Vector 16 [_LightColor0]
Float 112 [_PlanetOpacity]
Float 116 [_MainFrequency]
Float 124 [_Lacunarity]
Float 128 [_Gain]
Float 132 [_Distortion]
Float 136 [_Evolution]
Float 140 [_StormFrequency]
Float 144 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedihkiohklfkpclidhjdaaejjcncheojneabaaaaaamedgaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefclmdfaaaaeaaaaaaagpanaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafkaaaaadaagabaaaaeaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafidaaaae
aahabaaaaeaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaadhcbabaaaaeaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaakgikcaaa
aaaaaaaaaiaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaaikcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaa
afaaaaaabkiacaaaaaaaaaaaahaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaaaaadgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaaaaa
aaaaaaaadaaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaa
agaaaaaaadaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaaegacbaaa
aaaaaaaaagaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaaagaaaaaa
diaaaaakhcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaia
ebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaa
dhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaia
ebaaaaaaahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaaagaabaaa
afaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
agaaaaaaegacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaiaebaaaaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaa
egacbaaaajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaa
iganbaaaajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaaefaaaaaj
pcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaakhcaabaaa
ajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
ecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaaefaaaaaj
pcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaa
ajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
bcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaa
aaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaaaaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaa
agabbaaaahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaa
acaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaa
kgalbaaaahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaa
ajaaaaaaaaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaa
egacbaaaagaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaa
akaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaa
aiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaiaibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaadiaaaaai
bcaabaaaafaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaafaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaiaaaaaaboaaaaah
ecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaai
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaebaaaaaf
hcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaaghcaabaaa
abaaaaaaegacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaalhcaabaaa
aaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaiaebaaaaaa
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaahpcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaadgaaaaaf
fcaabaaaadaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaeaaaaaa
egacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
aeaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
adaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaadkaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaaakaabaaa
acaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
afaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaaadaaaaaa
egacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaaakaabaia
ebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaa
acaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaa
bkaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakpcaabaaa
abaaaaaacgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaa
adaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaialp
efaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaai
ccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaa
aaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaajgahbaaa
adaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaapocaabaaaabaaaaaaagajbaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaaabaaaaaa
egacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaa
akaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaaakaabaaa
aaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
adaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaadkaabaia
ebaaaaaaacaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaackaabaaa
acaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeaakaabaiaibaaaaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaamiee
aaaaaaaaaaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaa
diaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaa
dhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaa
aaaaaaaaaiaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaa
adaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaak
hcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
afaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
afaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
ecaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaa
aaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaaaaaaaaaa
dcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaa
abeaaaaaaaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaadiaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaebaaaaaf
hcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaa
aeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaa
adaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaa
aeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaa
abaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaiaebaaaaaa
acaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
dcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaaj
pcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaa
aaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaf
fcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
afaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaa
acaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
bkaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakpcaabaaa
adaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaa
efaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaai
icaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaacaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaa
abaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaacaaaaaa
akaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaackaabaaa
acaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaaaaaaaaaa
akiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeackaabaiaibaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaaabaaaaaa
egbcbaaaabaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaadgaaaaai
kcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
bcaabaaaagaaaaaadkiacaaaaaaaaaaaaiaaaaaadgaaaaafccaabaaaagaaaaaa
abeaaaaaaaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaaaaaaaaaa
abeaaaaaaeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaaahaaaaaa
egacbaaaabaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaa
ahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaa
aiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaa
agaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaa
egacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaia
ebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ajaaaaaaegacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaaiaaaaaa
eghobaaaaaaaaaaaaagabaaaacaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaa
aiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaa
efaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaa
efaaaaajpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
aeaaaaaaagabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
afaaaaaakgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaaogakbaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
aiaaaaaaegacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
ckaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaajccaabaaa
aaaaaaaadkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaai
bcaabaaaagaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaahaaaaaadiaaaaai
ccaabaaaagaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaiaaaaaaboaaaaah
ecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabdcaaaaak
ecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaabkbabaaa
abaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
efaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaaaagabaaa
aeaaaaaadeaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaamnmmemdn
mnmmemdnmnmmemdnaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaadaaaaaa
egbcbaaaadaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hcaabaaaabaaaaaapgapbaaaaaaaaaaaegbcbaaaadaaaaaabaaaaaahicaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegbcbaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaa
pgapbaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
adaaaaaaegbcbaaaaeaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaadaaaaaabaaaaaahbcaabaaa
abaaaaaaegbcbaaaacaaaaaaegacbaaaabaaaaaadeaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaaapaaaaahicaabaaaaaaaaaaaagaabaaa
abaaaaaapgapbaaaaaaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
doaaaaab"
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
SubProgram "d3d9 " {
// Stats: 375 math, 47 textures, 10 branches
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Float 1 [_PlanetOpacity]
Float 2 [_MainFrequency]
Float 3 [_Lacunarity]
Float 4 [_Gain]
Float 5 [_Distortion]
Float 6 [_Evolution]
Float 7 [_StormFrequency]
Float 8 [_StormThreshold]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_LightTexture0] 2D 3
"ps_3_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 1.00000000, 2.00000000, 3.00000000
defi i0, 6, 0, 1, 0
def c10, 0.00390625, 256.00000000, 2.00000000, -1.00000000
def c11, -1.00000000, 0.00000000, 1600.00000000, 3200.00000000
def c12, 50.00000000, 0.10000000, 0.50000000, 0.04998779
defi i1, 4, 0, 1, 0
dcl_texcoord0 v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
mov r0.xz, c6.x
mov r0.y, c9.x
add r1.xyz, v0, r0
mov r0.w, c9.x
mov r1.w, c2.x
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
mul r1.w, r1, c3.x
mul r3.w, r3, c4.x
endloop
add r0.xyz, v0, c11.wyww
mul r0.xyz, r0, c7.x
frc r2.xyz, r0
add r0.xyz, -r2, r0
mul r1.xyz, r0, c10.x
abs r1.xyz, r1
frc r1.xyz, r1
mul r1.xyz, r1, c10.y
cmp r0.xyz, r0, r1, -r1
mul r0.xyz, r0, c10.x
texld r1, r0, s0
add r1, r1, r0.z
add r3.xyz, r2, c11.yxxw
add r0.x, r1.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.w, r0, r3
add r3.xyz, r2, c11.x
add r0.x, r1.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r3.w, r0.x, -r2
add r3.xyz, r2, c11.yyxw
add r0.x, r1, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r4.x, r0, r3
add r3.xyz, r2, c11.xyxw
add r0.x, r1.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mul r0.xyz, r2, r2
mad r3.xyz, -r2, c9.z, c9.w
mul r3.xyz, r0, r3
mad r4.w, r3.x, r4.y, r4.x
mad r0.x, r3, r3.w, r2.w
add r2.w, r0.x, -r4
add r4.xyz, r2, c11.yxyw
mov r0.x, r1.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.y, r0, r4
mov r0.x, r1.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
add r4.xyz, r2, c11.xxyw
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r4
add r4.xyz, r2, c11.xyyw
mad r1.w, r3.y, r2, r4
add r0.x, r0, -r1.y
mad r2.w, r3.x, r0.x, r1.y
mov r0.x, r1.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.w, r0, r4
mov r4.x, r1
add r0.xyz, v0, c11.zyzw
mul r1.xyz, r0, c7.x
mov r4.y, c9.x
texld r0.xyz, r4, s1
frc r4.xyz, r1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.x, r2, r0
add r1.xyz, -r4, r1
add r2.y, r3.w, -r2.x
mad r2.x, r3, r2.y, r2
add r2.y, r2.w, -r2.x
mul r0.xyz, r1, c10.x
abs r0.xyz, r0
frc r0.xyz, r0
mul r0.xyz, r0, c10.y
cmp r0.xyz, r1, r0, -r0
mad r2.x, r3.y, r2.y, r2
add r1.x, r1.w, -r2
mad r2.x, r3.z, r1, r2
mul r0.xyz, r0, c10.x
texld r1, r0, s0
abs r3.x, r2
add r2, r1, r0.z
add r1.xyz, r4, c11.yyxw
mov r6.x, r2
add r0.x, r2, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r1.w, r0, r1
add r1.xyz, r4, c11.xyxw
add r0.x, r2.z, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.y, r0.x, -r1.w
add r1.xyz, r4, c11.yxxw
add r0.x, r2.y, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r3.z, r0, r1
add r1.xyz, r4, c11.x
add r0.x, r2.w, c10
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r3.w, r0.x, -r3.z
mul r0.xyz, r4, r4
mad r1.xyz, -r4, c9.z, c9.w
mul r5.xyz, r0, r1
mad r0.z, r5.x, r3.y, r1.w
mad r0.y, r5.x, r3.w, r3.z
add r0.y, r0, -r0.z
mad r5.w, r5.y, r0.y, r0.z
mov_pp r0.x, c8
mul_pp r1.w, c9.z, r0.x
add r3.w, -r1, r3.x
add r1.xyz, r4, c11.yxyw
add r3.xyz, r4, c11.xyyw
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r2.y, r0, r1
add r1.xyz, r4, c11.xxyw
mov r0.x, r2.w
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r1
add r1.x, r0, -r2.y
mad r2.w, r5.x, r1.x, r2.y
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r1.xyz, r0, c10.z, c10.w
dp3 r4.w, r1, r3
mul r0.xyz, v0, c7.x
frc r1.xyz, r0
add r2.xyz, -r1, r0
mul r3.xyz, r2, c10.x
mov r6.y, c9.x
texld r0.xyz, r6, s1
mad r0.xyz, r0, c10.z, c10.w
abs r3.xyz, r3
frc r3.xyz, r3
dp3 r4.x, r4, r0
mul r0.xyz, r3, c10.y
add r3.x, r4.w, -r4
mad r3.x, r5, r3, r4
add r3.y, r2.w, -r3.x
mad r4.w, r5.y, r3.y, r3.x
cmp r0.xyz, r2, r0, -r0
mul r0.xyz, r0, c10.x
texld r2, r0, s0
add r2, r2, r0.z
add r5.x, r5.w, -r4.w
add r3.xyz, r1, c11.yxyw
mov r0.x, r2
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r4.xyz, r0, c10.z, c10.w
dp3 r4.x, r1, r4
mov r0.x, r2.y
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r5.w, r0, r3
add r3.xyz, r1, c11.xxyw
mov r0.y, c9.x
mov r0.x, r2.w
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r6.x, r0, -r5.w
add r3.xyz, r1, c11.xyyw
mov r0.x, r2.z
mov r0.y, c9.x
texld r0.xyz, r0, s1
mad r0.xyz, r0, c10.z, c10.w
dp3 r0.x, r0, r3
add r4.y, r0.x, -r4.x
mad r3.xyz, -r1, c9.z, c9.w
mul r0.xyz, r1, r1
mul r0.xyz, r0, r3
mad r5.y, r0.x, r4, r4.x
mad r3.x, r0, r6, r5.w
add r5.w, r3.x, -r5.y
add r4.xyz, r1, c11.yyxw
add r3.x, r2, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r6.x, r3, r4
add r4.xyz, r1, c11.xyxw
add r3.x, r2.z, c10
mov r3.y, c9.x
texld r3.xyz, r3, s1
mad r3.xyz, r3, c10.z, c10.w
dp3 r2.x, r3, r4
add r3.x, r2.y, c10
add r4.x, r2, -r6
mov r3.y, c9.x
texld r2.xyz, r3, s1
add r3.xyz, r1, c11.yxxw
mad r2.xyz, r2, c10.z, c10.w
dp3 r3.x, r2, r3
add r1.xyz, r1, c11.x
mov r2.y, c9.x
add r2.x, r2.w, c10
texld r2.xyz, r2, s1
mad r2.xyz, r2, c10.z, c10.w
dp3 r1.x, r2, r1
mad r1.y, r0.x, r4.x, r6.x
add r1.x, r1, -r3
mad r0.x, r0, r1, r3
mad r1.x, r0.y, r5.w, r5.y
add r0.x, r0, -r1.y
mad r0.x, r0.y, r0, r1.y
mad r0.y, r5.z, r5.x, r4.w
add r0.x, r0, -r1
mad r0.x, r0.z, r0, r1
abs r0.y, r0
abs r0.x, r0
add r0.x, r0, -r1.w
add r0.y, -r1.w, r0
mul r0.x, r0, r0.y
mul r0.x, r0, r3.w
max r0.x, r0, c9
mul r1.w, r0.x, c12.x
mul r1.xyz, v0, c12.y
mul r0.w, r0, c5.x
mov r3.w, c7.x
mov r4.w, c12.z
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
mul r3.w, r3, c3.x
mul r4.w, r4, c4.x
endloop
add r0.x, v0.y, r0.w
mad r0.x, r5.w, r1.w, r0
mov r0.y, c9.x
mad r0.x, r0, c12.z, -c12.z
texld r0.xyz, r0, s2
max_pp r0.xyz, r0, c12.w
mul_pp r2.xyz, r0, c0
mov_pp r1.xyz, v2
dp3_pp r0.x, v1, r1
texld r0.w, v3, s3
max_pp r0.x, r0, c9
mul_pp r0.x, r0, r0.w
mul_pp r0.xyz, r0.x, r2
mul_pp oC0.xyz, r0, c9.z
mov_pp oC0.w, c1.x
"
}
SubProgram "d3d11 " {
// Stats: 269 math, 47 textures, 2 branches
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_PermTable2D] 2D 1
SetTexture 1 [_Gradient3D] 2D 2
SetTexture 2 [_MainTex] 2D 3
SetTexture 3 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 160
Vector 16 [_LightColor0]
Float 112 [_PlanetOpacity]
Float 116 [_MainFrequency]
Float 124 [_Lacunarity]
Float 128 [_Gain]
Float 132 [_Distortion]
Float 136 [_Evolution]
Float 140 [_StormFrequency]
Float 144 [_StormThreshold]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmeapobknecolbbicfapfbhjhcnkaicjdabaaaaaaoedfaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcnmdeaaaaeaaaaaaadhanaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacamaaaaaadgaaaaagfcaabaaaaaaaaaaa
kgikcaaaaaaaaaaaaiaaaaaadgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaadgaaaaai
kcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
bcaabaaaafaaaaaabkiacaaaaaaaaaaaahaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaaaaadgaaaaaigcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaafaaaaaackaabaaaafaaaaaa
abeaaaaaagaaaaaaadaaaeaddkaabaaaafaaaaaadiaaaaahhcaabaaaagaaaaaa
egacbaaaaaaaaaaaagaabaaaafaaaaaaebaaaaafhcaabaaaagaaaaaaegacbaaa
agaaaaaadiaaaaakhcaabaaaahaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaa
ahaaaaaadhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaa
egacbaiaebaaaaaaahaaaaaadcaaaaakhcaabaaaagaaaaaaegacbaaaaaaaaaaa
agaabaaaafaaaaaaegacbaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaa
egacbaaaagaaaaaaegacbaaaagaaaaaadcaaaabahcaabaaaajaaaaaaegacbaia
ebaaaaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaa
aiaaaaaaegacbaaaajaaaaaaefaaaaajpcaabaaaajaaaaaaegaabaaaahaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaa
ahaaaaaaiganbaaaajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaa
efaaaaajpcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaajaaaaaaegacbaaaagaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaa
abaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaaahaaaaaa
efaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaak
hcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaa
abaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
adaaaaaaagabbaaaahaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaakaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaa
akaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
aeaaaaaakgalbaaaahaaaaaaefaaaaajpcaabaaaahaaaaaaegaabaaaaeaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaahaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
ahaaaaaaegacbaaaagaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
aiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaakicaabaaa
aaaaaaaaakaabaiaibaaaaaaabaaaaaabkaabaaaafaaaaaadkaabaaaaaaaaaaa
diaaaaaibcaabaaaafaaaaaaakaabaaaafaaaaaadkiacaaaaaaaaaaaahaaaaaa
diaaaaaiccaabaaaafaaaaaabkaabaaaafaaaaaaakiacaaaaaaaaaaaaiaaaaaa
boaaaaahecaabaaaafaaaaaackaabaaaafaaaaaaabeaaaaaabaaaaaabgaaaaab
diaaaaaihcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaa
ebaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaabkaaaaag
hcaabaaaabaaaaaaegacbaiaibaaaaaaabaaaaaadhaaaaakhcaabaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaal
hcaabaaaaaaaaaaaegbcbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaia
ebaaaaaaaaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
efaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahpcaabaaaabaaaaaakgakbaaaabaaaaaaiganbaaaadaaaaaa
dgaaaaaffcaabaaaadaaaaaaagabbaaaabaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
egaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
aeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaa
egacbaaaaeaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaaaaaaaaibcaabaaaadaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaaacaaaaaa
akaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaakhcaabaaa
adaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaaeaaaaaakgalbaaaabaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahccaabaaa
adaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaaaaaaaaaiccaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaa
adaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajicaabaaa
acaaaaaabkaabaaaacaaaaaaakaabaaaadaaaaaadkaabaaaacaaaaaaaaaaaaak
pcaabaaaabaaaaaacgahbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaadaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaafgahbaaaabaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaadaaaaaaaaaaaaak
ocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaialpefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahccaabaaaadaaaaaaegacbaaaaeaaaaaajgahbaaaadaaaaaa
aaaaaaaiccaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaabkaabaaaadaaaaaa
dcaaaaajbcaabaaaadaaaaaaakaabaaaacaaaaaabkaabaaaadaaaaaaakaabaaa
adaaaaaaaaaaaaakocaabaaaadaaaaaaagajbaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaialpdgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaa
aeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaaeaaaaaa
jgahbaaaadaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaapocaabaaaabaaaaaa
agajbaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaialpbaaaaaahbcaabaaaaaaaaaaajgahbaaa
abaaaaaaegacbaaaaaaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaiaebaaaaaa
abaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaacaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaaaaaaaaaakaabaia
ebaaaaaaadaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaa
acaaaaaaakaabaaaaaaaaaaaakaabaaaadaaaaaaaaaaaaaibcaabaaaaaaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
ckaabaaaacaaaaaaakaabaaaaaaaaaaadkaabaaaacaaaaaadcaaaaambcaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeaakaabaia
ibaaaaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaamieeaaaaaaaaaaaamieeaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaa
abaaaaaapgipcaaaaaaaaaaaaiaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaa
acaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaa
adaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaadcaaaaalhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgipcaaaaaaaaaaaaiaaaaaaegacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaaeaaaaaaefaaaaajpcaabaaaaeaaaaaaegaabaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaadaaaaaa
kgakbaaaadaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
adaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahccaabaaaaaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaa
aaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaaeaaaaaaegacbaaa
afaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaaakaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaa
adaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
ckaabaaaaaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
ckaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaabkaabaaaacaaaaaackaabaaa
aaaaaaaabkaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaaegacbaaa
agaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaafaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaabaaaaaackaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
dcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
efaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaacaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaackaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajecaabaaaaaaaaaaabkaabaaaacaaaaaaakaabaaaabaaaaaackaabaaa
aaaaaaaaaaaaaaaiecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaackaabaaa
aaaaaaaadcaaaaajccaabaaaaaaaaaaackaabaaaacaaaaaackaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaamccaabaaaaaaaaaaaakiacaiaebaaaaaaaaaaaaaa
ajaaaaaaabeaaaaaaaaaaaeabkaabaiaibaaaaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaeiefaaaaaaaaaaaaeiefaaaaaaaa
diaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaa
ebaaaaafhcaabaaaacaaaaaaegacbaaaacaaaaaadiaaaaakhcaabaaaadaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaabkaaaaag
hcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaadhaaaaakhcaabaaaadaaaaaa
egacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaiaebaaaaaaadaaaaaadcaaaaal
hcaabaaaabaaaaaaegacbaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaaa
abaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaa
efaaaaajpcaabaaaaeaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
abaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaaiganbaaaaeaaaaaa
dgaaaaaffcaabaaaaeaaaaaaagabbaaaadaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaaaaaaaa
egacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaagaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
agaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaefaaaaajpcaabaaa
afaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
acaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaa
abaaaaaackaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajecaabaaa
aaaaaaaabkaabaaaacaaaaaadkaabaaaabaaaaaackaabaaaaaaaaaaaaaaaaaak
pcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
efaaaaajpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaefaaaaajpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaefaaaaajpcaabaaaafaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaadaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaa
adaaaaaaegacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
acaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaacaaaaaa
akaabaaaabaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaia
ebaaaaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaa
acaaaaaaakaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaa
ckaabaiaebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajecaabaaaaaaaaaaa
ckaabaaaacaaaaaaakaabaaaabaaaaaackaabaaaaaaaaaaadcaaaaamecaabaaa
aaaaaaaaakiacaiaebaaaaaaaaaaaaaaajaaaaaaabeaaaaaaaaaaaeackaabaia
ibaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaeiecdiaaaaakhcaabaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaamnmmmmdnmnmmmmdnmnmmmmdnaaaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaagbcaabaaaagaaaaaadkiacaaaaaaaaaaaaiaaaaaadgaaaaafccaabaaa
agaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaahicaabaaaabaaaaaackaabaaa
aaaaaaaaabeaaaaaaeaaaaaaadaaaeaddkaabaaaabaaaaaadiaaaaahhcaabaaa
ahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaaahaaaaaa
egacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaa
aiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaia
ibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaa
aiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaa
ajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaa
egacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaa
egacbaaaajaaaaaaegacbaaaakaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaa
aiaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaaaaaaaahpcaabaaaaiaaaaaa
kgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaa
aiaaaaaaefaaaaajpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaa
dkaabaaaabaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaa
aiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaefaaaaajpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaaagabbaaaaiaaaaaaefaaaaajpcaabaaaalaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaefaaaaajpcaabaaaalaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
alaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaa
egacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaakgalbaaaaiaaaaaaefaaaaajpcaabaaaaiaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
aiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaefaaaaajpcaabaaaaiaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaadcaaaaaphcaabaaa
aiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaa
ajaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
bkaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaackaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadcaaaaaj
ccaabaaaaaaaaaaadkaabaaaabaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaa
diaaaaaibcaabaaaagaaaaaaakaabaaaagaaaaaadkiacaaaaaaaaaaaahaaaaaa
diaaaaaiccaabaaaagaaaaaabkaabaaaagaaaaaaakiacaaaaaaaaaaaaiaaaaaa
boaaaaahecaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaab
dcaaaaakecaabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaaiaaaaaa
bkbabaaaabaaaaaadcaaaaajbcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaa
aaaaaaaackaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaacaaaaaa
aagabaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
adaaaaaaaagabaaaaaaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egbcbaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
mnmmemdnmnmmemdnmnmmemdnaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaabaaaaaaapaaaaahicaabaaaaaaaaaaapgapbaaa
aaaaaaaapgapbaaaabaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaaakiacaaaaaaaaaaaahaaaaaa
doaaaaab"
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