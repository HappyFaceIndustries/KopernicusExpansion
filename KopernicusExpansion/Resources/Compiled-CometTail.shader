// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 93.6KB

// Skipping shader variants that would not be included into build of current scene.

Shader "KopernicusExpansion/CometTail" {
Properties {
 _TintColor ("Color", Color) = (0.5,0.5,0.5,1)
 _Evolution ("Time", Float) = 0
 _RimPower ("Rim Power", Range(0,4)) = 0.01
 _Distortion ("Distortion", Range(0,0.5)) = 0.2
 _ZDistortion ("Z Distortion", Range(0,1)) = 0.1
 _AlphaDistortion ("Alpha Distortion", Range(0,1)) = 0.2
 _Frequency ("Frequency", Float) = 1
 _Lacunarity ("Lacunarity", Float) = 1.3
 _Gain ("Gain", Float) = 0.9
 _PermTable2D ("2D Perm Table", 2D) = "white" { }
 _Gradient3D ("3D Gradient", 2D) = "white" { }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }


 // Stats for Vertex shader:
 //       d3d11 : 41 avg math (29..53)
 //        d3d9 : 40 avg math (25..55)
 // Stats for Fragment shader:
 //       d3d11 : 73 math, 1 branch
 //        d3d9 : 89 math, 18 texture, 5 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="Transparent" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 41045
Program "vp" {
SubProgram "d3d9 " {
// Stats: 25 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 9 [unity_SHAb]
Vector 8 [unity_SHAg]
Vector 7 [unity_SHAr]
Vector 12 [unity_SHBb]
Vector 11 [unity_SHBg]
Vector 10 [unity_SHBr]
Vector 13 [unity_SHC]
"vs_3_0
def c14, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mul r0.xyz, c5, v1.y
mad r0.xyz, c4, v1.x, r0
mad r0.xyz, c6, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
dp4 r3.x, c10, r2
dp4 r3.y, c11, r2
dp4 r3.z, c12, r2
mad r0.xyz, c13, r0.x, r3
mov r1.w, c14.x
dp4 r2.x, c7, r1
dp4 r2.y, c8, r1
dp4 r2.z, c9, r1
mov o1.xyz, r1
add o3.xyz, r0, r2
mov o2.xyz, v0
mov o4, c14.y

"
}
SubProgram "d3d11 " {
// Stats: 29 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
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
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 256 [_World2Object]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedbaaoamiabnmokgibmjplnkefchhnccgoabaaaaaafeagaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefciiaeaaaaeaaaabaaccabaaaafjaaaaaeegiocaaaaaaaaaaa
cnaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaaaaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaaaaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaaaaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaaaaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaaaaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaaaaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhccabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadgaaaaaipccabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 55 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHAb]
Vector 19 [unity_SHAg]
Vector 18 [unity_SHAr]
Vector 23 [unity_SHBb]
Vector 22 [unity_SHBg]
Vector 21 [unity_SHBr]
Vector 24 [unity_SHC]
"vs_3_0
def c25, 1, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord4 o4
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
dp4 r0.x, c9, v0
add r0, -r0.x, c15
mul r1, r0, r0
dp4 r2.x, c8, v0
add r2, -r2.x, c14
mad r1, r2, r2, r1
dp4 r3.x, c10, v0
add r3, -r3.x, c16
mad r1, r3, r3, r1
rsq r4.x, r1.x
rsq r4.y, r1.y
rsq r4.z, r1.z
rsq r4.w, r1.w
mov r5.x, c25.x
mad r1, r1, c17, r5.x
mul r5.xyz, c12, v1.y
mad r5.xyz, c11, v1.x, r5
mad r5.xyz, c13, v1.z, r5
nrm r6.xyz, r5
mul r0, r0, r6.y
mad r0, r2, r6.x, r0
mad r0, r3, r6.z, r0
mul r0, r4, r0
max r0, r0, c25.y
rcp r2.x, r1.x
rcp r2.y, r1.y
rcp r2.z, r1.z
rcp r2.w, r1.w
mul r0, r0, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r6.y, r6.y
mad r0.w, r6.x, r6.x, -r0.w
mul r1, r6.yzzx, r6.xyzz
dp4 r2.x, c21, r1
dp4 r2.y, c22, r1
dp4 r2.z, c23, r1
mad r1.xyz, c24, r0.w, r2
mov r6.w, c25.x
dp4 r2.x, c18, r6
dp4 r2.y, c19, r6
dp4 r2.z, c20, r6
mov o1.xyz, r6
add r1.xyz, r1, r2
add o3.xyz, r0, r1
mov o2.xyz, v0
mov o4, c25.y

"
}
SubProgram "d3d11 " {
// Stats: 53 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
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
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityLighting" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedlanajfapfnijcfbedhjniobjbpmkacfaabaaaaaakeajaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcniahaaaaeaaaabaapgabaaaafjaaaaaeegiocaaaaaaaaaaa
cnaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaa
gfaaaaadpccabaaaaeaaaaaagiaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaa
akiacaaaabaaaaaabcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaa
bkiacaaaabaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaa
abaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaafhccabaaaacaaaaaaegbcbaaaaaaaaaaadiaaaaahbcaabaaa
abaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakbcaabaaaabaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaiaebaaaaaaabaaaaaadiaaaaah
pcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
adaaaaaaegiocaaaaaaaaaaacjaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaa
adaaaaaaegiocaaaaaaaaaaackaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaa
adaaaaaaegiocaaaaaaaaaaaclaaaaaaegaobaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaaaaaaaaacmaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaaaaaaaaacgaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaaaaaaaaachaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaaaaaaaaaciaaaaaaegaobaaaaaaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
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
aaaaaaaaaaaaaaahhccabaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaipccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}
}
Program "fp" {
SubProgram "d3d9 " {
// Stats: 89 math, 18 textures, 5 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Matrix 0 [_Object2World] 3
Float 12 [_AlphaDistortion]
Float 10 [_Distortion]
Float 8 [_Evolution]
Float 4 [_Frequency]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Float 9 [_RimPower]
Vector 7 [_TintColor]
Vector 3 [_WorldSpaceCameraPos]
Float 11 [_ZDistortion]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
def c13, 2, 3, 1, 0
def c14, 2, -1, 0, 0
def c15, 0, 0, 0.5, 0.00390625
defi i0, 5, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord1 v1.xyz
dcl_texcoord2_pp v2.xyz
dcl_2d s0
dcl_2d s1
mul r0.z, c11.x, v1.z
mov r0.xy, v1
mov r1.xy, r0
mov r2.x, c11.x
mad r1.z, v1.z, r2.x, c8.x
mov r2.w, c15.x
mov r3.x, c4.x
mov r3.y, c15.z
mov r0.w, c15.x
rep i0
mul r4.xyz, r1, r3.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c15.w
frc r5.xyz, r5_abs
cmp r2.xyz, r4, r5, -r5
mad r4.xyz, r1, r3.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.x, c13.y
mul r5.xyz, r5, r6
texldl r6, r2.xyww, s0
add r6, r2.z, r6
mul r7, r6.x, c13.zwww
texldl r8, r7, s1
mad r2.xyz, r8, c14.x, c14.y
dp3 r1.w, r2, r4
add r2.xyz, r4, c14.yzzw
mul r8, r6.zxxx, c13.zwww
texldl r9, r8, s1
mad r9.xyz, r9, c14.x, c14.y
dp3 r2.x, r9, r2
lrp r3.z, r5.x, r2.x, r1.w
add r2.xyz, r4, c14.zyzw
mul r9, r6.yxxx, c13.zwww
texldl r10, r9, s1
mad r10.xyz, r10, c14.x, c14.y
dp3 r1.w, r10, r2
add r2.xyz, r4, c14.yyzw
mul r6, r6.wxxx, c13.zwww
texldl r10, r6, s1
mad r10.xyz, r10, c14.x, c14.y
dp3 r2.x, r10, r2
lrp r3.w, r5.x, r2.x, r1.w
lrp r1.w, r5.y, r3.w, r3.z
add r2.xyz, r4, c14.zzyw
add r7, r7, c15.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c14.x, c14.y
dp3 r2.x, r7, r2
add r7.xyz, r4, c14.yzyw
add r8, r8, c15.wxxx
texldl r8, r8, s1
mad r8.xyz, r8, c14.x, c14.y
dp3 r2.y, r8, r7
lrp r3.z, r5.x, r2.y, r2.x
add r2.xyz, r4, c14.zyyw
add r7, r9, c15.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c14.x, c14.y
dp3 r2.x, r7, r2
add r4.xyz, r4, -c13.z
add r6, r6, c15.wxxx
texldl r6, r6, s1
mad r6.xyz, r6, c14.x, c14.y
dp3 r2.y, r6, r4
lrp r3.w, r5.x, r2.y, r2.x
lrp r2.x, r5.y, r3.w, r3.z
lrp r3.z, r5.z, r2.x, r1.w
mad r0.w, r3.z, r3.y, r0.w
mul r3.x, r3.x, c5.x
mul r3.y, r3.y, c6.x
endrep
add r1, r0.w, -c7
mov r2, c7
mad_pp r3.xyz, c10.x, r1, r2
dp3 r1.x, c0, r0
dp3 r1.y, c1, r0
dp3 r1.z, c2, r0
add r0.xyz, -r1, c3
nrm r1.xyz, r0
dp3_sat_pp r0.x, r1, v0
dp3_sat_pp r0.y, r1, -v0
max_pp r1.x, r0.x, r0.y
mad r0.x, c12.x, r1.w, r2.w
pow r0.y, r1.x, c9.x
mul_pp r3.w, r0.y, r0.x
mul_pp r0.xyz, r3, v2
mov r0.w, c15.x
add_pp oC0, r3, r0

"
}
SubProgram "d3d11 " {
// Stats: 73 math, 1 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
ConstBuffer "$Globals" 208
Float 144 [_Frequency]
Float 148 [_Lacunarity]
Float 152 [_Gain]
Vector 160 [_TintColor]
Float 176 [_Evolution]
Float 180 [_RimPower]
Float 184 [_Distortion]
Float 188 [_ZDistortion]
Float 192 [_AlphaDistortion]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 352
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"ps_4_0
root12:acadacaa
eefiecedojnkgbpdnecelgipnjbcplhbhimcndjcabaaaaaaaaapaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
aeaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpianaaaaeaaaaaaahoadaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaa
fjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaaacaaaaaaapaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacamaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaa
acaaaaaadkiacaaaaaaaaaaaalaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaa
acaaaaaadcaaaaalecaabaaaabaaaaaackbabaaaacaaaaaadkiacaaaaaaaaaaa
alaaaaaaakiacaaaaaaaaaaaalaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaaakiacaaa
aaaaaaaaajaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaai
gcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaab
cbaaaaahicaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaead
dkaabaaaaaaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaa
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
eiaaaaalpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaa
iganbaaaakaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaajaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
adaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
alaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
alaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
bcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaajaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaa
agabbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaa
aiaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaeiaaaaalpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaa
egacbaaaahaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaa
abaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
ajaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaa
dkaabaaaaaaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaidcaabaaa
agaaaaaaegaabaaaagaaaaaajgifcaaaaaaaaaaaajaaaaaaboaaaaahecaabaaa
aaaaaaaackaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabaaaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaakaaaaaadcaaaaal
hcaabaaaacaaaaaakgikcaaaaaaaaaaaalaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaakaaaaaadiaaaaaiocaabaaaaaaaaaaafgbfbaaaacaaaaaaagijcaaa
acaaaaaaanaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaacaaaaaaamaaaaaa
agbabaaaacaaaaaafgaobaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaaoaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaabacaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaa
abaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaa
dcaaaaalccaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaakaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaa
bjaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahicaabaaaacaaaaaa
akaabaaaaaaaaaaabkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
acaaaaaaegbcbaaaadaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahpccabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadoaaaaab
"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 22 math
 //        d3d9 : 14 math
 // Stats for Fragment shader:
 //       d3d11 : 71 math, 1 branch
 //        d3d9 : 86 math, 18 texture, 5 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha One
  ColorMask RGB
  GpuProgramID 76894
Program "vp" {
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o2.x, c4, v0
dp4 o2.y, c5, v0
dp4 o2.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o1.xyz, r0.w, r0
mov o3.xyz, v0

"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedibmcgejlilblojdeblgmapcjghkpfdkoabaaaaaaamafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfiadaaaaeaaaabaangaaaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaa
egbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o2.x, c4, v0
dp4 o2.y, c5, v0
dp4 o2.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o1.xyz, r0.w, r0
mov o3.xyz, v0

"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedibmcgejlilblojdeblgmapcjghkpfdkoabaaaaaaamafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfiadaaaaeaaaabaangaaaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaa
egbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o2.x, c4, v0
dp4 o2.y, c5, v0
dp4 o2.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o1.xyz, r0.w, r0
mov o3.xyz, v0

"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedibmcgejlilblojdeblgmapcjghkpfdkoabaaaaaaamafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfiadaaaaeaaaabaangaaaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaa
egbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o2.x, c4, v0
dp4 o2.y, c5, v0
dp4 o2.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o1.xyz, r0.w, r0
mov o3.xyz, v0

"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedibmcgejlilblojdeblgmapcjghkpfdkoabaaaaaaamafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfiadaaaaeaaaabaangaaaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaa
egbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 14 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_position o0
dcl_texcoord o1.xyz
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
dp4 o2.x, c4, v0
dp4 o2.y, c5, v0
dp4 o2.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o1.xyz, r0.w, r0
mov o3.xyz, v0

"
}
SubProgram "d3d11 " {
// Stats: 22 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecedibmcgejlilblojdeblgmapcjghkpfdkoabaaaaaaamafaaaaadaaaaaa
cmaaaaaaceabaaaakmabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefcfiadaaaaeaaaabaangaaaaaafjaaaaae
egiocaaaaaaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
gfaaaaadhccabaaaacaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaibcaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
aaaaaaaaakbabaaaacaaaaaaakiacaaaaaaaaaaabcaaaaaadiaaaaaibcaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaabkbabaaaacaaaaaabkiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabaaaaaaadiaaaaaiccaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabbaaaaaadiaaaaaiecaabaaaabaaaaaa
ckbabaaaacaaaaaackiacaaaaaaaaaaabcaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaa
diaaaaahhccabaaaabaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaafhccabaaaadaaaaaa
egbcbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "d3d9 " {
// Stats: 86 math, 18 textures, 5 branches
Keywords { "POINT" }
Matrix 0 [_Object2World] 3
Float 12 [_AlphaDistortion]
Float 10 [_Distortion]
Float 8 [_Evolution]
Float 4 [_Frequency]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Float 9 [_RimPower]
Vector 7 [_TintColor]
Vector 3 [_WorldSpaceCameraPos]
Float 11 [_ZDistortion]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
def c13, 2, 3, 1, 0
def c14, 0, 0, 0.5, 0.00390625
def c15, 2, -1, 0, 0
defi i0, 5, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord2 v1.xyz
dcl_2d s0
dcl_2d s1
mul r0.z, c11.x, v1.z
mov r0.xy, v1
mov r1.xy, r0
mov r2.x, c11.x
mad r1.z, v1.z, r2.x, c8.x
mov r2.w, c14.x
mov r3.x, c4.x
mov r3.y, c14.z
mov r0.w, c14.x
rep i0
mul r4.xyz, r1, r3.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c14.w
frc r5.xyz, r5_abs
cmp r2.xyz, r4, r5, -r5
mad r4.xyz, r1, r3.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.x, c13.y
mul r5.xyz, r5, r6
texldl r6, r2.xyww, s0
add r6, r2.z, r6
mul r7, r6.x, c13.zwww
texldl r8, r7, s1
mad r2.xyz, r8, c15.x, c15.y
dp3 r1.w, r2, r4
add r2.xyz, r4, c15.yzzw
mul r8, r6.zxxx, c13.zwww
texldl r9, r8, s1
mad r9.xyz, r9, c15.x, c15.y
dp3 r2.x, r9, r2
lrp r3.z, r5.x, r2.x, r1.w
add r2.xyz, r4, c15.zyzw
mul r9, r6.yxxx, c13.zwww
texldl r10, r9, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r1.w, r10, r2
add r2.xyz, r4, c15.yyzw
mul r6, r6.wxxx, c13.zwww
texldl r10, r6, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r2.x, r10, r2
lrp r3.w, r5.x, r2.x, r1.w
lrp r1.w, r5.y, r3.w, r3.z
add r2.xyz, r4, c15.zzyw
add r7, r7, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r7.xyz, r4, c15.yzyw
add r8, r8, c14.wxxx
texldl r8, r8, s1
mad r8.xyz, r8, c15.x, c15.y
dp3 r2.y, r8, r7
lrp r3.z, r5.x, r2.y, r2.x
add r2.xyz, r4, c15.zyyw
add r7, r9, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r4.xyz, r4, -c13.z
add r6, r6, c14.wxxx
texldl r6, r6, s1
mad r6.xyz, r6, c15.x, c15.y
dp3 r2.y, r6, r4
lrp r3.w, r5.x, r2.y, r2.x
lrp r2.x, r5.y, r3.w, r3.z
lrp r3.z, r5.z, r2.x, r1.w
mad r0.w, r3.z, r3.y, r0.w
mul r3.x, r3.x, c5.x
mul r3.y, r3.y, c6.x
endrep
add r1, r0.w, -c7
mov r2, c7
mad_pp oC0.xyz, c10.x, r1, r2
dp3 r1.x, c0, r0
dp3 r1.y, c1, r0
dp3 r1.z, c2, r0
add r0.xyz, -r1, c3
nrm r1.xyz, r0
dp3_sat_pp r0.x, r1, v0
dp3_sat_pp r0.y, r1, -v0
max_pp r1.x, r0.x, r0.y
mad r0.x, c12.x, r1.w, r2.w
pow r0.y, r1.x, c9.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 71 math, 1 branches
Keywords { "POINT" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
ConstBuffer "$Globals" 272
Float 208 [_Frequency]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Vector 224 [_TintColor]
Float 240 [_Evolution]
Float 244 [_RimPower]
Float 248 [_Distortion]
Float 252 [_ZDistortion]
Float 256 [_AlphaDistortion]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 352
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"ps_4_0
root12:acadacaa
eefiecedjkgbgiocdebaljdcpfnmjijibmclocgjabaaaaaajaaoaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaanaaaaeaaaaaaagiadaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaaadaaaaaa
dkiacaaaaaaaaaaaapaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dcaaaaalecaabaaaabaaaaaackbabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaa
akiacaaaaaaaaaaaapaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaaakiacaaaaaaaaaaa
anaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaa
ebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaag
hcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaa
egacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaak
hcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaa
ahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaa
dcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaa
akaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaajaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaabkaabaaaajaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
eiaaaaalpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaajaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaidcaabaaaagaaaaaa
egaabaaaagaaaaaajgifcaaaaaaaaaaaanaaaaaaboaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabaaaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaaoaaaaaadcaaaaalhccabaaa
aaaaaaaakgikcaaaaaaaaaaaapaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaiocaabaaaaaaaaaaafgbfbaaaadaaaaaaagijcaaaacaaaaaa
anaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaacaaaaaaamaaaaaaagbabaaa
adaaaaaafgaobaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaa
bacaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaaoaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 86 math, 18 textures, 5 branches
Keywords { "DIRECTIONAL" }
Matrix 0 [_Object2World] 3
Float 12 [_AlphaDistortion]
Float 10 [_Distortion]
Float 8 [_Evolution]
Float 4 [_Frequency]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Float 9 [_RimPower]
Vector 7 [_TintColor]
Vector 3 [_WorldSpaceCameraPos]
Float 11 [_ZDistortion]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
def c13, 2, 3, 1, 0
def c14, 0, 0, 0.5, 0.00390625
def c15, 2, -1, 0, 0
defi i0, 5, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord2 v1.xyz
dcl_2d s0
dcl_2d s1
mul r0.z, c11.x, v1.z
mov r0.xy, v1
mov r1.xy, r0
mov r2.x, c11.x
mad r1.z, v1.z, r2.x, c8.x
mov r2.w, c14.x
mov r3.x, c4.x
mov r3.y, c14.z
mov r0.w, c14.x
rep i0
mul r4.xyz, r1, r3.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c14.w
frc r5.xyz, r5_abs
cmp r2.xyz, r4, r5, -r5
mad r4.xyz, r1, r3.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.x, c13.y
mul r5.xyz, r5, r6
texldl r6, r2.xyww, s0
add r6, r2.z, r6
mul r7, r6.x, c13.zwww
texldl r8, r7, s1
mad r2.xyz, r8, c15.x, c15.y
dp3 r1.w, r2, r4
add r2.xyz, r4, c15.yzzw
mul r8, r6.zxxx, c13.zwww
texldl r9, r8, s1
mad r9.xyz, r9, c15.x, c15.y
dp3 r2.x, r9, r2
lrp r3.z, r5.x, r2.x, r1.w
add r2.xyz, r4, c15.zyzw
mul r9, r6.yxxx, c13.zwww
texldl r10, r9, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r1.w, r10, r2
add r2.xyz, r4, c15.yyzw
mul r6, r6.wxxx, c13.zwww
texldl r10, r6, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r2.x, r10, r2
lrp r3.w, r5.x, r2.x, r1.w
lrp r1.w, r5.y, r3.w, r3.z
add r2.xyz, r4, c15.zzyw
add r7, r7, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r7.xyz, r4, c15.yzyw
add r8, r8, c14.wxxx
texldl r8, r8, s1
mad r8.xyz, r8, c15.x, c15.y
dp3 r2.y, r8, r7
lrp r3.z, r5.x, r2.y, r2.x
add r2.xyz, r4, c15.zyyw
add r7, r9, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r4.xyz, r4, -c13.z
add r6, r6, c14.wxxx
texldl r6, r6, s1
mad r6.xyz, r6, c15.x, c15.y
dp3 r2.y, r6, r4
lrp r3.w, r5.x, r2.y, r2.x
lrp r2.x, r5.y, r3.w, r3.z
lrp r3.z, r5.z, r2.x, r1.w
mad r0.w, r3.z, r3.y, r0.w
mul r3.x, r3.x, c5.x
mul r3.y, r3.y, c6.x
endrep
add r1, r0.w, -c7
mov r2, c7
mad_pp oC0.xyz, c10.x, r1, r2
dp3 r1.x, c0, r0
dp3 r1.y, c1, r0
dp3 r1.z, c2, r0
add r0.xyz, -r1, c3
nrm r1.xyz, r0
dp3_sat_pp r0.x, r1, v0
dp3_sat_pp r0.y, r1, -v0
max_pp r1.x, r0.x, r0.y
mad r0.x, c12.x, r1.w, r2.w
pow r0.y, r1.x, c9.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 71 math, 1 branches
Keywords { "DIRECTIONAL" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
ConstBuffer "$Globals" 208
Float 144 [_Frequency]
Float 148 [_Lacunarity]
Float 152 [_Gain]
Vector 160 [_TintColor]
Float 176 [_Evolution]
Float 180 [_RimPower]
Float 184 [_Distortion]
Float 188 [_ZDistortion]
Float 192 [_AlphaDistortion]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 352
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"ps_4_0
root12:acadacaa
eefiecedahagjobnlffhdlpmlkefhoiclklkdjfaabaaaaaajaaoaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaanaaaaeaaaaaaagiadaaaafjaaaaaeegiocaaa
aaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaaadaaaaaa
dkiacaaaaaaaaaaaalaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dcaaaaalecaabaaaabaaaaaackbabaaaadaaaaaadkiacaaaaaaaaaaaalaaaaaa
akiacaaaaaaaaaaaalaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaaakiacaaaaaaaaaaa
ajaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaa
ebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaag
hcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaa
egacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaak
hcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaa
ahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaa
dcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaa
akaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaajaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaabkaabaaaajaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
eiaaaaalpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaajaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaidcaabaaaagaaaaaa
egaabaaaagaaaaaajgifcaaaaaaaaaaaajaaaaaaboaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabaaaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaakaaaaaadcaaaaalhccabaaa
aaaaaaaakgikcaaaaaaaaaaaalaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
akaaaaaadiaaaaaiocaabaaaaaaaaaaafgbfbaaaadaaaaaaagijcaaaacaaaaaa
anaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaacaaaaaaamaaaaaaagbabaaa
adaaaaaafgaobaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaa
bacaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaaakiacaaaaaaaaaaaamaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaakaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaalaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 86 math, 18 textures, 5 branches
Keywords { "SPOT" }
Matrix 0 [_Object2World] 3
Float 12 [_AlphaDistortion]
Float 10 [_Distortion]
Float 8 [_Evolution]
Float 4 [_Frequency]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Float 9 [_RimPower]
Vector 7 [_TintColor]
Vector 3 [_WorldSpaceCameraPos]
Float 11 [_ZDistortion]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
def c13, 2, 3, 1, 0
def c14, 0, 0, 0.5, 0.00390625
def c15, 2, -1, 0, 0
defi i0, 5, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord2 v1.xyz
dcl_2d s0
dcl_2d s1
mul r0.z, c11.x, v1.z
mov r0.xy, v1
mov r1.xy, r0
mov r2.x, c11.x
mad r1.z, v1.z, r2.x, c8.x
mov r2.w, c14.x
mov r3.x, c4.x
mov r3.y, c14.z
mov r0.w, c14.x
rep i0
mul r4.xyz, r1, r3.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c14.w
frc r5.xyz, r5_abs
cmp r2.xyz, r4, r5, -r5
mad r4.xyz, r1, r3.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.x, c13.y
mul r5.xyz, r5, r6
texldl r6, r2.xyww, s0
add r6, r2.z, r6
mul r7, r6.x, c13.zwww
texldl r8, r7, s1
mad r2.xyz, r8, c15.x, c15.y
dp3 r1.w, r2, r4
add r2.xyz, r4, c15.yzzw
mul r8, r6.zxxx, c13.zwww
texldl r9, r8, s1
mad r9.xyz, r9, c15.x, c15.y
dp3 r2.x, r9, r2
lrp r3.z, r5.x, r2.x, r1.w
add r2.xyz, r4, c15.zyzw
mul r9, r6.yxxx, c13.zwww
texldl r10, r9, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r1.w, r10, r2
add r2.xyz, r4, c15.yyzw
mul r6, r6.wxxx, c13.zwww
texldl r10, r6, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r2.x, r10, r2
lrp r3.w, r5.x, r2.x, r1.w
lrp r1.w, r5.y, r3.w, r3.z
add r2.xyz, r4, c15.zzyw
add r7, r7, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r7.xyz, r4, c15.yzyw
add r8, r8, c14.wxxx
texldl r8, r8, s1
mad r8.xyz, r8, c15.x, c15.y
dp3 r2.y, r8, r7
lrp r3.z, r5.x, r2.y, r2.x
add r2.xyz, r4, c15.zyyw
add r7, r9, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r4.xyz, r4, -c13.z
add r6, r6, c14.wxxx
texldl r6, r6, s1
mad r6.xyz, r6, c15.x, c15.y
dp3 r2.y, r6, r4
lrp r3.w, r5.x, r2.y, r2.x
lrp r2.x, r5.y, r3.w, r3.z
lrp r3.z, r5.z, r2.x, r1.w
mad r0.w, r3.z, r3.y, r0.w
mul r3.x, r3.x, c5.x
mul r3.y, r3.y, c6.x
endrep
add r1, r0.w, -c7
mov r2, c7
mad_pp oC0.xyz, c10.x, r1, r2
dp3 r1.x, c0, r0
dp3 r1.y, c1, r0
dp3 r1.z, c2, r0
add r0.xyz, -r1, c3
nrm r1.xyz, r0
dp3_sat_pp r0.x, r1, v0
dp3_sat_pp r0.y, r1, -v0
max_pp r1.x, r0.x, r0.y
mad r0.x, c12.x, r1.w, r2.w
pow r0.y, r1.x, c9.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 71 math, 1 branches
Keywords { "SPOT" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
ConstBuffer "$Globals" 272
Float 208 [_Frequency]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Vector 224 [_TintColor]
Float 240 [_Evolution]
Float 244 [_RimPower]
Float 248 [_Distortion]
Float 252 [_ZDistortion]
Float 256 [_AlphaDistortion]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 352
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"ps_4_0
root12:acadacaa
eefiecedjkgbgiocdebaljdcpfnmjijibmclocgjabaaaaaajaaoaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaanaaaaeaaaaaaagiadaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaaadaaaaaa
dkiacaaaaaaaaaaaapaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dcaaaaalecaabaaaabaaaaaackbabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaa
akiacaaaaaaaaaaaapaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaaakiacaaaaaaaaaaa
anaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaa
ebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaag
hcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaa
egacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaak
hcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaa
ahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaa
dcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaa
akaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaajaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaabkaabaaaajaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
eiaaaaalpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaajaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaidcaabaaaagaaaaaa
egaabaaaagaaaaaajgifcaaaaaaaaaaaanaaaaaaboaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabaaaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaaoaaaaaadcaaaaalhccabaaa
aaaaaaaakgikcaaaaaaaaaaaapaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaiocaabaaaaaaaaaaafgbfbaaaadaaaaaaagijcaaaacaaaaaa
anaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaacaaaaaaamaaaaaaagbabaaa
adaaaaaafgaobaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaa
bacaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaaoaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 86 math, 18 textures, 5 branches
Keywords { "POINT_COOKIE" }
Matrix 0 [_Object2World] 3
Float 12 [_AlphaDistortion]
Float 10 [_Distortion]
Float 8 [_Evolution]
Float 4 [_Frequency]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Float 9 [_RimPower]
Vector 7 [_TintColor]
Vector 3 [_WorldSpaceCameraPos]
Float 11 [_ZDistortion]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
def c13, 2, 3, 1, 0
def c14, 0, 0, 0.5, 0.00390625
def c15, 2, -1, 0, 0
defi i0, 5, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord2 v1.xyz
dcl_2d s0
dcl_2d s1
mul r0.z, c11.x, v1.z
mov r0.xy, v1
mov r1.xy, r0
mov r2.x, c11.x
mad r1.z, v1.z, r2.x, c8.x
mov r2.w, c14.x
mov r3.x, c4.x
mov r3.y, c14.z
mov r0.w, c14.x
rep i0
mul r4.xyz, r1, r3.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c14.w
frc r5.xyz, r5_abs
cmp r2.xyz, r4, r5, -r5
mad r4.xyz, r1, r3.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.x, c13.y
mul r5.xyz, r5, r6
texldl r6, r2.xyww, s0
add r6, r2.z, r6
mul r7, r6.x, c13.zwww
texldl r8, r7, s1
mad r2.xyz, r8, c15.x, c15.y
dp3 r1.w, r2, r4
add r2.xyz, r4, c15.yzzw
mul r8, r6.zxxx, c13.zwww
texldl r9, r8, s1
mad r9.xyz, r9, c15.x, c15.y
dp3 r2.x, r9, r2
lrp r3.z, r5.x, r2.x, r1.w
add r2.xyz, r4, c15.zyzw
mul r9, r6.yxxx, c13.zwww
texldl r10, r9, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r1.w, r10, r2
add r2.xyz, r4, c15.yyzw
mul r6, r6.wxxx, c13.zwww
texldl r10, r6, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r2.x, r10, r2
lrp r3.w, r5.x, r2.x, r1.w
lrp r1.w, r5.y, r3.w, r3.z
add r2.xyz, r4, c15.zzyw
add r7, r7, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r7.xyz, r4, c15.yzyw
add r8, r8, c14.wxxx
texldl r8, r8, s1
mad r8.xyz, r8, c15.x, c15.y
dp3 r2.y, r8, r7
lrp r3.z, r5.x, r2.y, r2.x
add r2.xyz, r4, c15.zyyw
add r7, r9, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r4.xyz, r4, -c13.z
add r6, r6, c14.wxxx
texldl r6, r6, s1
mad r6.xyz, r6, c15.x, c15.y
dp3 r2.y, r6, r4
lrp r3.w, r5.x, r2.y, r2.x
lrp r2.x, r5.y, r3.w, r3.z
lrp r3.z, r5.z, r2.x, r1.w
mad r0.w, r3.z, r3.y, r0.w
mul r3.x, r3.x, c5.x
mul r3.y, r3.y, c6.x
endrep
add r1, r0.w, -c7
mov r2, c7
mad_pp oC0.xyz, c10.x, r1, r2
dp3 r1.x, c0, r0
dp3 r1.y, c1, r0
dp3 r1.z, c2, r0
add r0.xyz, -r1, c3
nrm r1.xyz, r0
dp3_sat_pp r0.x, r1, v0
dp3_sat_pp r0.y, r1, -v0
max_pp r1.x, r0.x, r0.y
mad r0.x, c12.x, r1.w, r2.w
pow r0.y, r1.x, c9.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 71 math, 1 branches
Keywords { "POINT_COOKIE" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
ConstBuffer "$Globals" 272
Float 208 [_Frequency]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Vector 224 [_TintColor]
Float 240 [_Evolution]
Float 244 [_RimPower]
Float 248 [_Distortion]
Float 252 [_ZDistortion]
Float 256 [_AlphaDistortion]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 352
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"ps_4_0
root12:acadacaa
eefiecedjkgbgiocdebaljdcpfnmjijibmclocgjabaaaaaajaaoaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaanaaaaeaaaaaaagiadaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaaadaaaaaa
dkiacaaaaaaaaaaaapaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dcaaaaalecaabaaaabaaaaaackbabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaa
akiacaaaaaaaaaaaapaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaaakiacaaaaaaaaaaa
anaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaa
ebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaag
hcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaa
egacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaak
hcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaa
ahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaa
dcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaa
akaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaajaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaabkaabaaaajaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
eiaaaaalpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaajaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaidcaabaaaagaaaaaa
egaabaaaagaaaaaajgifcaaaaaaaaaaaanaaaaaaboaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabaaaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaaoaaaaaadcaaaaalhccabaaa
aaaaaaaakgikcaaaaaaaaaaaapaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaiocaabaaaaaaaaaaafgbfbaaaadaaaaaaagijcaaaacaaaaaa
anaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaacaaaaaaamaaaaaaagbabaaa
adaaaaaafgaobaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaa
bacaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaaoaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 86 math, 18 textures, 5 branches
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_Object2World] 3
Float 12 [_AlphaDistortion]
Float 10 [_Distortion]
Float 8 [_Evolution]
Float 4 [_Frequency]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Float 9 [_RimPower]
Vector 7 [_TintColor]
Vector 3 [_WorldSpaceCameraPos]
Float 11 [_ZDistortion]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
"ps_3_0
def c13, 2, 3, 1, 0
def c14, 0, 0, 0.5, 0.00390625
def c15, 2, -1, 0, 0
defi i0, 5, 0, 0, 0
dcl_texcoord_pp v0.xyz
dcl_texcoord2 v1.xyz
dcl_2d s0
dcl_2d s1
mul r0.z, c11.x, v1.z
mov r0.xy, v1
mov r1.xy, r0
mov r2.x, c11.x
mad r1.z, v1.z, r2.x, c8.x
mov r2.w, c14.x
mov r3.x, c4.x
mov r3.y, c14.z
mov r0.w, c14.x
rep i0
mul r4.xyz, r1, r3.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c14.w
frc r5.xyz, r5_abs
cmp r2.xyz, r4, r5, -r5
mad r4.xyz, r1, r3.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.x, c13.y
mul r5.xyz, r5, r6
texldl r6, r2.xyww, s0
add r6, r2.z, r6
mul r7, r6.x, c13.zwww
texldl r8, r7, s1
mad r2.xyz, r8, c15.x, c15.y
dp3 r1.w, r2, r4
add r2.xyz, r4, c15.yzzw
mul r8, r6.zxxx, c13.zwww
texldl r9, r8, s1
mad r9.xyz, r9, c15.x, c15.y
dp3 r2.x, r9, r2
lrp r3.z, r5.x, r2.x, r1.w
add r2.xyz, r4, c15.zyzw
mul r9, r6.yxxx, c13.zwww
texldl r10, r9, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r1.w, r10, r2
add r2.xyz, r4, c15.yyzw
mul r6, r6.wxxx, c13.zwww
texldl r10, r6, s1
mad r10.xyz, r10, c15.x, c15.y
dp3 r2.x, r10, r2
lrp r3.w, r5.x, r2.x, r1.w
lrp r1.w, r5.y, r3.w, r3.z
add r2.xyz, r4, c15.zzyw
add r7, r7, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r7.xyz, r4, c15.yzyw
add r8, r8, c14.wxxx
texldl r8, r8, s1
mad r8.xyz, r8, c15.x, c15.y
dp3 r2.y, r8, r7
lrp r3.z, r5.x, r2.y, r2.x
add r2.xyz, r4, c15.zyyw
add r7, r9, c14.wxxx
texldl r7, r7, s1
mad r7.xyz, r7, c15.x, c15.y
dp3 r2.x, r7, r2
add r4.xyz, r4, -c13.z
add r6, r6, c14.wxxx
texldl r6, r6, s1
mad r6.xyz, r6, c15.x, c15.y
dp3 r2.y, r6, r4
lrp r3.w, r5.x, r2.y, r2.x
lrp r2.x, r5.y, r3.w, r3.z
lrp r3.z, r5.z, r2.x, r1.w
mad r0.w, r3.z, r3.y, r0.w
mul r3.x, r3.x, c5.x
mul r3.y, r3.y, c6.x
endrep
add r1, r0.w, -c7
mov r2, c7
mad_pp oC0.xyz, c10.x, r1, r2
dp3 r1.x, c0, r0
dp3 r1.y, c1, r0
dp3 r1.z, c2, r0
add r0.xyz, -r1, c3
nrm r1.xyz, r0
dp3_sat_pp r0.x, r1, v0
dp3_sat_pp r0.y, r1, -v0
max_pp r1.x, r0.x, r0.y
mad r0.x, c12.x, r1.w, r2.w
pow r0.y, r1.x, c9.x
mul_pp oC0.w, r0.y, r0.x

"
}
SubProgram "d3d11 " {
// Stats: 71 math, 1 branches
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
ConstBuffer "$Globals" 272
Float 208 [_Frequency]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Vector 224 [_TintColor]
Float 240 [_Evolution]
Float 244 [_RimPower]
Float 248 [_Distortion]
Float 252 [_ZDistortion]
Float 256 [_AlphaDistortion]
ConstBuffer "UnityPerCamera" 144
Vector 64 [_WorldSpaceCameraPos] 3
ConstBuffer "UnityPerDraw" 352
Matrix 192 [_Object2World]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"ps_4_0
root12:acadacaa
eefiecedjkgbgiocdebaljdcpfnmjijibmclocgjabaaaaaajaaoaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaanaaaaeaaaaaaagiadaaaafjaaaaaeegiocaaa
aaaaaaaabbaaaaaafjaaaaaeegiocaaaabaaaaaaafaaaaaafjaaaaaeegiocaaa
acaaaaaaapaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacamaaaaaadiaaaaaibcaabaaaaaaaaaaackbabaaaadaaaaaa
dkiacaaaaaaaaaaaapaaaaaadgaaaaafdcaabaaaabaaaaaaegbabaaaadaaaaaa
dcaaaaalecaabaaaabaaaaaackbabaaaadaaaaaadkiacaaaaaaaaaaaapaaaaaa
akiacaaaaaaaaaaaapaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaaakiacaaaaaaaaaaa
anaaaaaadgaaaaafccaabaaaagaaaaaaabeaaaaaaaaaaadpdgaaaaaigcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
icaabaaaaaaaaaaackaabaaaaaaaaaaaabeaaaaaafaaaaaaadaaaeaddkaabaaa
aaaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaa
ebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaag
hcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaa
egacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaak
hcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaa
ahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaa
dcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaa
akaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
akaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaajaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaabkaabaaaajaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
aaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaa
akaabaaaajaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
eiaaaaalpcaabaaaaiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaabaaaaaabkaabaaaajaaaaaaakaabaaa
acaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaajaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaajccaabaaaaaaaaaaadkaabaaa
aaaaaaaabkaabaaaagaaaaaabkaabaaaaaaaaaaadiaaaaaidcaabaaaagaaaaaa
egaabaaaagaaaaaajgifcaaaaaaaaaaaanaaaaaaboaaaaahecaabaaaaaaaaaaa
ckaabaaaaaaaaaaaabeaaaaaabaaaaaabgaaaaabaaaaaaajpcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaiaebaaaaaaaaaaaaaaaoaaaaaadcaaaaalhccabaaa
aaaaaaaakgikcaaaaaaaaaaaapaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
aoaaaaaadiaaaaaiocaabaaaaaaaaaaafgbfbaaaadaaaaaaagijcaaaacaaaaaa
anaaaaaadcaaaaakocaabaaaaaaaaaaaagijcaaaacaaaaaaamaaaaaaagbabaaa
adaaaaaafgaobaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaeaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaa
dkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaabacaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaa
bacaaaaibcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaiaebaaaaaaabaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaal
ccaabaaaaaaaaaaaakiacaaaaaaaaaaabaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaaoaaaaaacpaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaaakaabaaaaaaaaaaabkiacaaaaaaaaaaaapaaaaaabjaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaaaaaaaaaaadoaaaaab"
}
}
 }
}
Fallback "Particles/Alpha Blended"
}