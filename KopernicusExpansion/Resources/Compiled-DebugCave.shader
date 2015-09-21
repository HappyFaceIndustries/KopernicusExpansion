// Compiled shader for all platforms, uncompressed size: 185.6KB

Shader "Debug/Cave" {
Properties {
 _TintColor ("Color", Color) = (1,1,1,1)
}
SubShader { 
 LOD 2000
 Tags { "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 18 avg math (5..43)
 //    d3d11_9x : 18 avg math (5..43)
 //        d3d9 : 23 avg math (5..56)
 //      opengl : 23 avg math (5..56)
 // Stats for Fragment shader:
 //       d3d11 : 4 avg math (3..6), 0 avg texture (0..1)
 //    d3d11_9x : 4 avg math (3..6), 0 avg texture (0..1)
 //        d3d9 : 6 avg math (5..9), 0 avg texture (0..1)
 //      opengl : 6 avg math (5..8), 0 avg texture (0..1)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
// Stats: 26 math
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
"!!ARBvp1.0
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[16].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[14];
DP4 R3.y, R1, c[13];
DP4 R3.x, R1, c[12];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[15];
ADD R2.xyz, R2, R3;
ADD result.texcoord[1].xyz, R2, R1;
MOV result.texcoord[0].z, R2.w;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 26 math
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
"vs_2_0
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c15.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c16.x
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c13
dp4 r3.y, r1, c12
dp4 r3.x, r1, c11
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c14
add r2.xyz, r2, r3
add oT1.xyz, r2, r1
mov oT0.z, r2.w
mov oT0.y, r3.w
mov oT0.x, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 19 math
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
eefiecedfnekalpcaicjoaolgemdpflogihmgbnlabaaaaaajeaeaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcciadaaaaeaaaabaamkaaaaaafjaaaaaeegiocaaaaaaaaaaa
cnaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaaaaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaaaaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaaaaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaaaaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaaaaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaaaaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaacmaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 19 math
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
"vs_4_0_level_9_1
eefiecedfmgimnahjbflljcaipnibkeemkoamafnabaaaaaaleagaaaaaeaaaaaa
daaaaaaaemacaaaahmafaaaaeeagaaaaebgpgodjbeacaaaabeacaaaaaaacpopp
lmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaacgaa
ahaaabaaaaaaaaaaabaaaaaaaeaaaiaaaaaaaaaaabaaamaaadaaamaaaaaaaaaa
abaabeaaabaaapaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaahiaacaaoejaapaappkaafaaaaadabaaahiaaaaaffia
anaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahia
aoaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabaaaaakaajaaaaadabaaabia
abaaoekaaaaaoeiaajaaaaadabaaaciaacaaoekaaaaaoeiaajaaaaadabaaaeia
adaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabia
aeaaoekaacaaoeiaajaaaaadadaaaciaafaaoekaacaaoeiaajaaaaadadaaaeia
agaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiia
aaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappibabaaaaac
aaaaahoaaaaaoeiaaeaaaaaeabaaahoaahaaoekaaaaappiaabaaoeiaafaaaaad
aaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapiaaiaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcciadaaaaeaaaabaamkaaaaaafjaaaaae
egiocaaaaaaaaaaacnaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaaaaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaaaaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaaaaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
aaaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
aaaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
aaaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
aaaaaaaacmaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
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
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = _TintColor.w;
  lowp vec4 c_3;
  c_3.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_3.w = tmpvar_2;
  c_1.xyz = (c_3.xyz + (_TintColor.xyz * xlv_TEXCOORD1));
  c_1.w = tmpvar_2;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
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
"agal_vs
c16 1.0 0.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaapaaaappabaaaaaa mul r1.xyz, a1, c15.w
bcaaaaaaadaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r1.xyzz, c5
bcaaaaaaacaaaiacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c6
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
aaaaaaaaaaaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.w
aaaaaaaaaaaaaeacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r2.w
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
aaaaaaaaaaaaaiacbaaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c16.x
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.z, r0, c10
bdaaaaaaacaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r2.y, r0, c9
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r2.x, r0, c8
adaaaaaaaaaaacacadaaaappacaaaaaaadaaaappacaaaaaa mul r0.y, r3.w, r3.w
bdaaaaaaadaaaeacabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r3.z, r1, c13
bdaaaaaaadaaacacabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 r3.y, r1, c12
bdaaaaaaadaaabacabaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 r3.x, r1, c11
adaaaaaaaeaaacacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r4.y, r0.x, r0.x
acaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaffacaaaaaa sub r0.y, r4.y, r0.y
adaaaaaaabaaahacaaaaaaffacaaaaaaaoaaaaoeabaaaaaa mul r1.xyz, r0.y, c14
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaabaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v1.xyz, r2.xyzz, r1.xyzz
aaaaaaaaaaaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.z, r2.w
aaaaaaaaaaaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.y, r3.w
aaaaaaaaaaaaabaeaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.x, r0.x
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = _TintColor.w;
  lowp vec4 c_3;
  c_3.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_3.w = tmpvar_2;
  c_1.xyz = (c_3.xyz + (_TintColor.xyz * xlv_TEXCOORD1));
  c_1.w = tmpvar_2;
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
out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = _TintColor.w;
  lowp vec4 c_3;
  c_3.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_3.w = tmpvar_2;
  c_1.xyz = (c_3.xyz + (_TintColor.xyz * xlv_TEXCOORD1));
  c_1.w = tmpvar_2;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
"!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
MAD result.texcoord[0].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"vs_2_0
dcl_position0 v0
dcl_texcoord1 v2
mad oT0.xy, v2, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedglbkmkgcpjnhlbcbidepjnjgdegjpjlcabaaaaaaiaacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefccmabaaaaeaaaabaaelaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedlpckbdigfhgopmlofmdfadbbfgekjiniabaaaaaagmadaaaaaeaaaaaa
daaaaaaabiabaaaaemacaaaabeadaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpopp
kaaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaeaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaaeaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefccmabaaaa
eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _TintColor;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = (_TintColor.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz));
  c_1.w = _TintColor.w;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"agal_vs
[bc]
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v0.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _TintColor;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  c_1.xyz = (_TintColor.xyz * ((8.0 * tmpvar_2.w) * tmpvar_2.xyz));
  c_1.w = _TintColor.w;
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
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _TintColor;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  c_1.xyz = (_TintColor.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD0).xyz));
  c_1.w = _TintColor.w;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
