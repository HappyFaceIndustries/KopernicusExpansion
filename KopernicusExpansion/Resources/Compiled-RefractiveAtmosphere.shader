// Compiled shader for all platforms, uncompressed size: 21.7KB

Shader "RefractiveAtmosphere" {
Properties {
 _BumpAmt ("Distortion", Range(0,128)) = 10
 _MainTex ("Tint Color (RGB)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
 _BumpMapOffset ("Offset", Vector) = (0,0,0,0)
}
SubShader { 
 Tags { "QUEUE"="Transparent+100" "RenderType"="Opaque" }
 GrabPass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" }
 }


 // Stats for Vertex shader:
 //       d3d11 : 10 math
 //    d3d11_9x : 10 math
 //        d3d9 : 18 math
 //      opengl : 17 math
 // Stats for Fragment shader:
 //       d3d11 : 8 math, 3 texture
 //    d3d11_9x : 8 math, 3 texture
 //        d3d9 : 10 math, 3 texture
 //      opengl : 11 math, 3 texture
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "QUEUE"="Transparent+100" "RenderType"="Opaque" }
  Cull Front
Program "vp" {
SubProgram "opengl " {
// Stats: 17 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[13] = { { 0, 0.5 },
		state.matrix.mvp,
		state.matrix.texture[1],
		state.matrix.texture[2] };
TEMP R0;
TEMP R1;
DP4 R1.z, vertex.position, c[4];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MOV R0.w, R1.z;
DP4 R0.z, vertex.position, c[3];
MOV R0.x, R1;
MOV R0.y, R1;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
ADD R1.xy, R1.z, R1;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 result.texcoord[1].y, R0, c[6];
DP4 result.texcoord[1].x, R0, c[5];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
MUL result.texcoord[0].xy, R1, c[0].y;
END
# 17 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 18 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture1]
Matrix 8 [glstate_matrix_texture2]
"vs_2_0
def c12, 0.50000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r1.z, v0, c3
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mov r0.y, r1
mov r0.w, r1.z
dp4 r0.z, v0, c2
mov r0.x, r1
mov oPos, r0
mov oT0.zw, r0
mov r1.y, -r1
add r1.xy, r1.z, r1
mov r0.zw, c12.y
mov r0.xy, v1
dp4 oT1.y, r0, c5
dp4 oT1.x, r0, c4
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
mul oT0.xy, r1, c12.x
"
}
SubProgram "d3d11 " {
// Stats: 10 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 576 [glstate_matrix_texture1]
Matrix 640 [glstate_matrix_texture2]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0
eefieceddodlelgfhfddajmmfmlghmphmjfmjmgiabaaaaaadiadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcciacaaaaeaaaabaaikaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaackaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaabaaaaaaegiacaaaabaaaaaa
cfaaaaaadcaaaaakdccabaaaacaaaaaaegiacaaaabaaaaaaceaaaaaaagbabaaa
abaaaaaaegaabaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaabaaaaaa
egiacaaaabaaaaaacjaaaaaadcaaaaakmccabaaaacaaaaaaagiecaaaabaaaaaa
ciaaaaaaagbabaaaabaaaaaaagaebaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 10 math
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 576 [glstate_matrix_texture1]
Matrix 640 [glstate_matrix_texture2]
BindCB  "UnityPerDraw" 0
BindCB  "UnityPerDrawTexMatrices" 1
"vs_4_0_level_9_1
eefieceddheebhhgemklajgflfkplmgaodchmbdpabaaaaaakmaeaaaaaeaaaaaa
daaaaaaakaabaaaanaadaaaaceaeaaaaebgpgodjgiabaaaagiabaaaaaaacpopp
bmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaaaa
aeaaabaaaaaaaaaaabaaceaaacaaafaaaaaaaaaaabaaciaaacaaahaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafajaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaapia
aaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaappja
aaaaoeiaaeaaaaaeabaaadiaaaaaoeiaajaaoekaaaaappiaafaaaaadaaaaadoa
abaaoeiaajaakkkaafaaaaadabaaadiaabaaffjaagaaoekaaeaaaaaeabaaadoa
afaaoekaabaaaajaabaaoeiaafaaaaadabaaadiaabaaffjaaiaaobkaaeaaaaae
abaaamoaahaabekaabaaaajaabaaeeiaaeaaaaaeaaaaadmaaaaappiaaaaaoeka
aaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaa
fdeieefcciacaaaaeaaaabaaikaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fjaaaaaeegiocaaaabaaaaaackaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaa
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaafgbfbaaaabaaaaaaegiacaaaabaaaaaacfaaaaaadcaaaaak
dccabaaaacaaaaaaegiacaaaabaaaaaaceaaaaaaagbabaaaabaaaaaaegaabaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaafgbfbaaaabaaaaaaegiacaaaabaaaaaa
cjaaaaaadcaaaaakmccabaaaacaaaaaaagiecaaaabaaaaaaciaaaaaaagbabaaa
abaaaaaaagaebaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklkl"
}
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  tmpvar_2.zw = tmpvar_3.zw;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_4.y = tmpvar_1.y;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.x = tmpvar_1.x;
  tmpvar_5.y = tmpvar_1.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (glstate_matrix_texture1 * tmpvar_4).xy;
  xlv_TEXCOORD2 = (glstate_matrix_texture2 * tmpvar_5).xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform mediump vec4 _BumpMapOffset;
uniform highp float _BumpAmt;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = xlv_TEXCOORD0.zw;
  mediump vec4 tint_2;
  mediump vec4 col_3;
  highp vec2 P_4;
  P_4 = (xlv_TEXCOORD1 + _BumpMapOffset.xy);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_BumpMap, P_4).xyz * 2.0) - 1.0);
  mediump vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xy * _BumpMapOffset.z);
  tmpvar_1.xy = ((((tmpvar_6 * _BumpAmt) * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_GrabTexture, tmpvar_1);
  col_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD2);
  tint_2 = tmpvar_8;
  gl_FragData[0] = (col_3 * tint_2);
}



#endif"
}
SubProgram "flash " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture1]
Matrix 8 [glstate_matrix_texture2]
"agal_vs
c12 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaabaaaeacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r1.z, a0, c3
bdaaaaaaabaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r1.x, a0, c0
bdaaaaaaabaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r1.y, a0, c1
aaaaaaaaaaaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r1.y
aaaaaaaaaaaaaiacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa mov r0.w, r1.z
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
aaaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r1.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaaaaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, r0.wwzw
bfaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r1.y, r1.y
abaaaaaaabaaadacabaaaakkacaaaaaaabaaaafeacaaaaaa add r1.xy, r1.z, r1.xyyy
aaaaaaaaaaaaamacamaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.zw, c12.y
aaaaaaaaaaaaadacadaaaaoeaaaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, a3
bdaaaaaaabaaacaeaaaaaaoeacaaaaaaafaaaaoeabaaaaaa dp4 v1.y, r0, c5
bdaaaaaaabaaabaeaaaaaaoeacaaaaaaaeaaaaoeabaaaaaa dp4 v1.x, r0, c4
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
adaaaaaaaaaaadaeabaaaafeacaaaaaaamaaaaaaabaaaaaa mul v0.xy, r1.xyyy, c12.x
aaaaaaaaabaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}
SubProgram "glesdesktop " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  tmpvar_2.zw = tmpvar_3.zw;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_4.y = tmpvar_1.y;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.x = tmpvar_1.x;
  tmpvar_5.y = tmpvar_1.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (glstate_matrix_texture1 * tmpvar_4).xy;
  xlv_TEXCOORD2 = (glstate_matrix_texture2 * tmpvar_5).xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform mediump vec4 _BumpMapOffset;