"!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
MAD result.texcoord[0].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"vs_2_0
dcl_position0 v0
dcl_texcoord1 v2
mad oT0.xy, v2, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedglbkmkgcpjnhlbcbidepjnjgdegjpjlcabaaaaaaiaacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefccmabaaaaeaaaabaaelaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaaaaaaaaaaaeaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 5 math
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord1" TexCoord1
ConstBuffer "$Globals" 80
Vector 64 [unity_LightmapST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedlpckbdigfhgopmlofmdfadbbfgekjiniabaaaaaagmadaaaaaeaaaaaa
daaaaaaabiabaaaaemacaaaabeadaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpopp
kaaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaaeaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaaeaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefccmabaaaa
eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaaeaaaaaaogikcaaa
aaaaaaaaaeaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _TintColor;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 lm_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz);
  lm_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_TintColor.xyz * lm_2);
  c_1.xyz = tmpvar_4;
  c_1.w = _TintColor.w;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"agal_vs
[bc]
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v0.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}
SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _TintColor;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  mediump vec3 lm_3;
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((8.0 * tmpvar_2.w) * tmpvar_2.xyz);
  lm_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = (_TintColor.xyz * lm_3);
  c_1.xyz = tmpvar_5;
  c_1.w = _TintColor.w;
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
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _TintColor;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 c_1;
  mediump vec3 lm_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD0).xyz);
  lm_2 = tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = (_TintColor.xyz * lm_2);
  c_1.xyz = tmpvar_4;
  c_1.w = _TintColor.w;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 56 math
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
"!!ARBvp1.0
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
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[22];
DP4 R4.z, R0, c[21];
DP4 R4.y, R0, c[20];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[23];
ADD R2.xyz, R2, R4.yzww;
ADD R0.xyz, R2, R0;
ADD result.texcoord[1].xyz, R0, R1;
MOV result.texcoord[0].z, R3.x;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R4;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 56 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 56 math
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
"vs_2_0
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
mul r1.w, r3, r3
dp4 r4.w, r0, c21
dp4 r4.z, r0, c20
dp4 r4.y, r0, c19
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c22
add r2.xyz, r2, r4.yzww
add r0.xyz, r2, r0
add oT1.xyz, r0, r1
mov oT0.z, r3.x
mov oT0.y, r3.w
mov oT0.x, r4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 43 math
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
eefiecedpandpmeinedbekgplejccfihafeggfkmabaaaaaaoeahaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchiagaaaaeaaaabaajoabaaaafjaaaaaeegiocaaaaaaaaaaa
cnaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaaaaaaaaa
cgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaaaaaaaaa
chaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaaaaaaaaa
ciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaaaaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaaaaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaaaaaaaaaclaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaa
aaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 43 math
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
"vs_4_0_level_9_1
eefiecedfgkeplaekbajeipnambloaffnfmlbkbmabaaaaaaaiamaaaaaeaaaaaa
daaaaaaafaaeaaaanaakaaaajialaaaaebgpgodjbiaeaaaabiaeaaaaaaacpopp
leadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaacaa
aiaaabaaaaaaaaaaaaaacgaaahaaajaaaaaaaaaaabaaaaaaaeaabaaaaaaaaaaa
abaaamaaaeaabeaaaaaaaaaaabaabeaaabaabiaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbjaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaaaaaffjabfaaoeka
aeaaaaaeaaaaahiabeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabgaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaappjaaaaaoeiaacaaaaad
abaaapiaaaaaffibacaaoekaafaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaad
adaaapiaaaaaaaibabaaoekaacaaaaadaaaaapiaaaaakkibadaaoekaaeaaaaae
acaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeia
acaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaac
aeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiabjaaaaka
aeaaaaaeacaaapiaacaaoeiaaeaaoekaafaaaaiaafaaaaadafaaahiaacaaoeja
biaappkaafaaaaadagaaahiaafaaffiabfaaoekaaeaaaaaeafaaaliabeaakeka
afaaaaiaagaakeiaaeaaaaaeafaaahiabgaaoekaafaakkiaafaapeiaafaaaaad
abaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeia
aeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeia
aaaaoeiaalaaaaadaaaaapiaaaaaoeiabjaaffkaagaaaaacabaaabiaacaaaaia
agaaaaacabaaaciaacaaffiaagaaaaacabaaaeiaacaakkiaagaaaaacabaaaiia
acaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffia
agaaoekaaeaaaaaeabaaahiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
ahaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaappiaaaaaoeia
abaaaaacafaaaiiabjaaaakaajaaaaadabaaabiaajaaoekaafaaoeiaajaaaaad
abaaaciaakaaoekaafaaoeiaajaaaaadabaaaeiaalaaoekaafaaoeiaafaaaaad
acaaapiaafaacjiaafaakeiaajaaaaadadaaabiaamaaoekaacaaoeiaajaaaaad
adaaaciaanaaoekaacaaoeiaajaaaaadadaaaeiaaoaaoekaacaaoeiaacaaaaad
abaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaae
aaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaacaaaaahoaafaaoeiaaeaaaaae
abaaahiaapaaoekaaaaappiaabaaoeiaacaaaaadabaaahoaaaaaoeiaabaaoeia
afaaaaadaaaaapiaaaaaffjabbaaoekaaeaaaaaeaaaaapiabaaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefchiagaaaaeaaaabaajoabaaaa
fjaaaaaeegiocaaaaaaaaaaacnaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaaaaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaaaaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaaaaaaaaaciaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaaaaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaaaaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaaaaaaaaaclaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
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
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = _TintColor.w;
  lowp vec4 c_3;
  c_3.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_3.w = tmpvar_2;
  c_1.xyz = (c_3.xyz + (_TintColor.xyz * xlv_TEXCOORD1));
  c_1.w = tmpvar_2;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
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
"agal_vs
c24 1.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaabhaaaappabaaaaaa mul r3.xyz, a1, c23.w
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaajaaaaoeabaaaaaa add r1, r1.x, c9
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaaiaaaaoeabaaaaaa add r0, r0.x, c8
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
aaaaaaaaaeaaaiacbiaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c24.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaaakaaaaoeabaaaaaa add r0, r0.y, c10
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaaalaaaaoeabaaaaaa mul r2, r1, c11
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaabiaaaaaaabaaaaaa add r1, r2, c24.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r2.z, r4, c18
bdaaaaaaacaaacacaeaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.y, r4, c17
bdaaaaaaacaaabacaeaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r2.x, r4, c16
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabiaaaaffabaaaaaa max r0, r0, c24.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaaanaaaaoeabaaaaaa mul r1.xyz, r0.y, c13
adaaaaaaafaaahacaaaaaaaaacaaaaaaamaaaaoeabaaaaaa mul r5.xyz, r0.x, c12
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaaaoaaaaoeabaaaaaa mul r0.xyz, r0.z, c14
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaaapaaaaoeabaaaaaa mul r1.xyz, r0.w, c15
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaaeaaaiacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r4.w, r0, c21
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r4.z, r0, c20
bdaaaaaaaeaaacacaaaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r4.y, r0, c19
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabgaaaaoeabaaaaaa mul r0.xyz, r1.w, c22
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaapjacaaaaaa add r2.xyz, r2.xyzz, r4.yzww
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v1.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.z, r3.x
aaaaaaaaaaaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.y, r3.w
aaaaaaaaaaaaabaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.x, r4.x
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = _TintColor.w;
  lowp vec4 c_3;
  c_3.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_3.w = tmpvar_2;
  c_1.xyz = (c_3.xyz + (_TintColor.xyz * xlv_TEXCOORD1));
  c_1.w = tmpvar_2;
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
out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp float tmpvar_2;
  tmpvar_2 = _TintColor.w;
  lowp vec4 c_3;
  c_3.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_3.w = tmpvar_2;
  c_1.xyz = (c_3.xyz + (_TintColor.xyz * xlv_TEXCOORD1));
  c_1.w = tmpvar_2;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 8 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_TintColor]
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
MOV R0.xyz, c[1];
DP3 R0.w, fragment.texcoord[0], c[0];
MUL R1.xyz, fragment.texcoord[1], c[2];
MUL R0.xyz, R0, c[2];
MAX R0.w, R0, c[3].x;
MUL R0.xyz, R0.w, R0;
MAD result.color.xyz, R0, c[3].y, R1;
MOV result.color.w, c[2];
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_TintColor]
"ps_2_0
def c3, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
mov_pp r1.xyz, c2
dp3_pp r0.x, t0, c0
mul_pp r2.xyz, t1, c2
mul_pp r1.xyz, c1, r1
max_pp r0.x, r0, c3
mul_pp r0.xyz, r0.x, r1
mad_pp r0.xyz, r0, c3.y, r2
mov_pp r0.w, c2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
ConstBuffer "$Globals" 64
Vector 16 [_LightColor0]
Vector 48 [_TintColor]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
eefiecedcljdieeaimjmkphfjkbjapjlhmlbnhphabaaaaaaaiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdaabaaaaeaaaaaaaemaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaa
adaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 6 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
ConstBuffer "$Globals" 64
Vector 16 [_LightColor0]
Vector 48 [_TintColor]
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0_level_9_1
eefiecedoboffgjbpinkomacdkifffibegdelofkabaaaaaabmadaaaaaeaaaaaa
daaaaaaaeaabaaaahiacaaaaoiacaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
maaaaaaaeiaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaaaaaeiaaaaaaabaa
abaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaabaaaaaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaachlabpaaaaacaaaaaaiaabaachlaaiaaaaadaaaaciiaaaaaoela
acaaoekaalaaaaadabaaciiaaaaappiaadaaaakaacaaaaadaaaacbiaabaappia
abaappiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablka
afaaaaadabaachiaabaaoelaabaaoekaaeaaaaaeaaaachiaaaaabliaaaaaaaia
abaaoeiaabaaaaacaaaaciiaabaappkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcdaabaaaaeaaaaaaaemaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaai
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaaihcaabaaa
abaaaaaaegbcbaaaacaaaaaaegiccaaaaaaaaaaaadaaaaaadcaaaaajhccabaaa
aaaaaaaajgahbaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadgaaaaag
iccabaaaaaaaaaaadkiacaaaaaaaaaaaadaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_TintColor]
"agal_ps
c3 0.0 2.0 0.0 0.0
[bc]
aaaaaaaaabaaahacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c2
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v0, c0
adaaaaaaacaaahacabaaaaoeaeaaaaaaacaaaaoeabaaaaaa mul r2.xyz, v1, c2
adaaaaaaabaaahacabaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c1, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaadaaaaoeabaaaaaa max r0.x, r0.x, c3
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c3.y
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
aaaaaaaaaaaaaiacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
// Stats: 5 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
SetTexture 0 [unity_Lightmap] 2D 0
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 8 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, c[1].x;
MOV result.color.w, c[0];
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 5 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
SetTexture 0 [unity_Lightmap] 2D 0
"ps_2_0
dcl_2d s0
def c1, 8.00000000, 0, 0, 0
dcl t0.xy
texld r0, t0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, c1.x
mov_pp r0.w, c0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 3 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 80
Vector 48 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfknmkaaaamclohdfidmhihbmlhalhmbeabaaaaaakmabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomaaaaaa
eaaaaaaadlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 3 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 80
Vector 48 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjgmlgbamgdmcicpbmnogcljjfhikeghkabaaaaaahmacaaaaaeaaaaaa
daaaaaaapmaaaaaapaabaaaaeiacaaaaebgpgodjmeaaaaaameaaaaaaaaacpppp
jaaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaebaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaabaaaaka
afaaaaadaaaachiaaaaaoeiaaaaappiaafaaaaadaaaachiaaaaaoeiaaaaaoeka
abaaaaacaaaaciiaaaaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
omaaaaaaeaaaaaaadlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadgaaaaagiccabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
Vector 0 [_TintColor]
SetTexture 0 [unity_Lightmap] 2D 0
"agal_ps
c1 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c1.x
aaaaaaaaaaaaaiacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
// Stats: 5 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_TintColor]
SetTexture 0 [unity_Lightmap] 2D 0
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 8 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, c[1].x;
MOV result.color.w, c[0];
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 5 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_TintColor]
SetTexture 0 [unity_Lightmap] 2D 0
"ps_2_0
dcl_2d s0
def c1, 8.00000000, 0, 0, 0
dcl t0.xy
texld r0, t0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c0
mul_pp r0.xyz, r0, c1.x
mov_pp r0.w, c0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 3 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 80
Vector 48 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfknmkaaaamclohdfidmhihbmlhalhmbeabaaaaaakmabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomaaaaaa
eaaaaaaadlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 3 math, 1 textures
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
SetTexture 0 [unity_Lightmap] 2D 0
ConstBuffer "$Globals" 80
Vector 48 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjgmlgbamgdmcicpbmnogcljjfhikeghkabaaaaaahmacaaaaaeaaaaaa
daaaaaaapmaaaaaapaabaaaaeiacaaaaebgpgodjmeaaaaaameaaaaaaaaacpppp
jaaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaaebaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaabaaaaka
afaaaaadaaaachiaaaaaoeiaaaaappiaafaaaaadaaaachiaaaaaoeiaaaaaoeka
abaaaaacaaaaciiaaaaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
omaaaaaaeaaaaaaadlaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaihccabaaaaaaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaadgaaaaagiccabaaaaaaaaaaa
dkiacaaaaaaaaaaaadaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
Vector 0 [_TintColor]
SetTexture 0 [unity_Lightmap] 2D 0
"agal_ps
c1 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c1.x
aaaaaaaaaaaaaiacaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
 //       d3d11 : 17 avg math (8..21)
 //    d3d11_9x : 17 avg math (8..21)
 //        d3d9 : 14 avg math (9..17)
 //      opengl : 14 avg math (9..17)
 // Stats for Fragment shader:
 //       d3d11 : 8 avg math (5..15), 1 avg texture (0..2)
 //    d3d11_9x : 8 avg math (5..15), 1 avg texture (0..2)
 //        d3d9 : 13 avg math (9..19), 1 avg texture (0..2)
 //      opengl : 13 avg math (8..19), 1 avg texture (0..2)
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
// Stats: 16 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
ADD result.texcoord[1].xyz, -R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT2.z, r0, c10
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
add oT1.xyz, -r0, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
eefiecedjbagmlnhfgpadjpojednogacopbafeniabaaaaaaciafaaaaadaaaaaa
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
keadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 21 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
"vs_4_0_level_9_1
eefiecednjlhgbaeclipldcmndpdegegeebfmjbaabaaaaaagaahaaaaaeaaaaaa
daaaaaaageacaaaabaagaaaaniagaaaaebgpgodjcmacaaaacmacaaaaaaacpopp
miabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaalaaoekaaeaaaaaeaaaaahiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappjaaaaaoeiaacaaaaadabaaahoaaaaaoeibafaaoekaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeacaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefckeadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_6;
  c_6.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_5)).w) * 2.0));
  c_6.w = tmpvar_3;
  c_1.xyz = c_6.xyz;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaacaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v2.z, r0, c10
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaamaaaaoeabaaaaaa add v1.xyz, r0.xyzz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_6;
  c_6.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_5)).w) * 2.0));
  c_6.w = tmpvar_3;
  c_1.xyz = c_6.xyz;
  c_1.w = tmpvar_3;
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
out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_6;
  c_6.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture (_LightTexture0, vec2(tmpvar_5)).w) * 2.0));
  c_6.w = tmpvar_3;
  c_1.xyz = c_6.xyz;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 9 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [_WorldSpaceLightPos0]
Vector 10 [unity_Scale]
"!!ARBvp1.0
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[10].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
MOV result.texcoord[1].xyz, c[9];
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
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [unity_Scale]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c9.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
mov oT1.xyz, c8
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 8 math
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
eefiecedadephbcibkjjklcfhahcomkdcngingipabaaaaaacaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcleabaaaaeaaaabaagnaaaaaafjaaaaaeegiocaaaaaaaaaaa
abaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaaaaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
// Stats: 8 math
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
"vs_4_0_level_9_1
eefiecedgcjeojicaegnnejmkebiefkblbgnfgnkabaaaaaageaeaaaaaeaaaaaa
daaaaaaahaabaaaacmadaaaapeadaaaaebgpgodjdiabaaaadiabaaaaaaacpopp
oaaaaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaaaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaadaaagaaaaaaaaaa
abaabeaaabaaajaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaacaaoejaajaappkaafaaaaad
abaaahiaaaaaffiaahaaoekaaeaaaaaeaaaaaliaagaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahoaaiaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaahoaabaaoekappppaaaafdeieefcleabaaaaeaaaabaagnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
aaaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  c_4.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * 2.0));
  c_4.w = tmpvar_3;
  c_1.xyz = c_4.xyz;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [_WorldSpaceLightPos0]