uniform highp float _BumpAmt;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = xlv_TEXCOORD0.zw;
  mediump vec4 tint_2;
  mediump vec4 col_3;
  highp vec2 P_4;
  P_4 = (xlv_TEXCOORD1 + _BumpMapOffset.xy);
  lowp vec3 normal_5;
  normal_5.xy = ((texture2D (_BumpMap, P_4).wy * 2.0) - 1.0);
  normal_5.z = sqrt((1.0 - clamp (dot (normal_5.xy, normal_5.xy), 0.0, 1.0)));
  mediump vec2 tmpvar_6;
  tmpvar_6 = (normal_5.xy * _BumpMapOffset.z);
  tmpvar_1.xy = ((((tmpvar_6 * _BumpAmt) * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_GrabTexture, tmpvar_1);
  col_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD2);
  tint_2 = tmpvar_8;
  gl_FragData[0] = (col_3 * tint_2);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2.xy = ((tmpvar_3.xy + tmpvar_3.w) * 0.5);
  tmpvar_2.zw = tmpvar_3.zw;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_4.y = tmpvar_1.y;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.x = tmpvar_1.x;
  tmpvar_5.y = tmpvar_1.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (glstate_matrix_texture1 * tmpvar_4).xy;
  xlv_TEXCOORD2 = (glstate_matrix_texture2 * tmpvar_5).xy;
}



#endif
#ifdef FRAGMENT

out mediump vec4 _glesFragData[4];
uniform sampler2D _GrabTexture;
uniform highp vec4 _GrabTexture_TexelSize;
uniform sampler2D _BumpMap;
uniform sampler2D _MainTex;
uniform mediump vec4 _BumpMapOffset;
uniform highp float _BumpAmt;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = xlv_TEXCOORD0.zw;
  mediump vec4 tint_2;
  mediump vec4 col_3;
  highp vec2 P_4;
  P_4 = (xlv_TEXCOORD1 + _BumpMapOffset.xy);
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture (_BumpMap, P_4).xyz * 2.0) - 1.0);
  mediump vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xy * _BumpMapOffset.z);
  tmpvar_1.xy = ((((tmpvar_6 * _BumpAmt) * _GrabTexture_TexelSize.xy) * xlv_TEXCOORD0.z) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = textureProj (_GrabTexture, tmpvar_1);
  col_3 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD2);
  tint_2 = tmpvar_8;
  _glesFragData[0] = (col_3 * tint_2);
}