Vector 9 [unity_Scale]
"agal_vs
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaaajaaaappabaaaaaa mul r0.xyz, a1, c9.w
bcaaaaaaaaaaaeaeaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r0.xyzz, c6
bcaaaaaaaaaaacaeaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r0.xyzz, c5
bcaaaaaaaaaaabaeaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r0.xyzz, c4
aaaaaaaaabaaahaeaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, c8
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  c_4.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * 2.0));
  c_4.w = tmpvar_3;
  c_1.xyz = c_4.xyz;
  c_1.w = tmpvar_3;
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
out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  c_4.xyz = ((_TintColor.xyz * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * 2.0));
  c_4.w = tmpvar_3;
  c_1.xyz = c_4.xyz;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 17 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[2].w, R0, c[12];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
ADD result.texcoord[1].xyz, -R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT2.w, r0, c11
dp4 oT2.z, r0, c10
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
add oT1.xyz, -r0, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
eefiecedbfollafedkcjbkpbkblmkfincjbaobggabaaaaaaciafaaaaadaaaaaa
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
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
keadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaadaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 21 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
"vs_4_0_level_9_1
eefiecednminbgfhgcnebocabjdokepflbaalnelabaaaaaagaahaaaaaeaaaaaa
daaaaaaageacaaaabaagaaaaniagaaaaebgpgodjcmacaaaacmacaaaaaaacpopp
miabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaalaaoekaaeaaaaaeaaaaahiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappjaaaaaoeiaacaaaaadabaaahoaaaaaoeibafaaoekaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeacaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefckeadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp float atten_7;
  atten_7 = ((float((xlv_TEXCOORD2.z > 0.0)) * texture2D (_LightTexture0, P_5).w) * texture2D (_LightTextureB0, vec2(tmpvar_6)).w);
  lowp vec4 c_8;
  c_8.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * atten_7) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaacaaaiaeaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 v2.w, r0, c11
bdaaaaaaacaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v2.z, r0, c10
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaamaaaaoeabaaaaaa add v1.xyz, r0.xyzz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp float atten_7;
  atten_7 = ((float((xlv_TEXCOORD2.z > 0.0)) * texture2D (_LightTexture0, P_5).w) * texture2D (_LightTextureB0, vec2(tmpvar_6)).w);
  lowp vec4 c_8;
  c_8.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * atten_7) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = tmpvar_3;
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
out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp float atten_7;
  atten_7 = ((float((xlv_TEXCOORD2.z > 0.0)) * texture (_LightTexture0, P_5).w) * texture (_LightTextureB0, vec2(tmpvar_6)).w);
  lowp vec4 c_8;
  c_8.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * atten_7) * 2.0));
  c_8.w = tmpvar_3;
  c_1.xyz = c_8.xyz;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 16 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
ADD result.texcoord[1].xyz, -R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 16 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT2.z, r0, c10
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
add oT1.xyz, -r0, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 21 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
eefiecedjbagmlnhfgpadjpojednogacopbafeniabaaaaaaciafaaaaadaaaaaa
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
keadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 21 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
"vs_4_0_level_9_1
eefiecednjlhgbaeclipldcmndpdegegeebfmjbaabaaaaaagaahaaaaaeaaaaaa
daaaaaaageacaaaabaagaaaaniagaaaaebgpgodjcmacaaaacmacaaaaaaacpopp
miabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaalaaoekaaeaaaaaeaaaaahiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappjaaaaaoeiaacaaaaadabaaahoaaaaaoeibafaaoekaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeacaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefckeadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_6;
  c_6.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_5)).w * textureCube (_LightTexture0, xlv_TEXCOORD2).w)) * 2.0));
  c_6.w = tmpvar_3;
  c_1.xyz = c_6.xyz;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaacaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v2.z, r0, c10
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaamaaaaoeabaaaaaa add v1.xyz, r0.xyzz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_6;
  c_6.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_5)).w * textureCube (_LightTexture0, xlv_TEXCOORD2).w)) * 2.0));
  c_6.w = tmpvar_3;
  c_1.xyz = c_6.xyz;
  c_1.w = tmpvar_3;
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
out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  mediump vec3 tmpvar_4;
  tmpvar_4 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_6;
  c_6.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * (texture (_LightTextureB0, vec2(tmpvar_5)).w * texture (_LightTexture0, xlv_TEXCOORD2).w)) * 2.0));
  c_6.w = tmpvar_3;
  c_1.xyz = c_6.xyz;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "opengl " {
// Stats: 15 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 13 [_WorldSpaceLightPos0]
Vector 14 [unity_Scale]
"!!ARBvp1.0
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MOV result.texcoord[1].xyz, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 15 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"vs_2_0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mov oT1.xyz, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
// Stats: 16 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
eefiecedlogopdpgoklkniijmiokhfgkpbfgncjaabaaaaaaieaeaaaaadaaaaaa
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
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aaadaaaaeaaaabaamaaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 16 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "$Globals" 128
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
"vs_4_0_level_9_1
eefiecedhikablenajlieepfgediebkkpnnbmihdabaaaaaagmagaaaaaeaaaaaa
daaaaaaabeacaaaabmafaaaaoeafaaaaebgpgodjnmabaaaanmabaaaaaaacpopp
hiabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
anaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoekaaeaaaaae
aaaaadiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoekaaaaakkia
aaaaoeiaaeaaaaaeacaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapia
aaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacabaaahoaafaaoekappppaaaafdeieefcaaadaaaaeaaaabaa
maaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  c_4.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD2).w) * 2.0));
  c_4.w = tmpvar_3;
  c_1.xyz = c_4.xyz;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [unity_Scale]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
aaaaaaaaabaaahaeamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
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
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _TintColor;
varying lowp vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  c_4.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD2).w) * 2.0));
  c_4.w = tmpvar_3;
  c_1.xyz = c_4.xyz;
  c_1.w = tmpvar_3;
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
out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _TintColor;
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp float tmpvar_3;
  tmpvar_3 = _TintColor.w;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_4;
  c_4.xyz = ((_TintColor.xyz * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture (_LightTexture0, xlv_TEXCOORD2).w) * 2.0));
  c_4.w = tmpvar_3;
  c_1.xyz = c_4.xyz;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 13 math, 1 textures
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MOV result.color.w, c[1];
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MOV R0.xyz, c[0];
DP3 R1.x, fragment.texcoord[0], R1;
MAX R1.x, R1, c[2];
MUL R0.xyz, R0, c[1];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 14 math, 1 textures
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
"ps_2_0
dcl_2d s0
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dp3 r0.x, t2, t2
mov r0.xy, r0.x
mov_pp r1.xyz, c1
mul_pp r1.xyz, c0, r1
mov_pp r0.w, c1
texld r2, r0, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t1
dp3_pp r0.x, t0, r0
max_pp r0.x, r0, c2
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c2.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 9 math, 1 textures
Keywords { "POINT" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlghelpcggiedacddnpichplpnaeofnhgabaaaaaajiacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiabaaaaeaaaaaaagkaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaadiaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaag
iccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 9 math, 1 textures
Keywords { "POINT" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkppgfofpkngafbdajgjiefphpkckgmheabaaaaaapeadaaaaaeaaaaaa
daaaaaaaiiabaaaadiadaaaamaadaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
baabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaachla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaja
aaaiapkaaiaaaaadaaaaaiiaacaaoelaacaaoelaabaaaaacaaaaadiaaaaappia
ecaaaaadaaaacpiaaaaaoeiaaaaioekaceaaaaacabaachiaabaaoelaaiaaaaad
aaaacciaaaaaoelaabaaoeiaafaaaaadaaaacbiaaaaaaaiaaaaaffiafiaaaaae
aaaacbiaaaaaffiaaaaaaaiaacaaaakaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
abaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablkaafaaaaad
aaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaabaappkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefckiabaaaaeaaaaaaagkaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaadiaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaag
iccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaabaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c1
adaaaaaaabaaahacaaaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c0, r1.xyzz
ciaaaaaaaaaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r0, r0.xyyy, s0 <2d wrap linear point>
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, v1, v1
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r0.xyz, r0.x, v1
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v0, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
// Stats: 8 math
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[1];
MOV R0.xyz, c[0];
DP3 R0.w, fragment.texcoord[0], R1;
MUL R0.xyz, R0, c[1];
MAX R0.w, R0, c[2].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
MOV result.color.w, c[1];
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 9 math
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
"ps_2_0
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
mov_pp r0.xyz, t1
dp3_pp r0.x, t0, r0
mov_pp r1.xyz, c1
mul_pp r1.xyz, c0, r1
max_pp r0.x, r0, c2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c2.y
mov_pp r0.w, c1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 5 math
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 64
Vector 16 [_LightColor0]
Vector 48 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedllkmodbdljamelhanchcneocpioplmbfabaaaaaammabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaadnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 5 math
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 64
Vector 16 [_LightColor0]
Vector 48 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmiabpplghjifchajnfopoklpndamipncabaaaaaammacaaaaaeaaaaaa
daaaaaaacmabaaaaciacaaaajiacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
liaaaaaadmaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaaaaadmaaaaaaabaa
abaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaaaacppppfbaaaaafacaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaachlabpaaaaac
aaaaaaiaabaachlaabaaaaacaaaaahiaaaaaoelaaiaaaaadaaaacbiaaaaaoeia
abaaoelaalaaaaadabaaciiaaaaaaaiaacaaaakaacaaaaadaaaacbiaabaappia
abaappiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablka
afaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaabaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaa
adaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
aaaaaaaaaaaaahacabaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v1
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v0, r0.xyzz
aaaaaaaaabaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c1
adaaaaaaabaaahacaaaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c0, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
// Stats: 19 math, 2 textures
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RCP R0.x, fragment.texcoord[2].w;
MAD R0.xy, fragment.texcoord[2], R0.x, c[2].y;
MOV result.color.w, c[1];
TEX R0.w, R0, texture[0], 2D;
TEX R1.w, R0.z, texture[1], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R0.x;
MUL R1.xyz, R1.x, fragment.texcoord[1];
DP3 R1.x, fragment.texcoord[0], R1;
SLT R1.y, c[2].x, fragment.texcoord[2].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MOV R0.xyz, c[0];
MAX R0.w, R1.x, c[2].x;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 19 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 19 math, 2 textures
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c2, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0.xyz
dcl t1.xyz
dcl t2
rcp r1.x, t2.w
mad r2.xy, t2, r1.x, c2.x
dp3 r0.x, t2, t2
mov r1.xy, r0.x
texld r0, r2, s0
texld r2, r1, s1
cmp r0.x, -t2.z, c2.y, c2.z
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r2
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t1
mov_pp r2.xyz, c1
dp3_pp r1.x, t0, r1
max_pp r1.x, r1, c2.y
mul_pp r2.xyz, c0, r2
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 15 math, 2 textures
Keywords { "SPOT" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecededcaifbphhpdknggcghgljemfemoobndabaaaaaaimadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaabaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 15 math, 2 textures
Keywords { "SPOT" }
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedafgkfhkceigekfokeljmmifaeolglfjgabaaaaaaeiafaaaaaeaaaaaa
daaaaaaaoiabaaaaimaeaaaabeafaaaaebgpgodjlaabaaaalaabaaaaaaacpppp
gmabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
aeaaaaaeaaaaadiaacaaoelaaaaappiaacaaaakaaiaaaaadabaaaiiaacaaoela
acaaoelaabaaaaacabaaadiaabaappiaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaabaaoeiaabaioekaafaaaaadaaaacbiaaaaappiaabaaaaia
fiaaaaaeaaaacbiaacaakklbacaaffkaaaaaaaiaceaaaaacabaachiaabaaoela
aiaaaaadaaaacciaaaaaoelaabaaoeiaalaaaaadabaacbiaaaaaffiaacaaffka
afaaaaadaaaacbiaaaaaaaiaabaaaaiaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
abaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablkaafaaaaad
aaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaabaappkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcjmacaaaaeaaaaaaakhaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaabaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaa
aaaaaaaaahaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
"agal_ps
c2 0.5 0.0 1.0 2.0
[bc]
afaaaaaaabaaabacacaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v2.w
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
adaaaaaaabaaadacacaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v2, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaacaaaaaaabaaaaaa add r1.xy, r1.xyyy, c2.x
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaacaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.xyz, c1
adaaaaaaacaaahacaaaaaaoeabaaaaaaacaaaakeacaaaaaa mul r2.xyz, c0, r2.xyzz
ciaaaaaaabaaapacabaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r1.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
bfaaaaaaacaaaiacacaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r2.w, v2.z
ckaaaaaaaaaaabacacaaaappacaaaaaaacaaaaffabaaaaaa slt r0.x, r2.w, c2.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r1.x, v1, v1
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r1.xyz, r1.x, v1
bcaaaaaaabaaabacaaaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v0, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaffabaaaaaa max r1.x, r1.x, c2.y
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaappabaaaaaa mul r0.xyz, r0.xyzz, c2.w
aaaaaaaaaaaaaiacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
// Stats: 15 math, 2 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTextureB0] 2D 0
SetTexture 1 [_LightTexture0] CUBE 1
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R1.w, fragment.texcoord[2], texture[1], CUBE;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MOV result.color.w, c[1];
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R0.x;
MUL R1.xyz, R1.x, fragment.texcoord[1];
DP3 R1.x, fragment.texcoord[0], R1;
MUL R1.y, R0.w, R1.w;
MOV R0.xyz, c[0];
MAX R0.w, R1.x, c[2].x;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 15 math, 2 textures
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTextureB0] 2D 0
SetTexture 1 [_LightTexture0] CUBE 1
"ps_2_0
dcl_2d s0
dcl_cube s1
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dp3 r0.x, t2, t2
mov r0.xy, r0.x
texld r2, r0, s0
texld r0, t2, s1
dp3_pp r0.x, t1, t1
rsq_pp r1.x, r0.x
mul_pp r1.xyz, r1.x, t1
dp3_pp r1.x, t0, r1
mul r0.x, r2, r0.w
mov_pp r2.xyz, c1
max_pp r1.x, r1, c2
mul_pp r2.xyz, c0, r2
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c2.y
mov_pp r0.w, c1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 10 math, 2 textures
Keywords { "POINT_COOKIE" }
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjbhbahnbcocflljmmalpnpjnnphgbkdfabaaaaaapeacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaeacaaaaeaaaaaaaibaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 10 math, 2 textures
Keywords { "POINT_COOKIE" }
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednfmcggefocknbcjfnnefghhiaofpgngdabaaaaaahmaeaaaaaeaaaaaa
daaaaaaaleabaaaamaadaaaaeiaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
diabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaac
aaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkaaiaaaaadaaaaaiiaacaaoela
acaaoelaabaaaaacaaaaadiaaaaappiaecaaaaadaaaaapiaaaaaoeiaabaioeka
ecaaaaadabaaapiaacaaoelaaaaioekaafaaaaadaaaacbiaaaaaaaiaabaappia
ceaaaaacabaachiaabaaoelaaiaaaaadaaaacciaaaaaoelaabaaoeiaalaaaaad
abaacbiaaaaaffiaacaaaakaafaaaaadaaaacbiaaaaaaaiaabaaaaiaacaaaaad
aaaacbiaaaaaaaiaaaaaaaiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoia
abaabliaaaaablkaafaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciia
abaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaeacaaaaeaaaaaaa
ibaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaa
aaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaagiccabaaaaaaaaaaadkiacaaaaaaaaaaaahaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTextureB0] 2D 0
SetTexture 1 [_LightTexture0] CUBE 1
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaacaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.xyz, c1
adaaaaaaacaaahacaaaaaaoeabaaaaaaacaaaakeacaaaaaa mul r2.xyz, c0, r2.xyzz
ciaaaaaaabaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r0.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaabaaaaaaafbababb tex r0, v2, s1 <cube wrap linear point>
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, v1, v1
akaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r0.x
adaaaaaaaaaaabacabaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r1.w, r0.w
adaaaaaaabaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r1.xyz, r1.x, v1
bcaaaaaaabaaabacaaaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v0, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaoeabaaaaaa max r1.x, r1.x, c2
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
// Stats: 10 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[2], texture[0], 2D;
MOV R1.xyz, fragment.texcoord[1];
MOV R0.xyz, c[0];
DP3 R1.x, fragment.texcoord[0], R1;
MAX R1.x, R1, c[2];
MUL R0.xyz, R0, c[1];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
MOV result.color.w, c[1];
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 10 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
"ps_2_0
dcl_2d s0
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
texld r0, t2, s0
mov_pp r0.xyz, t1
dp3_pp r0.x, t0, r0
mov_pp r1.xyz, c1
max_pp r0.x, r0, c2
mul_pp r0.x, r0, r0.w
mul_pp r1.xyz, c0, r1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c2.y
mov_pp r0.w, c1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 5 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeeabjbkalcmdplenhcfoipipfneghicgabaaaaaadaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceaabaaaaeaaaaaaafaaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaapgapbaaaabaaaaaadiaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaaaaaaaaaa
dkiacaaaaaaaaaaaahaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 5 math, 1 textures
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 128
Vector 16 [_LightColor0]
Vector 112 [_TintColor]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednbpgdohaelgoiidepjhcmmfhpfeakjheabaaaaaahaadaaaaaeaaaaaa
daaaaaaagmabaaaaleacaaaadmadaaaaebgpgodjdeabaaaadeabaaaaaaacpppp
peaaaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaachla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaacaaoelaaaaioekaabaaaaacaaaaahiaaaaaoela
aiaaaaadaaaacbiaaaaaoeiaabaaoelaafaaaaadaaaacciaaaaappiaaaaaaaia
fiaaaaaeaaaacbiaaaaaaaiaaaaaffiaacaaaakaacaaaaadaaaacbiaaaaaaaia
aaaaaaiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablka
afaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaciiaabaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefceaabaaaaeaaaaaaafaaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaapgapbaaaabaaaaaadiaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaagiccabaaa
aaaaaaaadkiacaaaaaaaaaaaahaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_TintColor]
SetTexture 0 [_LightTexture0] 2D 0
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v2, s0 <2d wrap linear point>
aaaaaaaaaaaaahacabaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v1
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v0, r0.xyzz
aaaaaaaaabaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c1
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaabaaahacaaaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c0, r1.xyzz
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
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
Fallback "Particles/Additive"
}