#endif"
}
}
Program "fp" {
SubProgram "opengl " {
// Stats: 11 math, 3 textures
Vector 0 [_GrabTexture_TexelSize]
Vector 1 [_BumpMapOffset]
Float 2 [_BumpAmt]
SetTexture 0 [_GrabTexture] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
OPTION ARB_fog_exp2;
OPTION ARB_fragment_program_shadow;
PARAM c[4] = { program.local[0..2],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R1, fragment.texcoord[2], texture[2], 2D;
ADD R0.xy, fragment.texcoord[1], c[1];
TEX R0.yw, R0, texture[1], 2D;
MAD R0.xy, R0.wyzw, c[3].x, -c[3].y;
MUL R0.xy, R0, c[1].z;
MUL R0.xy, R0, c[2].x;
MUL R0.xy, R0, c[0];
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R0.zw, fragment.texcoord[0];
TXP R0, R0, texture[0], SHADOW2D;
MUL result.color, R0, R1;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
// Stats: 10 math, 3 textures
Vector 0 [_GrabTexture_TexelSize]
Vector 1 [_BumpMapOffset]
Float 2 [_BumpAmt]
SetTexture 0 [_GrabTexture] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s1
dcl_2d s0
dcl_2d s2
def c3, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
add r0.xy, t1, c1
mov r1.zw, t0
texld r0, r0, s1
mov r0.x, r0.w
mad_pp r0.xy, r0, c3.x, c3.y
mul_pp r0.xy, r0, c1.z
mul r0.xy, r0, c2.x
mul r0.xy, r0, c0
mad r1.xy, r0, t0.z, t0
texld r0, t2, s2
texldp r1, r1, s0
mul_pp r0, r1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
// Stats: 8 math, 3 textures
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 64
Vector 16 [_GrabTexture_TexelSize]
Vector 32 [_BumpMapOffset]
Float 48 [_BumpAmt]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjjkimcmahnlkkcciokgceoncipkoihdgabaaaaaabmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccmacaaaaeaaaaaaailaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaaidcaabaaaaaaaaaaa
egbabaaaacaaaaaaegiacaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgikcaaaaaaaaaaaacaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaadaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaah
pccabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 8 math, 3 textures
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 64
Vector 16 [_GrabTexture_TexelSize]
Vector 32 [_BumpMapOffset]
Float 48 [_BumpAmt]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedimgdkohmmgjhdndkcdcpnbdfnfclckpaabaaaaaalaaeaaaaaeaaaaaa
daaaaaaamaabaaaapeadaaaahmaeaaaaebgpgodjiiabaaaaiiabaaaaaaacpppp
emabaaaadmaaaaaaabaadaaaaaaadmaaaaaadmaaadaaceaaaaaadmaaabaaaaaa
aaababaaacacacaaaaaaabaaadaaaaaaaaaaaaaaaaacppppfbaaaaafadaaapka
aaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapka
bpaaaaacaaaaaajaacaiapkaacaaaaadaaaaadiaabaaoelaabaaoekaecaaaaad
aaaacpiaaaaaoeiaabaioekaaeaaaaaeabaacbiaaaaappiaadaaaakaadaaffka
aeaaaaaeabaacciaaaaaffiaadaaaakaadaaffkaafaaaaadaaaacdiaabaaoeia
abaakkkaafaaaaadaaaaadiaaaaaoeiaacaaaakaafaaaaadaaaaadiaaaaaoeia
aaaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakklaaaaaoelaagaaaaacaaaaaeia
aaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeiaabaaaaacabaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeiaacaioeka
afaaaaadaaaacpiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefccmacaaaaeaaaaaaailaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaaaaaaaidcaabaaaaaaaaaaaegbabaaaacaaaaaa
egiacaaaaaaaaaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaa
kgikcaaaaaaaaaaaacaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaa
agiacaaaaaaaaaaaadaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaabaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
kgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "gles " {
"!!GLES"
}
SubProgram "flash " {
Vector 0 [_GrabTexture_TexelSize]
Vector 1 [_BumpMapOffset]
Float 2 [_BumpAmt]
SetTexture 0 [_GrabTexture] 2D 0
SetTexture 1 [_BumpMap] 2D 1
SetTexture 2 [_MainTex] 2D 2
"agal_ps
c3 2.0 -1.0 0.0 0.0
[bc]
abaaaaaaaaaaadacabaaaaoeaeaaaaaaabaaaaoeabaaaaaa add r0.xy, v1, c1
aaaaaaaaabaaamacaaaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r1.zw, v0
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
aaaaaaaaaaaaabacaaaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.x, r0.w
adaaaaaaaaaaadacaaaaaafeacaaaaaaadaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c3.x
abaaaaaaaaaaadacaaaaaafeacaaaaaaadaaaaffabaaaaaa add r0.xy, r0.xyyy, c3.y
adaaaaaaaaaaadacaaaaaafeacaaaaaaabaaaakkabaaaaaa mul r0.xy, r0.xyyy, c1.z
adaaaaaaaaaaadacaaaaaafeacaaaaaaacaaaaaaabaaaaaa mul r0.xy, r0.xyyy, c2.x
adaaaaaaaaaaadacaaaaaafeacaaaaaaaaaaaaoeabaaaaaa mul r0.xy, r0.xyyy, c0
adaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaakkaeaaaaaa mul r1.xy, r0.xyyy, v0.z
abaaaaaaabaaadacabaaaafeacaaaaaaaaaaaaoeaeaaaaaa add r1.xy, r1.xyyy, v0
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v2, s2 <2d wrap linear point>
aeaaaaaaacaaapacabaaaaoeacaaaaaaabaaaappacaaaaaa div r2, r1, r1.w
ciaaaaaaabaaapacacaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r2.xyyy, s0 <2d wrap linear point>
adaaaaaaaaaaapacabaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r0, r1, r0
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}
SubProgram "glesdesktop " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent+100" "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "QUEUE"="Transparent+100" "RenderType"="Opaque" }
  Cull Front
  Blend DstColor Zero
  SetTexture [_MainTex] { combine texture }
 }
}
}