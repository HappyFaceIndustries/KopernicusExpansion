// Compiled shader for PC, Mac & Linux Standalone, uncompressed size: 185.3KB

// Skipping shader variants that would not be included into build of current scene.

Shader "KopernicusExpansion/ProceduralGasGiant" {
Properties {
 _MainTex ("Ramp Texture", 2D) = "white" { }
 _Evolution ("Time", Vector) = (0,0,0,0)
 _StormMap ("Storm Map", 2D) = "white" { }
 _StormFrequency ("Storm Frequency", Float) = 5
 _StormDistortion ("Storm Distortion", Range(0,0.1)) = 0.05
 _Distortion ("Distortion", Range(0,0.1)) = 0.02
 _MainFrequency ("Frequency", Float) = 25
 _Lacunarity ("Lacunarity", Float) = 1.3
 _Gain ("Gain", Float) = 0.9
 _PermTable2D ("2D Perm Table", 2D) = "white" { }
 _Gradient3D ("3D Gradient", 2D) = "white" { }
}
SubShader { 
 LOD 200
 Tags { "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }


 // Stats for Vertex shader:
 //       d3d11 : 4 math
 //    d3d11_9x : 4 math
 //        d3d9 : 7 math
 // Stats for Fragment shader:
 //        d3d9 : 1 math
 Pass {
  Tags { "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
  GpuProgramID 879767
Program "vp" {
SubProgram "d3d9 " {
// Stats: 7 math
Bind "vertex" Vertex
Bind "color" Color
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
def c4, 0, 1, 0, 0
dcl_position v0
dcl_color v1
max r0, v1, c4.x
min oD0, r0, c4.y
mad r0, v0.xyzx, c4.yyyx, c4.xxxy
dp4 oPos.x, c0, r0
dp4 oPos.y, c1, r0
dp4 oPos.z, c2, r0
dp4 oPos.w, c3, r0

"
}
SubProgram "d3d11 " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
root12:aaabaaaa
eefiecednnokfampbpcfihidfeohlcgdkabejapiabaaaaaaneabaaaaadaaaaaa
cmaaaaaahmaaaaaanaaaaaaaejfdeheoeiaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaahahaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaaklepfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaadoaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaaedepemep
fcaafdfgfpfaepfdejfeejepeoaaklklfdeieefcpmaaaaaaeaaaabaadpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaaghaaaaaepccabaaaabaaaaaa
abaaaaaagiaaaaacabaaaaaadgcaaaafpccabaaaaaaaaaaaegbobaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaaaaaaaaaipccabaaaabaaaaaaegaobaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
// Stats: 4 math
Bind "vertex" Vertex
Bind "color" Color
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
root12:aaabaaaa
eefiecedcfghaehiflkiadammnbhgoeffaafiaogabaaaaaaneacaaaaaeaaaaaa
daaaaaaacmabaaaadaacaaaaiaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
maaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafafaaapkaaaaaaaaaaaaaiadp
aaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
alaaaaadaaaaapiaabaaoejaafaaaakaakaaaaadaaaaapoaaaaaoeiaafaaffka
afaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeiaacaaaaadaaaaapia
aaaaoeiaaeaaoekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcpmaaaaaaeaaaabaadpaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafpaaaaadhcbabaaaaaaaaaaafpaaaaadpcbabaaa
abaaaaaagfaaaaadpccabaaaaaaaaaaaghaaaaaepccabaaaabaaaaaaabaaaaaa
giaaaaacabaaaaaadgcaaaafpccabaaaaaaaaaaaegbobaaaabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaaaaaaaaaipccabaaaabaaaaaaegaobaaaaaaaaaaa
egiocaaaaaaaaaaaadaaaaaadoaaaaabejfdeheoeiaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaahahaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaafaepfdejfeejepeoaaedepemepfcaakl
epfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaadoaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaa
edepemepfcaafdfgfpfaepfdejfeejepeoaaklkl"
}
}
Program "fp" {
SubProgram "d3d9 " {
// Stats: 1 math
"ps_2_0
dcl v0
mov_pp oC0, v0

"
}
SubProgram "d3d11 " {
"ps_4_0
root12:aaaaaaaa
eefiecedeonnbajhhfbahmkfdfkaicoeamjejkmjabaaaaaapeaaaaaaadaaaaaa
cmaaaaaaiaaaaaaaleaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaadoaaaaaaaaaaaaaaabaaaaaa
adaaaaaaabaaaaaaapaaaaaaedepemepfcaafdfgfpfaepfdejfeejepeoaaklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiaaaaaaeaaaaaaa
aoaaaaaagcbaaaadpcbabaaaaaaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaaf
pccabaaaaaaaaaaaegbobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
"ps_4_0_level_9_1
root12:aaaaaaaa
eefiecedefmlfipfgbcblgegmcbhfjgbphlcgehmabaaaaaaeeabaaaaaeaaaaaa
daaaaaaahmaaaaaalmaaaaaabaabaaaaebgpgodjeeaaaaaaeeaaaaaaaaacpppp
caaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
bpaaaaacaaaaaaiaaaaacplaabaaaaacaaaicpiaaaaaoelappppaaaafdeieefc
diaaaaaaeaaaaaaaaoaaaaaagcbaaaadpcbabaaaaaaaaaaagfaaaaadpccabaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegbobaaaaaaaaaaadoaaaaabejfdeheo
emaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaadoaaaaaaaaaaaaaaabaaaaaaadaaaaaaabaaaaaaapaaaaaaedepemep
fcaafdfgfpfaepfdejfeejepeoaaklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 43 avg math (33..53)
 //        d3d9 : 40 avg math (26..54)
 // Stats for Fragment shader:
 //       d3d11 : 169 math, 2 texture, 2 branch
 //        d3d9 : 204 math, 56 texture, 10 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask RGB
  GpuProgramID 24642
Program "vp" {
SubProgram "d3d9 " {
// Stats: 26 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 14 [_StormMap_ST]
Vector 12 [unity_SHBb]
Vector 11 [unity_SHBg]
Vector 10 [unity_SHBr]
Vector 13 [unity_SHC]
"vs_3_0
def c15, 0, 0, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c14, c14.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
nrm r1.xyz, r0
mul r0.x, r1.y, r1.y
mad r0.x, r1.x, r1.x, -r0.x
mul r2, r1.yzzx, r1.xyzz
mov o2.xyz, r1
dp4 r1.x, c10, r2
dp4 r1.y, c11, r2
dp4 r1.z, c12, r2
mad o5.xyz, c13, r0.x, r1
mov o6, c15.x

"
}
SubProgram "d3d11 " {
// Stats: 33 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 192 [_StormMap_ST]
ConstBuffer "UnityLighting" 720
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecedmbhlfpngelkdpakpahkfajioakljipklabaaaaaaceahaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcciafaaaaeaaaabaa
ekabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaaegbcbaaaaaaaaaaa
egbcbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaah
hccabaaaaeaaaaaapgapbaaaaaaaaaaaegbcbaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaa
aaaaaaaaegiocaaaabaaaaaacjaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaa
aaaaaaaaegiocaaaabaaaaaackaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaa
aaaaaaaaegiocaaaabaaaaaaclaaaaaaegaobaaaabaaaaaadcaaaaakhccabaaa
afaaaaaaegiccaaaabaaaaaacmaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaipccabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d9 " {
// Stats: 54 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 8 [_Object2World] 3
Matrix 11 [_World2Object] 3
Matrix 4 [glstate_matrix_mvp]
Vector 22 [_StormMap_ST]
Vector 17 [unity_4LightAtten0]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 0 [unity_LightColor0]
Vector 1 [unity_LightColor1]
Vector 2 [unity_LightColor2]
Vector 3 [unity_LightColor3]
Vector 20 [unity_SHBb]
Vector 19 [unity_SHBg]
Vector 18 [unity_SHBr]
Vector 21 [unity_SHC]
"vs_3_0
def c23, 0, 1, 0, 0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dcl_texcoord4 o5.xyz
dcl_texcoord6 o6
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c4, v0
dp4 o0.y, c5, v0
dp4 o0.z, c6, v0
dp4 o0.w, c7, v0
mad o1.xy, v2, c22, c22.zwzw
dp4 r0.x, c8, v0
add r1, -r0.x, c14
dp4 r0.y, c9, v0
add r2, -r0.y, c15
mul r3.xyz, c12, v1.y
mad r3.xyz, c11, v1.x, r3
mad r3.xyz, c13, v1.z, r3
nrm r4.xyz, r3
mul r3, r2, r4.y
mul r2, r2, r2
mad r2, r1, r1, r2
mad r1, r1, r4.x, r3
dp4 r0.z, c10, v0
add r3, -r0.z, c16
mov o3.xyz, r0
mad r0, r3, r4.z, r1
mad r1, r3, r3, r2
rsq r2.x, r1.x
rsq r2.y, r1.y
rsq r2.z, r1.z
rsq r2.w, r1.w
mov r3.y, c23.y
mad r1, r1, c17, r3.y
mul r0, r0, r2
max r0, r0, c23.x
rcp r2.x, r1.x
rcp r2.y, r1.y
rcp r2.z, r1.z
rcp r2.w, r1.w
mul r0, r0, r2
mul r1.xyz, r0.y, c1
mad r1.xyz, c0, r0.x, r1
mad r0.xyz, c2, r0.z, r1
mad r0.xyz, c3, r0.w, r0
mul r0.w, r4.y, r4.y
mad r0.w, r4.x, r4.x, -r0.w
mul r1, r4.yzzx, r4.xyzz
mov o2.xyz, r4
dp4 r2.x, c18, r1
dp4 r2.y, c19, r1
dp4 r2.z, c20, r1
mad r1.xyz, c21, r0.w, r2
add o5.xyz, r0, r1
mov o6, c23.x

"
}
SubProgram "d3d11 " {
// Stats: 53 math
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 192 [_StormMap_ST]
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
Vector 656 [unity_SHBr]
Vector 672 [unity_SHBg]
Vector 688 [unity_SHBb]
Vector 704 [unity_SHC]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
root12:aaadaaaa
eefiecedcckmggkdkbkcoehppilmjdgmopiomfpeabaaaaaapaajaaaaadaaaaaa
cmaaaaaaceabaaaapeabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaalmaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaalmaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaalmaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaa
ahaiaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaaapaaaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefcpeahaaaaeaaaabaa
pnabaaaafjaaaaaeegiocaaaaaaaaaaaanaaaaaafjaaaaaeegiocaaaabaaaaaa
cnaaaaaafjaaaaaeegiocaaaacaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagfaaaaadhccabaaa
afaaaaaagfaaaaadpccabaaaagaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
adaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaaamaaaaaadiaaaaai
bcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaacaaaaaabcaaaaaadiaaaaai
bcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabaaaaaaadiaaaaai
ccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabbaaaaaadiaaaaai
ecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaacaaaaaabcaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaibcaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabaaaaaaadiaaaaaiccaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabbaaaaaadiaaaaaiecaabaaa
abaaaaaackbabaaaacaaaaaackiacaaaacaaaaaabcaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaaaaaaaaaadkaabaaa
aaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaafhccabaaaacaaaaaaegacbaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaafhccabaaaadaaaaaaegacbaaaabaaaaaa
baaaaaahicaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaapgapbaaa
aaaaaaaaegbcbaaaaaaaaaaaaaaaaaajpcaabaaaacaaaaaafgafbaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaadaaaaaafgafbaaa
aaaaaaaaegaobaaaacaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaacaaaaaaaaaaaaajpcaabaaaaeaaaaaaagaabaiaebaaaaaaabaaaaaa
egiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaabaaaaaakgakbaiaebaaaaaa
abaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaa
aeaaaaaaagaabaaaaaaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaaacaaaaaa
egaobaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaacaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaaj
pcaabaaaabaaaaaaegaobaaaabaaaaaakgakbaaaaaaaaaaaegaobaaaadaaaaaa
eeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaacaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaa
abaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
abaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaa
aaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaa
dkaabaiaebaaaaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaaaaaaaaaegiocaaaabaaaaaacjaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaaaaaaaaaegiocaaaabaaaaaackaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaaaaaaaaaegiocaaaabaaaaaaclaaaaaa
egaobaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaacmaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaafaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaipccabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "d3d9 " {
// Stats: 204 math, 56 textures, 10 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
Float 8 [_Distortion]
Vector 11 [_Evolution]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Vector 4 [_LightColor0]
Float 7 [_MainFrequency]
Float 10 [_StormDistortion]
Float 9 [_StormFrequency]
Vector 0 [_WorldSpaceLightPos0]
Vector 3 [unity_SHAb]
Vector 2 [unity_SHAg]
Vector 1 [unity_SHAr]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_StormMap] 2D 3
"ps_3_0
def c12, 1, 0, 2, -1
def c13, 0.00390625, 2, 3, 0
def c14, 0, 0.5, 1, -0.5
defi i0, 4, 0, 0, 0
defi i1, 3, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord3 v2.xyz
dcl_texcoord4_pp v3.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
add r0.xyz, c11, v2
frc r1.xyz, r0
add r1.xyz, r0, -r1
mul r2.xyz, r1, c13.x
frc r2.xyz, r2_abs
cmp r2.xyz, r1, r2, -r2
add r1.xyz, r0, -r1
mul r3.xyz, r1, r1
mad r4.xyz, r1, -c13.y, c13.z
mul r3.xyz, r3, r4
mov r2.w, c13.w
texldl r4, r2.xyww, s0
add r2, r2.z, r4
mul r4, r2.x, c12.xyyy
texldl r5, r4, s1
mad r5.xyz, r5, c12.z, c12.w
dp3 r0.w, r5, r1
add r5.xyz, r1, c12.wyyw
mul r6, r2.zxxx, c12.xyyy
texldl r7, r6, s1
mad r7.xyz, r7, c12.z, c12.w
dp3 r1.w, r7, r5
lrp r2.z, r3.x, r1.w, r0.w
add r5.xyz, r1, c12.ywyw
mul r7, r2.yxxx, c12.xyyy
texldl r8, r7, s1
mad r8.xyz, r8, c12.z, c12.w
dp3 r0.w, r8, r5
add r5.xyz, r1, c12.wwyw
mul r8, r2.wxxx, c12.xyyy
texldl r9, r8, s1
mad r2.xyw, r9.xyzz, c12.z, c12.w
dp3 r1.w, r2.xyww, r5
lrp r2.x, r3.x, r1.w, r0.w
lrp r0.w, r3.y, r2.x, r2.z
add r2.xyz, r1, c12.yyww
add r4, r4, c13.xwww
texldl r4, r4, s1
mad r4.xyz, r4, c12.z, c12.w
dp3 r1.w, r4, r2
add r2.xyz, r1, c12.wyww
add r4, r6, c13.xwww
texldl r4, r4, s1
mad r4.xyz, r4, c12.z, c12.w
dp3 r2.x, r4, r2
lrp r4.x, r3.x, r2.x, r1.w
add r2.xyz, r1, c12.ywww
add r5, r7, c13.xwww
texldl r5, r5, s1
mad r4.yzw, r5.xxyz, c12.z, c12.w
dp3 r1.w, r4.yzww, r2
add r1.xyz, r1, c12.w
add r2, r8, c13.xwww
texldl r2, r2, s1
mad r2.xyz, r2, c12.z, c12.w
dp3 r1.x, r2, r1
lrp r2.x, r3.x, r1.x, r1.w
lrp r1.x, r3.y, r2.x, r4.x
lrp r2.x, r3.z, r1.x, r0.w
mov r1.w, c13.w
mov r3.x, c7.x
mov r3.yz, c14
mov r0.w, c13.w
rep i0
mul r2.yzw, r0.xxyz, r3.x
frc r4.xyz, r2.yzww
add r2.yzw, r2, -r4.xxyz
mul r4.xyz, r2.yzww, c13.x
frc r4.xyz, r4_abs
cmp r1.xyz, r2.yzww, r4, -r4
mad r2.yzw, r0.xxyz, r3.x, -r2
mul r4.xyz, r2.yzww, r2.yzww
mad r5.xyz, r2.yzww, -c13.y, c13.z
mul r4.xyz, r4, r5
texldl r5, r1.xyww, s0
add r5, r1.z, r5
mul r6, r5.x, c12.xyyy
texldl r7, r6, s1
mad r1.xyz, r7, c12.z, c12.w
dp3 r1.x, r1, r2.yzww
add r7.xyz, r2.yzww, c12.wyyw
mul r8, r5.zxxx, c12.xyyy
texldl r9, r8, s1
mad r9.xyz, r9, c12.z, c12.w
dp3 r1.y, r9, r7
lrp r3.w, r4.x, r1.y, r1.x
add r1.xyz, r2.yzww, c12.ywyw
mul r7, r5.yxxx, c12.xyyy
texldl r9, r7, s1
mad r9.xyz, r9, c12.z, c12.w
dp3 r1.x, r9, r1
add r9.xyz, r2.yzww, c12.wwyw
mul r5, r5.wxxx, c12.xyyy
texldl r10, r5, s1
mad r10.xyz, r10, c12.z, c12.w
dp3 r1.y, r10, r9
lrp r9.x, r4.x, r1.y, r1.x
lrp r1.x, r4.y, r9.x, r3.w
add r9.xyz, r2.yzww, c12.yyww
add r6, r6, c13.xwww
texldl r6, r6, s1
mad r6.xyz, r6, c12.z, c12.w
dp3 r1.y, r6, r9
add r6.xyz, r2.yzww, c12.wyww
add r8, r8, c13.xwww
texldl r8, r8, s1
mad r8.xyz, r8, c12.z, c12.w
dp3 r1.z, r8, r6
lrp r3.w, r4.x, r1.z, r1.y
add r6.xyz, r2.yzww, c12.ywww
add r7, r7, c13.xwww
texldl r7, r7, s1
mad r7.xyz, r7, c12.z, c12.w
dp3 r1.y, r7, r6
add r2.yzw, r2, c12.w
add r5, r5, c13.xwww
texldl r5, r5, s1
mad r5.xyz, r5, c12.z, c12.w
dp3 r1.z, r5, r2.yzww
lrp r2.y, r4.x, r1.z, r1.y
lrp r1.y, r4.y, r2.y, r3.w
lrp r2.y, r4.z, r1.y, r1.x
add r1.x, -r2_abs.y, r2.x
mul r1.z, r1.x, r1.x
mul r2.y, r3.y, r1.z
mad r0.w, r2.y, r3.z, r0.w
mul r1.x, r3.x, c5.x
mul r1.y, r3.y, c6.x
mov r3.xyz, r1
endrep
texld r1, v0, s3
mov r2.w, c13.w
mov r1.x, c9.x
mov r1.y, c14.y
mov r1.z, c13.w
rep i1
mul r3.xyz, r0, r1.x
frc r4.xyz, r3
add r3.xyz, r3, -r4
mul r4.xyz, r3, c13.x
frc r4.xyz, r4_abs
cmp r2.xyz, r3, r4, -r4
mad r3.xyz, r0, r1.x, -r3
mul r4.xyz, r3, r3
mad r5.xyz, r3, -c13.y, c13.z
mul r4.xyz, r4, r5
texldl r5, r2.xyww, s0
add r5, r2.z, r5
mul r6, r5.x, c12.xyyy
texldl r7, r6, s1
mad r2.xyz, r7, c12.z, c12.w
dp3 r2.x, r2, r3
add r7.xyz, r3, c12.wyyw
mul r8, r5.zxxx, c12.xyyy
texldl r9, r8, s1
mad r9.xyz, r9, c12.z, c12.w
dp3 r2.y, r9, r7
lrp r3.w, r4.x, r2.y, r2.x
add r2.xyz, r3, c12.ywyw
mul r7, r5.yxxx, c12.xyyy
texldl r9, r7, s1
mad r9.xyz, r9, c12.z, c12.w
dp3 r2.x, r9, r2
add r9.xyz, r3, c12.wwyw
mul r5, r5.wxxx, c12.xyyy
texldl r10, r5, s1
mad r10.xyz, r10, c12.z, c12.w
dp3 r2.y, r10, r9
lrp r9.x, r4.x, r2.y, r2.x
lrp r2.x, r4.y, r9.x, r3.w
add r9.xyz, r3, c12.yyww
add r6, r6, c13.xwww
texldl r6, r6, s1
mad r6.xyz, r6, c12.z, c12.w
dp3 r2.y, r6, r9
add r6.xyz, r3, c12.wyww
add r8, r8, c13.xwww
texldl r8, r8, s1
mad r8.xyz, r8, c12.z, c12.w
dp3 r2.z, r8, r6
lrp r3.w, r4.x, r2.z, r2.y
add r6.xyz, r3, c12.ywww
add r7, r7, c13.xwww
texldl r7, r7, s1
mad r7.xyz, r7, c12.z, c12.w
dp3 r2.y, r7, r6
add r3.xyz, r3, c12.w
add r5, r5, c13.xwww
texldl r5, r5, s1
mad r5.xyz, r5, c12.z, c12.w
dp3 r2.z, r5, r3
lrp r3.x, r4.x, r2.z, r2.y
lrp r2.y, r4.y, r3.x, r3.w
lrp r3.x, r4.z, r2.y, r2.x
mad r1.z, r3.x, r1.y, r1.z
mul r1.x, r1.x, c5.x
mul r1.y, r1.y, c6.x
endrep
mul r0.x, r1.w, r1.z
mad r0.y, r0.w, c8.x, v2.y
mad r0.x, r0.x, c10.x, r0.y
add r0.x, r1.w, r0.x
mad r0.x, r0.x, c14.y, c14.w
mov r0.y, c13.w
texld_pp r0, r0, s2
mad_pp r1, v1.xyzx, c12.xxxy, c12.yyyx
dp4_pp r2.x, c1, r1
dp4_pp r2.y, c2, r1
dp4_pp r2.z, c3, r1
add_pp r1.xyz, r2, v3
dp3_pp r0.w, v1, c0
max_pp r1.w, r0.w, c13.w
mul_pp r2.xyz, r0, c4
mul_pp r0.xyz, r0, r1
mad_pp oC0.xyz, r2, r1.w, r0
mov_pp oC0.w, c12.x

"
}
SubProgram "d3d11 " {
// Stats: 169 math, 2 textures, 2 branches
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "DYNAMICLIGHTMAP_OFF" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 3
SetTexture 3 [_MainTex] 2D 2
ConstBuffer "$Globals" 208
Vector 96 [_LightColor0]
Float 148 [_Lacunarity]
Float 152 [_Gain]
Float 156 [_MainFrequency]
Float 160 [_Distortion]
Float 164 [_StormFrequency]
Float 168 [_StormDistortion]
Vector 176 [_Evolution] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
Vector 608 [unity_SHAr]
Vector 624 [unity_SHAg]
Vector 640 [unity_SHAb]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:aeacaeaa
eefiecedocogbehhbmnniogflbcjcchoaooegedgabaaaaaaiecdaaaaadaaaaaa
cmaaaaaapmaaaaaadaabaaaaejfdeheomiaaaaaaahaaaaaaaiaaaaaalaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaalmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaalmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalmaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaalmaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaalmaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaahahaaaalmaaaaaaagaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcemccaaaaeaaaaaaajdaiaaaa
fjaaaaaeegiocaaaaaaaaaaaamaaaaaafjaaaaaeegiocaaaabaaaaaacjaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafkaaaaadaagabaaaadaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
fibiaaaeaahabaaaadaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagcbaaaadhcbabaaaaeaaaaaagcbaaaadhcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaaaaaaaaaihcaabaaaaaaaaaaa
egbcbaaaaeaaaaaaegiccaaaaaaaaaaaalaaaaaaebaaaaafhcaabaaaabaaaaaa
egacbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaadaaaaaaegacbaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaabkaaaaaghcaabaaaacaaaaaaegacbaia
ibaaaaaaacaaaaaadhaaaaakhcaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaaegacbaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaaeaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaa
kgakbaaaacaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
acaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaafaaaaaa
egacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
akaabaaaadaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaafaaaaaakgalbaaaacaaaaaadgaaaaaikcaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
eiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaiicaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
adaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaadaaaaaadkaabaaaadaaaaaa
dkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaabkaabaaaadaaaaaadkaabaaa
abaaaaaadkaabaaaaaaaaaaaaaaaaaakpcaabaaaacaaaaaacgahbaaaacaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaafgahbaaaacaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaaeaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaal
pcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaa
aaaaaaaiicaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaadaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaadaaaaaadkaabaaaadaaaaaadkaabaaa
abaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaa
aeaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaapocaabaaaacaaaaaaagajbaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialp
baaaaaahbcaabaaaabaaaaaajgahbaaaacaaaaaaegacbaaaabaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaabaaaaaaakaabaaaacaaaaaa
aaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaabkaabaaaadaaaaaaakaabaaaabaaaaaadkaabaaa
abaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaadaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaadgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaadgaaaaagccaabaaaafaaaaaadkiacaaaaaaaaaaaajaaaaaa
dgaaaaaincaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaiadp
dgaaaaafbcaabaaaagaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaa
agaaaaaaakaabaaaagaaaaaaabeaaaaaaeaaaaaaadaaaeadbkaabaaaagaaaaaa
diaaaaahocaabaaaagaaaaaaagajbaaaaaaaaaaafgafbaaaafaaaaaaebaaaaaf
ocaabaaaagaaaaaafgaobaaaagaaaaaadiaaaaakhcaabaaaahaaaaaajgahbaaa
agaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaa
aiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaabkaaaaaghcaabaaa
ahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaakhcaabaaaahaaaaaaegacbaaa
aiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaadcaaaaakocaabaaa
agaaaaaaagajbaaaaaaaaaaafgafbaaaafaaaaaafgaobaiaebaaaaaaagaaaaaa
diaaaaahhcaabaaaaiaaaaaajgahbaaaagaaaaaajgahbaaaagaaaaaadcaaaaba
hcaabaaaajaaaaaajgahbaiaebaaaaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaah
hcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaaeiaaaaalpcaabaaa
ajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaa
aaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaaajaaaaaa
dgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaaajaaaaaa
egaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaabaaaaaaegacbaaaajaaaaaajgahbaaaagaaaaaaaaaaaaakhcaabaaa
ajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaa
eiaaaaalpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaakgalbaaa
ahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaa
ckaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaa
akaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaa
abaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaak
pcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaiadlaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaaahaaaaaa
eiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaaakaabaaa
aiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaa
jgahbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaf
fcaabaaaaeaaaaaakgalbaaaahaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaaaaaaaaakocaabaaaagaaaaaa
fgaobaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialpeiaaaaal
pcaabaaaahaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaajgahbaaaagaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaa
acaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaaakaabaaaacaaaaaa
ckaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaiaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaaaaaaaaaaa
akaabaiambaaaaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
akaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaafaaaaaaakaabaaa
abaaaaaadcaaaaajbcaabaaaafaaaaaackaabaaaabaaaaaadkaabaaaafaaaaaa
akaabaaaafaaaaaadiaaaaaigcaabaaaafaaaaaafgagbaaaafaaaaaafgigcaaa
aaaaaaaaajaaaaaaboaaaaahbcaabaaaagaaaaaaakaabaaaagaaaaaaabeaaaaa
abaaaaaadgaaaaaficaabaaaafaaaaaaakaabaaaabaaaaaabgaaaaabefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaadaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaagbcaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaaaaadgaaaaaigcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaaafaaaaaackaabaaa
abaaaaaaabeaaaaaadaaaaaaadaaaeadbkaabaaaafaaaaaadiaaaaahocaabaaa
afaaaaaaagajbaaaaaaaaaaaagaabaaaabaaaaaaebaaaaafocaabaaaafaaaaaa
fgaobaaaafaaaaaadiaaaaakhcaabaaaahaaaaaajgahbaaaafaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaa
ahaaaaaaegacbaiaebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaia
ibaaaaaaahaaaaaadhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaa
ahaaaaaaegacbaiaebaaaaaaahaaaaaadcaaaaakocaabaaaafaaaaaaagajbaaa
aaaaaaaaagaabaaaabaaaaaafgaobaiaebaaaaaaafaaaaaadiaaaaahhcaabaaa
aiaaaaaajgahbaaaafaaaaaajgahbaaaafaaaaaadcaaaabahcaabaaaajaaaaaa
jgahbaiaebaaaaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaa
egacbaaaaiaaaaaaegacbaaaajaaaaaaeiaaaaalpcaabaaaajaaaaaaegaabaaa
ahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaah
pcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaaajaaaaaadgaaaaaffcaabaaa
acaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaaajaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
ajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaajaaaaaajgahbaaaafaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaa
afaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
akaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaahaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaaiaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaa
aiaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakpcaabaaaahaaaaaa
egaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaa
akaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaak
hcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaaiaaaaaaakaabaaa
adaaaaaackaabaaaacaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaagaaaaaa
kgalbaaaahaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
ahaaaaaaegacbaaaajaaaaaaaaaaaaakocaabaaaafaaaaaafgaobaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialpeiaaaaalpcaabaaaahaaaaaa
ogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaahaaaaaajgahbaaaafaaaaaaaaaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaaiaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaai
bcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaacaaaaaabkaabaaaaiaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaackaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaaabaaaaaa
dkaabaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaajgifcaaa
aaaaaaaaajaaaaaaboaaaaahecaabaaaabaaaaaackaabaaaabaaaaaaabeaaaaa
abaaaaaabgaaaaabdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaadcaaaaakccaabaaaaaaaaaaaakaabaaaafaaaaaaakiacaaaaaaaaaaa
akaaaaaabkbabaaaaeaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaakaaaaaabkaabaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
dkaabaaaabaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaaaaaaaaa
abeaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
adaaaaaaaagabaaaacaaaaaadgaaaaafhcaabaaaabaaaaaaegbcbaaaacaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaabaaaaaacgaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaabaaaaaachaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaabaaaaaaciaaaaaaegaobaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaacaaaaaaegbcbaaaafaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadp
doaaaaab"
}
}
 }


 // Stats for Vertex shader:
 //       d3d11 : 26 math
 //        d3d9 : 17 math
 // Stats for Fragment shader:
 //       d3d11 : 172 avg math (164..180), 3 avg texture (2..4), 2 branch
 //        d3d9 : 206 avg math (198..213), 57 avg texture (56..58), 10 branch
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "FORCENOSHADOWCASTING"="true" "IGNOREPROJECTOR"="true" "RenderType"="Opaque" }
  ZWrite Off
  Blend SrcAlpha One
  ColorMask RGB
  GpuProgramID 117994
Program "vp" {
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_StormMap_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 26 math
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 256 [_StormMap_ST]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedhlpplomhfjbcclpgiidjamencgdigoniabaaaaaalaafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_StormMap_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 26 math
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 208
Vector 192 [_StormMap_ST]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedfmkikghhgfniajgfomhllfbpcblnndfpabaaaaaalaafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaa
anaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaaamaaaaaaogikcaaaaaaaaaaa
amaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_StormMap_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 26 math
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 256 [_StormMap_ST]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedhlpplomhfjbcclpgiidjamencgdigoniabaaaaaalaafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_StormMap_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 26 math
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 256 [_StormMap_ST]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedhlpplomhfjbcclpgiidjamencgdigoniabaaaaaalaafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 17 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 4 [_Object2World] 3
Matrix 7 [_World2Object] 3
Matrix 0 [glstate_matrix_mvp]
Vector 10 [_StormMap_ST]
"vs_3_0
dcl_position v0
dcl_normal v1
dcl_texcoord v2
dcl_position o0
dcl_texcoord o1.xy
dcl_texcoord1 o2.xyz
dcl_texcoord2 o3.xyz
dcl_texcoord3 o4.xyz
dp3 r0.x, v0, v0
rsq r0.x, r0.x
mul o4.xyz, r0.x, v0
dp4 o0.x, c0, v0
dp4 o0.y, c1, v0
dp4 o0.z, c2, v0
dp4 o0.w, c3, v0
mad o1.xy, v2, c10, c10.zwzw
dp4 o3.x, c4, v0
dp4 o3.y, c5, v0
dp4 o3.z, c6, v0
mul r0.xyz, c8, v1.y
mad r0.xyz, c7, v1.x, r0
mad r0.xyz, c9, v1.z, r0
dp3 r0.w, r0, r0
rsq r0.w, r0.w
mul o2.xyz, r0.w, r0

"
}
SubProgram "d3d11 " {
// Stats: 26 math
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "color" Color
Bind "normal" Normal
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 272
Vector 256 [_StormMap_ST]
ConstBuffer "UnityPerDraw" 352
Matrix 0 [glstate_matrix_mvp]
Matrix 192 [_Object2World]
Matrix 256 [_World2Object]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
root12:aaacaaaa
eefiecedhlpplomhfjbcclpgiidjamencgdigoniabaaaaaalaafaaaaadaaaaaa
cmaaaaaaceabaaaameabaaaaejfdeheopaaaaaaaaiaaaaaaaiaaaaaamiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaanbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaanjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaoaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaoaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaoaaaaaaaacaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaaoaaaaaaaadaaaaaaaaaaaaaaadaaaaaaagaaaaaa
apaaaaaaojaaaaaaaaaaaaaaaaaaaaaaadaaaaaaahaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaiaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcoeadaaaaeaaaabaapjaaaaaafjaaaaaeegiocaaaaaaaaaaa
bbaaaaaafjaaaaaeegiocaaaabaaaaaabdaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaafpaaaaaddcbabaaaadaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
gfaaaaadhccabaaaadaaaaaagfaaaaadhccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaadaaaaaaegiacaaaaaaaaaaabaaaaaaaogikcaaaaaaaaaaa
baaaaaaadiaaaaaibcaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaaaaaaaaaakbabaaaacaaaaaaakiacaaaabaaaaaa
bcaaaaaadiaaaaaibcaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
baaaaaaadiaaaaaiccaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bbaaaaaadiaaaaaiecaabaaaabaaaaaabkbabaaaacaaaaaabkiacaaaabaaaaaa
bcaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaaibcaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabaaaaaaa
diaaaaaiccaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabbaaaaaa
diaaaaaiecaabaaaabaaaaaackbabaaaacaaaaaackiacaaaabaaaaaabcaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaabaaaaaah
icaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaficaabaaa
aaaaaaaadkaabaaaaaaaaaaadiaaaaahhccabaaaacaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaa
abaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaamaaaaaa
agbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
abaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhccabaaa
adaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaaaaaaaaaegbcbaaaaaaaaaaaeeaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhccabaaaaeaaaaaaagaabaaa
aaaaaaaaegbcbaaaaaaaaaaadoaaaaab"
}
}
Program "fp" {
SubProgram "d3d9 " {
// Stats: 208 math, 57 textures, 10 branches
Keywords { "POINT" }
Matrix 0 [_LightMatrix0] 3
Float 8 [_Distortion]
Vector 11 [_Evolution]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Vector 4 [_LightColor0]
Float 7 [_MainFrequency]
Float 10 [_StormDistortion]
Float 9 [_StormFrequency]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_PermTable2D] 2D 1
SetTexture 2 [_Gradient3D] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_StormMap] 2D 4
"ps_3_0
def c12, 1, 0, 2, -1
def c13, 0.00390625, 2, 3, 0
def c14, 0, 0.5, 1, -0.5
defi i0, 4, 0, 0, 0
defi i1, 3, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
add r0.xyz, c3, -v2
nrm_pp r1.xyz, r0
add r0.xyz, c11, v3
frc r2.xyz, r0
add r2.xyz, r0, -r2
mul r3.xyz, r2, c13.x
frc r3.xyz, r3_abs
cmp r3.xyz, r2, r3, -r3
add r2.xyz, r0, -r2
mul r4.xyz, r2, r2
mad r5.xyz, r2, -c13.y, c13.z
mul r4.xyz, r4, r5
mov r3.w, c13.w
texldl r5, r3.xyww, s1
add r3, r3.z, r5
mul r5, r3.x, c12.xyyy
texldl r6, r5, s2
mad r6.xyz, r6, c12.z, c12.w
dp3 r0.w, r6, r2
add r6.xyz, r2, c12.wyyw
mul r7, r3.zxxx, c12.xyyy
texldl r8, r7, s2
mad r8.xyz, r8, c12.z, c12.w
dp3 r1.w, r8, r6
lrp r2.w, r4.x, r1.w, r0.w
add r6.xyz, r2, c12.ywyw
mul r8, r3.yxxx, c12.xyyy
texldl r9, r8, s2
mad r9.xyz, r9, c12.z, c12.w
dp3 r0.w, r9, r6
add r6.xyz, r2, c12.wwyw
mul r3, r3.wxxx, c12.xyyy
texldl r9, r3, s2
mad r9.xyz, r9, c12.z, c12.w
dp3 r1.w, r9, r6
lrp r6.x, r4.x, r1.w, r0.w
lrp r0.w, r4.y, r6.x, r2.w
add r6.xyz, r2, c12.yyww
add r5, r5, c13.xwww
texldl r5, r5, s2
mad r5.xyz, r5, c12.z, c12.w
dp3 r1.w, r5, r6
add r5.xyz, r2, c12.wyww
add r6, r7, c13.xwww
texldl r6, r6, s2
mad r6.xyz, r6, c12.z, c12.w
dp3 r2.w, r6, r5
lrp r5.x, r4.x, r2.w, r1.w
add r5.yzw, r2.xxyz, c12.xyww
add r6, r8, c13.xwww
texldl r6, r6, s2
mad r6.xyz, r6, c12.z, c12.w
dp3 r1.w, r6, r5.yzww
add r2.xyz, r2, c12.w
add r3, r3, c13.xwww
texldl r3, r3, s2
mad r3.xyz, r3, c12.z, c12.w
dp3 r2.x, r3, r2
lrp r3.x, r4.x, r2.x, r1.w
lrp r1.w, r4.y, r3.x, r5.x
lrp r2.x, r4.z, r1.w, r0.w
mov r3.w, c13.w
mov r4.x, c7.x
mov r4.yz, c14
mov r0.w, c13.w
rep i0
mul r2.yzw, r0.xxyz, r4.x
frc r5.xyz, r2.yzww
add r2.yzw, r2, -r5.xxyz
mul r5.xyz, r2.yzww, c13.x
frc r5.xyz, r5_abs
cmp r3.xyz, r2.yzww, r5, -r5
mad r2.yzw, r0.xxyz, r4.x, -r2
mul r5.xyz, r2.yzww, r2.yzww
mad r6.xyz, r2.yzww, -c13.y, c13.z
mul r5.xyz, r5, r6
texldl r6, r3.xyww, s1
add r6, r3.z, r6
mul r7, r6.x, c12.xyyy
texldl r8, r7, s2
mad r3.xyz, r8, c12.z, c12.w
dp3 r1.w, r3, r2.yzww
add r3.xyz, r2.yzww, c12.wyyw
mul r8, r6.zxxx, c12.xyyy
texldl r9, r8, s2
mad r9.xyz, r9, c12.z, c12.w
dp3 r3.x, r9, r3
lrp r4.w, r5.x, r3.x, r1.w
add r3.xyz, r2.yzww, c12.ywyw
mul r9, r6.yxxx, c12.xyyy
texldl r10, r9, s2
mad r10.xyz, r10, c12.z, c12.w
dp3 r1.w, r10, r3
add r3.xyz, r2.yzww, c12.wwyw
mul r6, r6.wxxx, c12.xyyy
texldl r10, r6, s2
mad r10.xyz, r10, c12.z, c12.w
dp3 r3.x, r10, r3
lrp r10.x, r5.x, r3.x, r1.w
lrp r1.w, r5.y, r10.x, r4.w
add r3.xyz, r2.yzww, c12.yyww
add r7, r7, c13.xwww
texldl r7, r7, s2
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r7.xyz, r2.yzww, c12.wyww
add r8, r8, c13.xwww
texldl r8, r8, s2
mad r8.xyz, r8, c12.z, c12.w
dp3 r3.y, r8, r7
lrp r4.w, r5.x, r3.y, r3.x
add r3.xyz, r2.yzww, c12.ywww
add r7, r9, c13.xwww
texldl r7, r7, s2
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r2.yzw, r2, c12.w
add r6, r6, c13.xwww
texldl r6, r6, s2
mad r6.xyz, r6, c12.z, c12.w
dp3 r2.y, r6, r2.yzww
lrp r6.x, r5.x, r2.y, r3.x
lrp r2.y, r5.y, r6.x, r4.w
lrp r3.x, r5.z, r2.y, r1.w
add r1.w, r2.x, -r3_abs.x
mul r3.z, r1.w, r1.w
mul r1.w, r4.y, r3.z
mad r0.w, r1.w, r4.z, r0.w
mul r3.x, r4.x, c5.x
mul r3.y, r4.y, c6.x
mov r4.xyz, r3
endrep
texld r2, v0, s4
mov r3.w, c13.w
mov r2.x, c9.x
mov r2.y, c14.y
mov r1.w, c13.w
rep i1
mul r4.xyz, r0, r2.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c13.x
frc r5.xyz, r5_abs
cmp r3.xyz, r4, r5, -r5
mad r4.xyz, r0, r2.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.y, c13.z
mul r5.xyz, r5, r6
texldl r6, r3.xyww, s1
add r6, r3.z, r6
mul r7, r6.x, c12.xyyy
texldl r8, r7, s2
mad r3.xyz, r8, c12.z, c12.w
dp3 r2.z, r3, r4
add r3.xyz, r4, c12.wyyw
mul r8, r6.zxxx, c12.xyyy
texldl r9, r8, s2
mad r9.xyz, r9, c12.z, c12.w
dp3 r3.x, r9, r3
lrp r4.w, r5.x, r3.x, r2.z
add r3.xyz, r4, c12.ywyw
mul r9, r6.yxxx, c12.xyyy
texldl r10, r9, s2
mad r10.xyz, r10, c12.z, c12.w
dp3 r2.z, r10, r3
add r3.xyz, r4, c12.wwyw
mul r6, r6.wxxx, c12.xyyy
texldl r10, r6, s2
mad r10.xyz, r10, c12.z, c12.w
dp3 r3.x, r10, r3
lrp r10.x, r5.x, r3.x, r2.z
lrp r2.z, r5.y, r10.x, r4.w
add r3.xyz, r4, c12.yyww
add r7, r7, c13.xwww
texldl r7, r7, s2
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r7.xyz, r4, c12.wyww
add r8, r8, c13.xwww
texldl r8, r8, s2
mad r8.xyz, r8, c12.z, c12.w
dp3 r3.y, r8, r7
lrp r4.w, r5.x, r3.y, r3.x
add r3.xyz, r4, c12.ywww
add r7, r9, c13.xwww
texldl r7, r7, s2
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r4.xyz, r4, c12.w
add r6, r6, c13.xwww
texldl r6, r6, s2
mad r6.xyz, r6, c12.z, c12.w
dp3 r3.y, r6, r4
lrp r4.x, r5.x, r3.y, r3.x
lrp r3.x, r5.y, r4.x, r4.w
lrp r4.x, r5.z, r3.x, r2.z
mad r1.w, r4.x, r2.y, r1.w
mul r2.x, r2.x, c5.x
mul r2.y, r2.y, c6.x
endrep
mul r0.x, r2.w, r1.w
mad r0.y, r0.w, c8.x, v3.y
mad r0.x, r0.x, c10.x, r0.y
add r0.x, r2.w, r0.x
mad r0.x, r0.x, c14.y, c14.w
mov r0.y, c13.w
texld_pp r0, r0, s3
mad r2, v2.xyzx, c12.xxxy, c12.yyyx
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp3 r0.w, r3, r3
texld_pp r2, r0.w, s0
mul_pp r2.xyz, r2.x, c4
dp3_pp r0.w, v1, r1
max_pp r1.x, r0.w, c13.w
mul_pp r0.xyz, r0, r2
mul_pp oC0.xyz, r1.x, r0
mov_pp oC0.w, c12.x

"
}
SubProgram "d3d11 " {
// Stats: 174 math, 3 textures, 2 branches
Keywords { "POINT" }
SetTexture 0 [_PermTable2D] 2D 1
SetTexture 1 [_Gradient3D] 2D 2
SetTexture 2 [_StormMap] 2D 4
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 272
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Float 220 [_MainFrequency]
Float 224 [_Distortion]
Float 228 [_StormFrequency]
Float 232 [_StormDistortion]
Vector 240 [_Evolution] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:afacafaa
eefiecedoefnopojfabapldfngbnelnlebhmapnfabaaaaaaaaceaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcpiccaaaaeaaaaaaaloaiaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacamaaaaaa
aaaaaaajhcaabaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaa
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
eeaaaaaficaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaabaaaaaaegbcbaaa
aeaaaaaaegiccaaaaaaaaaaaapaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaa
abaaaaaadiaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaa
adaaaaaadhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaa
egacbaiaebaaaaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadcaaaabahcaabaaaafaaaaaaegacbaiaebaaaaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaa
afaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaa
adaaaaaaiganbaaaafaaaaaadgaaaaaffcaabaaaafaaaaaaagabbaaaadaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
eiaaaaalpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaa
acaaaaaaaaaaaaakhcaabaaaagaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaafaaaaaaegacbaaaagaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaa
aeaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaafaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaagaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaa
agaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
abaaaaaaegacbaaaahaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaafaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaagaaaaaaogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaafaaaaaa
aaaaaaaiicaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaa
abaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaajicaabaaaaaaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaafaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
agaaaaaafgahbaaaadaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaahaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaa
agaaaaaaogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaafaaaaaaaaaaaaai
icaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaakhcaabaaaafaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaa
egacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaa
agaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaa
acaaaaaaakaabaaaaeaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaai
bcaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaabkaabaaaaeaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaackaabaaaaeaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaagbcaabaaa
agaaaaaadkiacaaaaaaaaaaaanaaaaaadgaaaaaiocaabaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaiadpaaaaaaaadaaaaaabcbaaaaahbcaabaaaahaaaaaa
dkaabaaaagaaaaaaabeaaaaaaeaaaaaaadaaaeadakaabaaaahaaaaaadiaaaaah
hcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaaagaaaaaaebaaaaafhcaabaaa
ahaaaaaaegacbaaaahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaa
egacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaa
egacbaiaibaaaaaaaiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaa
egacbaaaaiaaaaaaegacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaa
egacbaaaabaaaaaaagaabaaaagaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaah
hcaabaaaajaaaaaaegacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaa
akaaaaaaegacbaiaebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaa
ajaaaaaaegacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaalpcaabaaaakaaaaaa
egaabaaaaiaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaahpcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaf
fcaabaaaacaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaalaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaa
eiaaaaalpcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
alaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaa
ajaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
bkaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakpcaabaaa
aiaaaaaaegaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaaiaaaaaaeiaaaaal
pcaabaaaalaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaialpaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
afaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaaegaabaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
aiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaaiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaa
aiaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaadaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaai
ecaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaa
aaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaacaaaaaabkaabaaaajaaaaaaakaabaaaadaaaaaackaabaaa
acaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaajaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaia
mbaaaaaaacaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaa
acaaaaaadiaaaaahecaabaaaacaaaaaabkaabaaaagaaaaaaakaabaaaacaaaaaa
dcaaaaajicaabaaaabaaaaaackaabaaaacaaaaaackaabaaaagaaaaaadkaabaaa
abaaaaaadiaaaaaidcaabaaaagaaaaaaegaabaaaagaaaaaajgifcaaaaaaaaaaa
anaaaaaaboaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaaabeaaaaaabaaaaaa
dgaaaaafecaabaaaagaaaaaaakaabaaaacaaaaaabgaaaaabefaaaaajpcaabaaa
acaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaaeaaaaaadgaaaaai
kcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaai
kcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaag
bcaabaaaacaaaaaabkiacaaaaaaaaaaaaoaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaaaaadgaaaaaigcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaaaaaaaaaaaadaaaaaabcbaaaaahbcaabaaaahaaaaaackaabaaaacaaaaaa
abeaaaaaadaaaaaaadaaaeadakaabaaaahaaaaaadiaaaaahhcaabaaaahaaaaaa
egacbaaaabaaaaaaagaabaaaacaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaa
ahaaaaaadiaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaa
aiaaaaaadhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaa
egacbaiaebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaa
agaabaaaacaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaa
egacbaaaahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaia
ebaaaaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ajaaaaaaegacbaaaakaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaaiaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaa
aiaaaaaakgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaadaaaaaa
agabbaaaaiaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
akaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaaaaadgaaaaaffcaabaaaaeaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaa
alaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaadaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaibcaabaaaaeaaaaaackaabaiaebaaaaaaadaaaaaa
akaabaaaaeaaaaaadcaaaaajecaabaaaadaaaaaaakaabaaaajaaaaaaakaabaaa
aeaaaaaackaabaaaadaaaaaaaaaaaaaiecaabaaaadaaaaaaakaabaiaebaaaaaa
adaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaabkaabaaaajaaaaaa
ckaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaa
aiaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaa
eiaaaaalpcaabaaaalaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaibcaabaaaaeaaaaaackaabaiaebaaaaaaadaaaaaaakaabaaa
aeaaaaaadcaaaaajecaabaaaadaaaaaaakaabaaaajaaaaaaakaabaaaaeaaaaaa
ckaabaaaadaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaagaaaaaakgalbaaa
aiaaaaaaeiaaaaalpcaabaaaaiaaaaaaegaabaaaagaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaa
aiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaaiaaaaaa
egacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaaiaaaaaaogakbaaa
agaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
aeaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaiecaabaaaaeaaaaaa
akaabaiaebaaaaaaaeaaaaaackaabaaaaeaaaaaadcaaaaajbcaabaaaaeaaaaaa
akaabaaaajaaaaaackaabaaaaeaaaaaaakaabaaaaeaaaaaaaaaaaaaibcaabaaa
aeaaaaaackaabaiaebaaaaaaadaaaaaaakaabaaaaeaaaaaadcaaaaajecaabaaa
adaaaaaabkaabaaaajaaaaaaakaabaaaaeaaaaaackaabaaaadaaaaaaaaaaaaai
ecaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaaj
bcaabaaaadaaaaaackaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaa
dcaaaaajicaabaaaaaaaaaaaakaabaaaadaaaaaabkaabaaaacaaaaaadkaabaaa
aaaaaaaadiaaaaaidcaabaaaacaaaaaaegaabaaaacaaaaaajgifcaaaaaaaaaaa
anaaaaaaboaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaabaaaaaa
bgaaaaabdiaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaa
dcaaaaakbcaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaaoaaaaaa
bkbabaaaaeaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaa
aaaaaaaaaoaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
acaaaaaadkaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaabaaaaaaabeaaaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaa
aagabaaaadaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaadaaaaaaegiccaaa
aaaaaaaaakaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaa
agbabaaaadaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
aaaaaaaaalaaaaaakgbkbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaa
acaaaaaaegacbaaaacaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaa
pgapbaaaaaaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaaagaabaaaacaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaaagajbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaa
jgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d9 " {
// Stats: 198 math, 56 textures, 10 branches
Keywords { "DIRECTIONAL" }
Float 5 [_Distortion]
Vector 8 [_Evolution]
Float 3 [_Gain]
Float 2 [_Lacunarity]
Vector 1 [_LightColor0]
Float 4 [_MainFrequency]
Float 7 [_StormDistortion]
Float 6 [_StormFrequency]
Vector 0 [_WorldSpaceLightPos0]
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_MainTex] 2D 2
SetTexture 3 [_StormMap] 2D 3
"ps_3_0
def c9, 1, 0, 2, -1
def c10, 0.00390625, 2, 3, 0
def c11, 0, 0.5, 1, -0.5
defi i0, 4, 0, 0, 0
defi i1, 3, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord3 v2.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
add r0.xyz, c8, v2
frc r1.xyz, r0
add r1.xyz, r0, -r1
mul r2.xyz, r1, c10.x
frc r2.xyz, r2_abs
cmp r2.xyz, r1, r2, -r2
add r1.xyz, r0, -r1
mul r3.xyz, r1, r1
mad r4.xyz, r1, -c10.y, c10.z
mul r3.xyz, r3, r4
mov r2.w, c10.w
texldl r4, r2.xyww, s0
add r2, r2.z, r4
mul r4, r2.x, c9.xyyy
texldl r5, r4, s1
mad r5.xyz, r5, c9.z, c9.w
dp3 r0.w, r5, r1
add r5.xyz, r1, c9.wyyw
mul r6, r2.zxxx, c9.xyyy
texldl r7, r6, s1
mad r7.xyz, r7, c9.z, c9.w
dp3 r1.w, r7, r5
lrp r2.z, r3.x, r1.w, r0.w
add r5.xyz, r1, c9.ywyw
mul r7, r2.yxxx, c9.xyyy
texldl r8, r7, s1
mad r8.xyz, r8, c9.z, c9.w
dp3 r0.w, r8, r5
add r5.xyz, r1, c9.wwyw
mul r8, r2.wxxx, c9.xyyy
texldl r9, r8, s1
mad r2.xyw, r9.xyzz, c9.z, c9.w
dp3 r1.w, r2.xyww, r5
lrp r2.x, r3.x, r1.w, r0.w
lrp r0.w, r3.y, r2.x, r2.z
add r2.xyz, r1, c9.yyww
add r4, r4, c10.xwww
texldl r4, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r1.w, r4, r2
add r2.xyz, r1, c9.wyww
add r4, r6, c10.xwww
texldl r4, r4, s1
mad r4.xyz, r4, c9.z, c9.w
dp3 r2.x, r4, r2
lrp r4.x, r3.x, r2.x, r1.w
add r2.xyz, r1, c9.ywww
add r5, r7, c10.xwww
texldl r5, r5, s1
mad r4.yzw, r5.xxyz, c9.z, c9.w
dp3 r1.w, r4.yzww, r2
add r1.xyz, r1, c9.w
add r2, r8, c10.xwww
texldl r2, r2, s1
mad r2.xyz, r2, c9.z, c9.w
dp3 r1.x, r2, r1
lrp r2.x, r3.x, r1.x, r1.w
lrp r1.x, r3.y, r2.x, r4.x
lrp r2.x, r3.z, r1.x, r0.w
mov r1.w, c10.w
mov r3.x, c4.x
mov r3.yz, c11
mov r0.w, c10.w
rep i0
mul r2.yzw, r0.xxyz, r3.x
frc r4.xyz, r2.yzww
add r2.yzw, r2, -r4.xxyz
mul r4.xyz, r2.yzww, c10.x
frc r4.xyz, r4_abs
cmp r1.xyz, r2.yzww, r4, -r4
mad r2.yzw, r0.xxyz, r3.x, -r2
mul r4.xyz, r2.yzww, r2.yzww
mad r5.xyz, r2.yzww, -c10.y, c10.z
mul r4.xyz, r4, r5
texldl r5, r1.xyww, s0
add r5, r1.z, r5
mul r6, r5.x, c9.xyyy
texldl r7, r6, s1
mad r1.xyz, r7, c9.z, c9.w
dp3 r1.x, r1, r2.yzww
add r7.xyz, r2.yzww, c9.wyyw
mul r8, r5.zxxx, c9.xyyy
texldl r9, r8, s1
mad r9.xyz, r9, c9.z, c9.w
dp3 r1.y, r9, r7
lrp r3.w, r4.x, r1.y, r1.x
add r1.xyz, r2.yzww, c9.ywyw
mul r7, r5.yxxx, c9.xyyy
texldl r9, r7, s1
mad r9.xyz, r9, c9.z, c9.w
dp3 r1.x, r9, r1
add r9.xyz, r2.yzww, c9.wwyw
mul r5, r5.wxxx, c9.xyyy
texldl r10, r5, s1
mad r10.xyz, r10, c9.z, c9.w
dp3 r1.y, r10, r9
lrp r9.x, r4.x, r1.y, r1.x
lrp r1.x, r4.y, r9.x, r3.w
add r9.xyz, r2.yzww, c9.yyww
add r6, r6, c10.xwww
texldl r6, r6, s1
mad r6.xyz, r6, c9.z, c9.w
dp3 r1.y, r6, r9
add r6.xyz, r2.yzww, c9.wyww
add r8, r8, c10.xwww
texldl r8, r8, s1
mad r8.xyz, r8, c9.z, c9.w
dp3 r1.z, r8, r6
lrp r3.w, r4.x, r1.z, r1.y
add r6.xyz, r2.yzww, c9.ywww
add r7, r7, c10.xwww
texldl r7, r7, s1
mad r7.xyz, r7, c9.z, c9.w
dp3 r1.y, r7, r6
add r2.yzw, r2, c9.w
add r5, r5, c10.xwww
texldl r5, r5, s1
mad r5.xyz, r5, c9.z, c9.w
dp3 r1.z, r5, r2.yzww
lrp r2.y, r4.x, r1.z, r1.y
lrp r1.y, r4.y, r2.y, r3.w
lrp r2.y, r4.z, r1.y, r1.x
add r1.x, -r2_abs.y, r2.x
mul r1.z, r1.x, r1.x
mul r2.y, r3.y, r1.z
mad r0.w, r2.y, r3.z, r0.w
mul r1.x, r3.x, c2.x
mul r1.y, r3.y, c3.x
mov r3.xyz, r1
endrep
texld r1, v0, s3
mov r2.w, c10.w
mov r1.x, c6.x
mov r1.y, c11.y
mov r1.z, c10.w
rep i1
mul r3.xyz, r0, r1.x
frc r4.xyz, r3
add r3.xyz, r3, -r4
mul r4.xyz, r3, c10.x
frc r4.xyz, r4_abs
cmp r2.xyz, r3, r4, -r4
mad r3.xyz, r0, r1.x, -r3
mul r4.xyz, r3, r3
mad r5.xyz, r3, -c10.y, c10.z
mul r4.xyz, r4, r5
texldl r5, r2.xyww, s0
add r5, r2.z, r5
mul r6, r5.x, c9.xyyy
texldl r7, r6, s1
mad r2.xyz, r7, c9.z, c9.w
dp3 r2.x, r2, r3
add r7.xyz, r3, c9.wyyw
mul r8, r5.zxxx, c9.xyyy
texldl r9, r8, s1
mad r9.xyz, r9, c9.z, c9.w
dp3 r2.y, r9, r7
lrp r3.w, r4.x, r2.y, r2.x
add r2.xyz, r3, c9.ywyw
mul r7, r5.yxxx, c9.xyyy
texldl r9, r7, s1
mad r9.xyz, r9, c9.z, c9.w
dp3 r2.x, r9, r2
add r9.xyz, r3, c9.wwyw
mul r5, r5.wxxx, c9.xyyy
texldl r10, r5, s1
mad r10.xyz, r10, c9.z, c9.w
dp3 r2.y, r10, r9
lrp r9.x, r4.x, r2.y, r2.x
lrp r2.x, r4.y, r9.x, r3.w
add r9.xyz, r3, c9.yyww
add r6, r6, c10.xwww
texldl r6, r6, s1
mad r6.xyz, r6, c9.z, c9.w
dp3 r2.y, r6, r9
add r6.xyz, r3, c9.wyww
add r8, r8, c10.xwww
texldl r8, r8, s1
mad r8.xyz, r8, c9.z, c9.w
dp3 r2.z, r8, r6
lrp r3.w, r4.x, r2.z, r2.y
add r6.xyz, r3, c9.ywww
add r7, r7, c10.xwww
texldl r7, r7, s1
mad r7.xyz, r7, c9.z, c9.w
dp3 r2.y, r7, r6
add r3.xyz, r3, c9.w
add r5, r5, c10.xwww
texldl r5, r5, s1
mad r5.xyz, r5, c9.z, c9.w
dp3 r2.z, r5, r3
lrp r3.x, r4.x, r2.z, r2.y
lrp r2.y, r4.y, r3.x, r3.w
lrp r3.x, r4.z, r2.y, r2.x
mad r1.z, r3.x, r1.y, r1.z
mul r1.x, r1.x, c2.x
mul r1.y, r1.y, c3.x
endrep
mul r0.x, r1.w, r1.z
mad r0.y, r0.w, c5.x, v2.y
mad r0.x, r0.x, c7.x, r0.y
add r0.x, r1.w, r0.x
mad r0.x, r0.x, c11.y, c11.w
mov r0.y, c10.w
texld_pp r0, r0, s2
dp3_pp r0.w, v1, c0
max_pp r1.x, r0.w, c10.w
mul_pp r0.xyz, r0, c1
mul_pp oC0.xyz, r1.x, r0
mov_pp oC0.w, c9.x

"
}
SubProgram "d3d11 " {
// Stats: 164 math, 2 textures, 2 branches
Keywords { "DIRECTIONAL" }
SetTexture 0 [_PermTable2D] 2D 0
SetTexture 1 [_Gradient3D] 2D 1
SetTexture 2 [_StormMap] 2D 3
SetTexture 3 [_MainTex] 2D 2
ConstBuffer "$Globals" 208
Vector 96 [_LightColor0]
Float 148 [_Lacunarity]
Float 152 [_Gain]
Float 156 [_MainFrequency]
Float 160 [_Distortion]
Float 164 [_StormFrequency]
Float 168 [_StormDistortion]
Vector 176 [_Evolution] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:aeacaeaa
eefiecedpfdofpnfnhohhmamonighbmfmemnmlfpabaaaaaaiaccaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahaaaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchicbaaaaeaaaaaaafoaiaaaafjaaaaaeegiocaaaaaaaaaaaamaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
aeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegbcbaaaaeaaaaaaegiccaaaaaaaaaaaalaaaaaaebaaaaafhcaabaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaadaaaaaa
egacbaaaacaaaaaaegacbaiaebaaaaaaacaaaaaabkaaaaaghcaabaaaacaaaaaa
egacbaiaibaaaaaaacaaaaaadhaaaaakhcaabaaaacaaaaaaegacbaaaadaaaaaa
egacbaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaaaaaaaihcaabaaaabaaaaaa
egacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaaaeaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaadaaaaaaegacbaaa
adaaaaaaegacbaaaaeaaaaaaeiaaaaalpcaabaaaaeaaaaaaegaabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaa
acaaaaaakgakbaaaacaaaaaaiganbaaaaeaaaaaadgaaaaaffcaabaaaaeaaaaaa
agabbaaaacaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaa
afaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaaeaaaaaa
ogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaa
abaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaa
aaaaaaaaakaabaaaadaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaa
aaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaacaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
agaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaa
afaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaafaaaaaa
egacbaaaaeaaaaaaaaaaaaaiicaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaa
dkaabaaaadaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaadaaaaaadkaabaaa
adaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaabkaabaaaadaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakpcaabaaaacaaaaaacgahbaaa
acaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaa
dgaaaaaffcaabaaaafaaaaaafgahbaaaacaaaaaadgaaaaaikcaabaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
egaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaa
aeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaa
eiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaaafaaaaaaegacbaaa
aeaaaaaaaaaaaaaiicaabaaaadaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaa
adaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaadaaaaaadkaabaaaadaaaaaa
dkaabaaaabaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaapocaabaaaacaaaaaaagajbaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaialpbaaaaaahbcaabaaaabaaaaaajgahbaaaacaaaaaaegacbaaaabaaaaaa
aaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaaakaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaaabaaaaaaakaabaaa
acaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaadaaaaaaakaabaaaabaaaaaa
dkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaa
akaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaaadaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadgaaaaaikcaabaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagccaabaaaafaaaaaadkiacaaaaaaaaaaa
ajaaaaaadgaaaaaincaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadp
aaaaiadpdgaaaaafbcaabaaaagaaaaaaabeaaaaaaaaaaaaadaaaaaabcbaaaaah
ccaabaaaagaaaaaaakaabaaaagaaaaaaabeaaaaaaeaaaaaaadaaaeadbkaabaaa
agaaaaaadiaaaaahocaabaaaagaaaaaaagajbaaaaaaaaaaafgafbaaaafaaaaaa
ebaaaaafocaabaaaagaaaaaafgaobaaaagaaaaaadiaaaaakhcaabaaaahaaaaaa
jgahbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaabkaaaaag
hcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaakhcaabaaaahaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaadcaaaaak
ocaabaaaagaaaaaaagajbaaaaaaaaaaafgafbaaaafaaaaaafgaobaiaebaaaaaa
agaaaaaadiaaaaahhcaabaaaaiaaaaaajgahbaaaagaaaaaajgahbaaaagaaaaaa
dcaaaabahcaabaaaajaaaaaajgahbaiaebaaaaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaaeiaaaaal
pcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaa
ajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaa
ajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaabaaaaaaegacbaaaajaaaaaajgahbaaaagaaaaaaaaaaaaak
hcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaa
ckaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaaiaaaaaackaabaaa
abaaaaaaakaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaacaaaaaa
kgalbaaaahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaa
ogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaa
acaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaa
abaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaai
ecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaa
aaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaa
ahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaacaaaaaa
ckaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaa
akaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaakhcaabaaa
ajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaaeaaaaaakgalbaaaahaaaaaaeiaaaaalpcaabaaaahaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaaaaaaaaakocaabaaa
agaaaaaafgaobaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialp
eiaaaaalpcaabaaaahaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaahaaaaaajgahbaaa
agaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaa
akaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaaaiaaaaaaakaabaaa
acaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaa
abaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaackaabaaaaiaaaaaa
ckaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaaa
aaaaaaaaakaabaiambaaaaaaabaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaackaabaaaafaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaafaaaaaackaabaaaabaaaaaadkaabaaa
afaaaaaaakaabaaaafaaaaaadiaaaaaigcaabaaaafaaaaaafgagbaaaafaaaaaa
fgigcaaaaaaaaaaaajaaaaaaboaaaaahbcaabaaaagaaaaaaakaabaaaagaaaaaa
abeaaaaaabaaaaaadgaaaaaficaabaaaafaaaaaaakaabaaaabaaaaaabgaaaaab
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaa
adaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaaaaaaaaaakaaaaaadgaaaaaf
icaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaaigcaabaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaaaaaaaaaaaadaaaaaabcbaaaaahccaabaaaafaaaaaa
ckaabaaaabaaaaaaabeaaaaaadaaaaaaadaaaeadbkaabaaaafaaaaaadiaaaaah
ocaabaaaafaaaaaaagajbaaaaaaaaaaaagaabaaaabaaaaaaebaaaaafocaabaaa
afaaaaaafgaobaaaafaaaaaadiaaaaakhcaabaaaahaaaaaajgahbaaaafaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaaihcaabaaaaiaaaaaa
egacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaabkaaaaaghcaabaaaahaaaaaa
egacbaiaibaaaaaaahaaaaaadhaaaaakhcaabaaaahaaaaaaegacbaaaaiaaaaaa
egacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaadcaaaaakocaabaaaafaaaaaa
agajbaaaaaaaaaaaagaabaaaabaaaaaafgaobaiaebaaaaaaafaaaaaadiaaaaah
hcaabaaaaiaaaaaajgahbaaaafaaaaaajgahbaaaafaaaaaadcaaaabahcaabaaa
ajaaaaaajgahbaiaebaaaaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaa
aiaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaaeiaaaaalpcaabaaaajaaaaaa
egaabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaabeaaaaaaaaaaaaa
aaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaaajaaaaaadgaaaaaf
fcaabaaaacaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaaajaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaajaaaaaajgahbaaaafaaaaaaaaaaaaakhcaabaaaajaaaaaa
jgahbaaaafaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaahaaaaaa
eiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaa
ajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaia
ebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaa
aiaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaa
akaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
bkaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakpcaabaaa
ahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaahaaaaaaeiaaaaal
pcaabaaaakaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaialpaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaaiaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaa
agaaaaaakgalbaaaahaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaa
egacbaaaahaaaaaaegacbaaaajaaaaaaaaaaaaakocaabaaaafaaaaaafgaobaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialpeiaaaaalpcaabaaa
ahaaaaaaogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaadaaaaaaegacbaaaahaaaaaajgahbaaaafaaaaaaaaaaaaai
ecaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaaj
bcaabaaaadaaaaaaakaabaaaaiaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaa
aaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaa
dcaaaaajecaabaaaacaaaaaabkaabaaaaiaaaaaaakaabaaaadaaaaaackaabaaa
acaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaa
acaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaaiaaaaaackaabaaaacaaaaaa
akaabaaaacaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaacaaaaaabkaabaaa
abaaaaaadkaabaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaa
jgifcaaaaaaaaaaaajaaaaaaboaaaaahecaabaaaabaaaaaackaabaaaabaaaaaa
abeaaaaaabaaaaaabgaaaaabdiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaa
dkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaaakaabaaaafaaaaaaakiacaaa
aaaaaaaaakaaaaaabkbabaaaaeaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackiacaaaaaaaaaaaakaaaaaabkaabaaaaaaaaaaaaaaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaa
aaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaadaaaaaaaagabaaaacaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab
"
}
SubProgram "d3d9 " {
// Stats: 213 math, 58 textures, 10 branches
Keywords { "SPOT" }
Matrix 0 [_LightMatrix0]
Float 9 [_Distortion]
Vector 12 [_Evolution]
Float 7 [_Gain]
Float 6 [_Lacunarity]
Vector 5 [_LightColor0]
Float 8 [_MainFrequency]
Float 11 [_StormDistortion]
Float 10 [_StormFrequency]
Vector 4 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_PermTable2D] 2D 2
SetTexture 3 [_Gradient3D] 2D 3
SetTexture 4 [_MainTex] 2D 4
SetTexture 5 [_StormMap] 2D 5
"ps_3_0
def c13, 1, 0, 2, -1
def c14, 0.00390625, 2, 3, 0
def c15, 0, 0.5, 1, -0.5
defi i0, 4, 0, 0, 0
defi i1, 3, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
add r0.xyz, c4, -v2
nrm_pp r1.xyz, r0
add r0.xyz, c12, v3
frc r2.xyz, r0
add r2.xyz, r0, -r2
mul r3.xyz, r2, c14.x
frc r3.xyz, r3_abs
cmp r3.xyz, r2, r3, -r3
add r2.xyz, r0, -r2
mul r4.xyz, r2, r2
mad r5.xyz, r2, -c14.y, c14.z
mul r4.xyz, r4, r5
mov r3.w, c14.w
texldl r5, r3.xyww, s2
add r3, r3.z, r5
mul r5, r3.x, c13.xyyy
texldl r6, r5, s3
mad r6.xyz, r6, c13.z, c13.w
dp3 r0.w, r6, r2
add r6.xyz, r2, c13.wyyw
mul r7, r3.zxxx, c13.xyyy
texldl r8, r7, s3
mad r8.xyz, r8, c13.z, c13.w
dp3 r1.w, r8, r6
lrp r2.w, r4.x, r1.w, r0.w
add r6.xyz, r2, c13.ywyw
mul r8, r3.yxxx, c13.xyyy
texldl r9, r8, s3
mad r9.xyz, r9, c13.z, c13.w
dp3 r0.w, r9, r6
add r6.xyz, r2, c13.wwyw
mul r3, r3.wxxx, c13.xyyy
texldl r9, r3, s3
mad r9.xyz, r9, c13.z, c13.w
dp3 r1.w, r9, r6
lrp r6.x, r4.x, r1.w, r0.w
lrp r0.w, r4.y, r6.x, r2.w
add r6.xyz, r2, c13.yyww
add r5, r5, c14.xwww
texldl r5, r5, s3
mad r5.xyz, r5, c13.z, c13.w
dp3 r1.w, r5, r6
add r5.xyz, r2, c13.wyww
add r6, r7, c14.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c13.z, c13.w
dp3 r2.w, r6, r5
lrp r5.x, r4.x, r2.w, r1.w
add r5.yzw, r2.xxyz, c13.xyww
add r6, r8, c14.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c13.z, c13.w
dp3 r1.w, r6, r5.yzww
add r2.xyz, r2, c13.w
add r3, r3, c14.xwww
texldl r3, r3, s3
mad r3.xyz, r3, c13.z, c13.w
dp3 r2.x, r3, r2
lrp r3.x, r4.x, r2.x, r1.w
lrp r1.w, r4.y, r3.x, r5.x
lrp r2.x, r4.z, r1.w, r0.w
mov r3.w, c14.w
mov r4.x, c8.x
mov r4.yz, c15
mov r0.w, c14.w
rep i0
mul r2.yzw, r0.xxyz, r4.x
frc r5.xyz, r2.yzww
add r2.yzw, r2, -r5.xxyz
mul r5.xyz, r2.yzww, c14.x
frc r5.xyz, r5_abs
cmp r3.xyz, r2.yzww, r5, -r5
mad r2.yzw, r0.xxyz, r4.x, -r2
mul r5.xyz, r2.yzww, r2.yzww
mad r6.xyz, r2.yzww, -c14.y, c14.z
mul r5.xyz, r5, r6
texldl r6, r3.xyww, s2
add r6, r3.z, r6
mul r7, r6.x, c13.xyyy
texldl r8, r7, s3
mad r3.xyz, r8, c13.z, c13.w
dp3 r1.w, r3, r2.yzww
add r3.xyz, r2.yzww, c13.wyyw
mul r8, r6.zxxx, c13.xyyy
texldl r9, r8, s3
mad r9.xyz, r9, c13.z, c13.w
dp3 r3.x, r9, r3
lrp r4.w, r5.x, r3.x, r1.w
add r3.xyz, r2.yzww, c13.ywyw
mul r9, r6.yxxx, c13.xyyy
texldl r10, r9, s3
mad r10.xyz, r10, c13.z, c13.w
dp3 r1.w, r10, r3
add r3.xyz, r2.yzww, c13.wwyw
mul r6, r6.wxxx, c13.xyyy
texldl r10, r6, s3
mad r10.xyz, r10, c13.z, c13.w
dp3 r3.x, r10, r3
lrp r10.x, r5.x, r3.x, r1.w
lrp r1.w, r5.y, r10.x, r4.w
add r3.xyz, r2.yzww, c13.yyww
add r7, r7, c14.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c13.z, c13.w
dp3 r3.x, r7, r3
add r7.xyz, r2.yzww, c13.wyww
add r8, r8, c14.xwww
texldl r8, r8, s3
mad r8.xyz, r8, c13.z, c13.w
dp3 r3.y, r8, r7
lrp r4.w, r5.x, r3.y, r3.x
add r3.xyz, r2.yzww, c13.ywww
add r7, r9, c14.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c13.z, c13.w
dp3 r3.x, r7, r3
add r2.yzw, r2, c13.w
add r6, r6, c14.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c13.z, c13.w
dp3 r2.y, r6, r2.yzww
lrp r6.x, r5.x, r2.y, r3.x
lrp r2.y, r5.y, r6.x, r4.w
lrp r3.x, r5.z, r2.y, r1.w
add r1.w, r2.x, -r3_abs.x
mul r3.z, r1.w, r1.w
mul r1.w, r4.y, r3.z
mad r0.w, r1.w, r4.z, r0.w
mul r3.x, r4.x, c6.x
mul r3.y, r4.y, c7.x
mov r4.xyz, r3
endrep
texld r2, v0, s5
mov r3.w, c14.w
mov r2.x, c10.x
mov r2.y, c15.y
mov r1.w, c14.w
rep i1
mul r4.xyz, r0, r2.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c14.x
frc r5.xyz, r5_abs
cmp r3.xyz, r4, r5, -r5
mad r4.xyz, r0, r2.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c14.y, c14.z
mul r5.xyz, r5, r6
texldl r6, r3.xyww, s2
add r6, r3.z, r6
mul r7, r6.x, c13.xyyy
texldl r8, r7, s3
mad r3.xyz, r8, c13.z, c13.w
dp3 r2.z, r3, r4
add r3.xyz, r4, c13.wyyw
mul r8, r6.zxxx, c13.xyyy
texldl r9, r8, s3
mad r9.xyz, r9, c13.z, c13.w
dp3 r3.x, r9, r3
lrp r4.w, r5.x, r3.x, r2.z
add r3.xyz, r4, c13.ywyw
mul r9, r6.yxxx, c13.xyyy
texldl r10, r9, s3
mad r10.xyz, r10, c13.z, c13.w
dp3 r2.z, r10, r3
add r3.xyz, r4, c13.wwyw
mul r6, r6.wxxx, c13.xyyy
texldl r10, r6, s3
mad r10.xyz, r10, c13.z, c13.w
dp3 r3.x, r10, r3
lrp r10.x, r5.x, r3.x, r2.z
lrp r2.z, r5.y, r10.x, r4.w
add r3.xyz, r4, c13.yyww
add r7, r7, c14.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c13.z, c13.w
dp3 r3.x, r7, r3
add r7.xyz, r4, c13.wyww
add r8, r8, c14.xwww
texldl r8, r8, s3
mad r8.xyz, r8, c13.z, c13.w
dp3 r3.y, r8, r7
lrp r4.w, r5.x, r3.y, r3.x
add r3.xyz, r4, c13.ywww
add r7, r9, c14.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c13.z, c13.w
dp3 r3.x, r7, r3
add r4.xyz, r4, c13.w
add r6, r6, c14.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c13.z, c13.w
dp3 r3.y, r6, r4
lrp r4.x, r5.x, r3.y, r3.x
lrp r3.x, r5.y, r4.x, r4.w
lrp r4.x, r5.z, r3.x, r2.z
mad r1.w, r4.x, r2.y, r1.w
mul r2.x, r2.x, c6.x
mul r2.y, r2.y, c7.x
endrep
mul r0.x, r2.w, r1.w
mad r0.y, r0.w, c9.x, v3.y
mad r0.x, r0.x, c11.x, r0.y
add r0.x, r2.w, r0.x
mad r0.x, r0.x, c15.y, c15.w
mov r0.y, c14.w
texld_pp r0, r0, s4
mad r2, v2.xyzx, c13.xxxy, c13.yyyx
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp4 r0.w, c3, r2
rcp r0.w, r0.w
mad r2.xy, r3, r0.w, c15.y
texld_pp r2, r2, s0
dp3 r0.w, r3, r3
texld_pp r4, r0.w, s1
mul r0.w, r2.w, r4.x
mul r2.xyz, r0.w, c5
dp3_pp r0.w, v1, r1
max_pp r1.x, r0.w, c14.w
mul_pp r0.xyz, r0, r2
cmp_pp r0.xyz, -r3.z, c14.w, r0
mul_pp oC0.xyz, r1.x, r0
mov_pp oC0.w, c13.x

"
}
SubProgram "d3d11 " {
// Stats: 180 math, 4 textures, 2 branches
Keywords { "SPOT" }
SetTexture 0 [_PermTable2D] 2D 2
SetTexture 1 [_Gradient3D] 2D 3
SetTexture 2 [_StormMap] 2D 5
SetTexture 3 [_MainTex] 2D 4
SetTexture 4 [_LightTexture0] 2D 0
SetTexture 5 [_LightTextureB0] 2D 1
ConstBuffer "$Globals" 272
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Float 220 [_MainFrequency]
Float 224 [_Distortion]
Float 228 [_StormFrequency]
Float 232 [_StormDistortion]
Vector 240 [_Evolution] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:agacagaa
eefiecedjbeehhleijgckbfghdhhghcgfhlcfpecabaaaaaapeceaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcomcdaaaaeaaaaaaaplaiaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafibiaaaeaahabaaaafaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacamaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egiccaaaaaaaaaaaapaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaabaaaaaa
diaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaa
dhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaadcaaaabahcaabaaaafaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
eiaaaaalpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaa
iganbaaaafaaaaaadgaaaaaffcaabaaaafaaaaaaagabbaaaadaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaacaaaaaa
aaaaaaakhcaabaaaagaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
afaaaaaaegacbaaaagaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaaeaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
agaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaahaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
agaaaaaaogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaafaaaaaaaaaaaaai
icaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaafaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaagaaaaaa
fgahbaaaadaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
ogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaak
hcaabaaaafaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaagaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaa
egacbaaaafaaaaaaaaaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaaeaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaaeaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaackaabaaaaeaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaa
dkiacaaaaaaaaaaaanaaaaaadgaaaaaiocaabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaiadpaaaaaaaadaaaaaabcbaaaaahbcaabaaaahaaaaaadkaabaaa
agaaaaaaabeaaaaaaeaaaaaaadaaaeadakaabaaaahaaaaaadiaaaaahhcaabaaa
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
egacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaa
aiaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaah
pcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaa
acaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
alaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaaeiaaaaal
pcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakpcaabaaaaiaaaaaa
egaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
alaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaaakaabaaa
adaaaaaackaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
aiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaaiaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaai
bcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaacaaaaaabkaabaaaajaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaackaabaaaajaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaiambaaaaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaabkaabaaaagaaaaaaakaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaackaabaaaacaaaaaackaabaaaagaaaaaadkaabaaaabaaaaaa
diaaaaaidcaabaaaagaaaaaaegaabaaaagaaaaaajgifcaaaaaaaaaaaanaaaaaa
boaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaaabeaaaaaabaaaaaadgaaaaaf
ecaabaaaagaaaaaaakaabaaaacaaaaaabgaaaaabefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaa
acaaaaaabkiacaaaaaaaaaaaaoaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaaaaadgaaaaaigcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaaaa
aaaaaaaadaaaaaabcbaaaaahbcaabaaaahaaaaaackaabaaaacaaaaaaabeaaaaa
adaaaaaaadaaaeadakaabaaaahaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaacaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaa
diaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaa
dhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaa
egacbaaaakaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaa
kgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaakaaaaaa
egacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
adaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaaeaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
eiaaaaalpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaibcaabaaaaeaaaaaackaabaiaebaaaaaaadaaaaaaakaabaaa
aeaaaaaadcaaaaajecaabaaaadaaaaaaakaabaaaajaaaaaaakaabaaaaeaaaaaa
ckaabaaaadaaaaaaaaaaaaaiecaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
ckaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaabkaabaaaajaaaaaackaabaaa
adaaaaaaakaabaaaadaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
adaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaal
pcaabaaaalaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaibcaabaaaaeaaaaaackaabaiaebaaaaaaadaaaaaaakaabaaaaeaaaaaa
dcaaaaajecaabaaaadaaaaaaakaabaaaajaaaaaaakaabaaaaeaaaaaackaabaaa
adaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaagaaaaaakgalbaaaaiaaaaaa
eiaaaaalpcaabaaaaiaaaaaaegaabaaaagaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaaiaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaaiaaaaaaogakbaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
aiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaeaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaiecaabaaaaeaaaaaaakaabaia
ebaaaaaaaeaaaaaackaabaaaaeaaaaaadcaaaaajbcaabaaaaeaaaaaaakaabaaa
ajaaaaaackaabaaaaeaaaaaaakaabaaaaeaaaaaaaaaaaaaibcaabaaaaeaaaaaa
ckaabaiaebaaaaaaadaaaaaaakaabaaaaeaaaaaadcaaaaajecaabaaaadaaaaaa
bkaabaaaajaaaaaaakaabaaaaeaaaaaackaabaaaadaaaaaaaaaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaackaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
icaabaaaaaaaaaaaakaabaaaadaaaaaabkaabaaaacaaaaaadkaabaaaaaaaaaaa
diaaaaaidcaabaaaacaaaaaaegaabaaaacaaaaaajgifcaaaaaaaaaaaanaaaaaa
boaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaab
diaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaadcaaaaak
bcaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaaoaaaaaabkbabaaa
aeaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
dkaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadiaaaaaipcaabaaaacaaaaaafgbfbaaaadaaaaaaegiocaaaaaaaaaaa
akaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegaobaaaacaaaaaadcaaaaakpcaabaaaacaaaaaaegiocaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegaobaaaacaaaaaaaaaaaaaipcaabaaaacaaaaaa
egaobaaaacaaaaaaegiocaaaaaaaaaaaamaaaaaadbaaaaahicaabaaaaaaaaaaa
abeaaaaaaaaaaaaackaabaaaacaaaaaaabaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaabeaaaaaaaaaiadpaoaaaaahdcaabaaaadaaaaaaegaabaaaacaaaaaa
pgapbaaaacaaaaaaaaaaaaakdcaabaaaadaaaaaaegaabaaaadaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
adaaaaaaeghobaaaaeaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaadaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaacaaaaaapgapbaaaabaaaaaa
eghobaaaafaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaaakaabaaaacaaaaaadiaaaaaihcaabaaaacaaaaaapgapbaaaaaaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaa
egacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaaagajbaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 209 math, 58 textures, 10 branches
Keywords { "POINT_COOKIE" }
Matrix 0 [_LightMatrix0] 3
Float 8 [_Distortion]
Vector 11 [_Evolution]
Float 6 [_Gain]
Float 5 [_Lacunarity]
Vector 4 [_LightColor0]
Float 7 [_MainFrequency]
Float 10 [_StormDistortion]
Float 9 [_StormFrequency]
Vector 3 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] CUBE 0
SetTexture 1 [_LightTextureB0] 2D 1
SetTexture 2 [_PermTable2D] 2D 2
SetTexture 3 [_Gradient3D] 2D 3
SetTexture 4 [_MainTex] 2D 4
SetTexture 5 [_StormMap] 2D 5
"ps_3_0
def c12, 1, 0, 2, -1
def c13, 0.00390625, 2, 3, 0
def c14, 0, 0.5, 1, -0.5
defi i0, 4, 0, 0, 0
defi i1, 3, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_cube s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
add r0.xyz, c3, -v2
nrm_pp r1.xyz, r0
add r0.xyz, c11, v3
frc r2.xyz, r0
add r2.xyz, r0, -r2
mul r3.xyz, r2, c13.x
frc r3.xyz, r3_abs
cmp r3.xyz, r2, r3, -r3
add r2.xyz, r0, -r2
mul r4.xyz, r2, r2
mad r5.xyz, r2, -c13.y, c13.z
mul r4.xyz, r4, r5
mov r3.w, c13.w
texldl r5, r3.xyww, s2
add r3, r3.z, r5
mul r5, r3.x, c12.xyyy
texldl r6, r5, s3
mad r6.xyz, r6, c12.z, c12.w
dp3 r0.w, r6, r2
add r6.xyz, r2, c12.wyyw
mul r7, r3.zxxx, c12.xyyy
texldl r8, r7, s3
mad r8.xyz, r8, c12.z, c12.w
dp3 r1.w, r8, r6
lrp r2.w, r4.x, r1.w, r0.w
add r6.xyz, r2, c12.ywyw
mul r8, r3.yxxx, c12.xyyy
texldl r9, r8, s3
mad r9.xyz, r9, c12.z, c12.w
dp3 r0.w, r9, r6
add r6.xyz, r2, c12.wwyw
mul r3, r3.wxxx, c12.xyyy
texldl r9, r3, s3
mad r9.xyz, r9, c12.z, c12.w
dp3 r1.w, r9, r6
lrp r6.x, r4.x, r1.w, r0.w
lrp r0.w, r4.y, r6.x, r2.w
add r6.xyz, r2, c12.yyww
add r5, r5, c13.xwww
texldl r5, r5, s3
mad r5.xyz, r5, c12.z, c12.w
dp3 r1.w, r5, r6
add r5.xyz, r2, c12.wyww
add r6, r7, c13.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c12.z, c12.w
dp3 r2.w, r6, r5
lrp r5.x, r4.x, r2.w, r1.w
add r5.yzw, r2.xxyz, c12.xyww
add r6, r8, c13.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c12.z, c12.w
dp3 r1.w, r6, r5.yzww
add r2.xyz, r2, c12.w
add r3, r3, c13.xwww
texldl r3, r3, s3
mad r3.xyz, r3, c12.z, c12.w
dp3 r2.x, r3, r2
lrp r3.x, r4.x, r2.x, r1.w
lrp r1.w, r4.y, r3.x, r5.x
lrp r2.x, r4.z, r1.w, r0.w
mov r3.w, c13.w
mov r4.x, c7.x
mov r4.yz, c14
mov r0.w, c13.w
rep i0
mul r2.yzw, r0.xxyz, r4.x
frc r5.xyz, r2.yzww
add r2.yzw, r2, -r5.xxyz
mul r5.xyz, r2.yzww, c13.x
frc r5.xyz, r5_abs
cmp r3.xyz, r2.yzww, r5, -r5
mad r2.yzw, r0.xxyz, r4.x, -r2
mul r5.xyz, r2.yzww, r2.yzww
mad r6.xyz, r2.yzww, -c13.y, c13.z
mul r5.xyz, r5, r6
texldl r6, r3.xyww, s2
add r6, r3.z, r6
mul r7, r6.x, c12.xyyy
texldl r8, r7, s3
mad r3.xyz, r8, c12.z, c12.w
dp3 r1.w, r3, r2.yzww
add r3.xyz, r2.yzww, c12.wyyw
mul r8, r6.zxxx, c12.xyyy
texldl r9, r8, s3
mad r9.xyz, r9, c12.z, c12.w
dp3 r3.x, r9, r3
lrp r4.w, r5.x, r3.x, r1.w
add r3.xyz, r2.yzww, c12.ywyw
mul r9, r6.yxxx, c12.xyyy
texldl r10, r9, s3
mad r10.xyz, r10, c12.z, c12.w
dp3 r1.w, r10, r3
add r3.xyz, r2.yzww, c12.wwyw
mul r6, r6.wxxx, c12.xyyy
texldl r10, r6, s3
mad r10.xyz, r10, c12.z, c12.w
dp3 r3.x, r10, r3
lrp r10.x, r5.x, r3.x, r1.w
lrp r1.w, r5.y, r10.x, r4.w
add r3.xyz, r2.yzww, c12.yyww
add r7, r7, c13.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r7.xyz, r2.yzww, c12.wyww
add r8, r8, c13.xwww
texldl r8, r8, s3
mad r8.xyz, r8, c12.z, c12.w
dp3 r3.y, r8, r7
lrp r4.w, r5.x, r3.y, r3.x
add r3.xyz, r2.yzww, c12.ywww
add r7, r9, c13.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r2.yzw, r2, c12.w
add r6, r6, c13.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c12.z, c12.w
dp3 r2.y, r6, r2.yzww
lrp r6.x, r5.x, r2.y, r3.x
lrp r2.y, r5.y, r6.x, r4.w
lrp r3.x, r5.z, r2.y, r1.w
add r1.w, r2.x, -r3_abs.x
mul r3.z, r1.w, r1.w
mul r1.w, r4.y, r3.z
mad r0.w, r1.w, r4.z, r0.w
mul r3.x, r4.x, c5.x
mul r3.y, r4.y, c6.x
mov r4.xyz, r3
endrep
texld r2, v0, s5
mov r3.w, c13.w
mov r2.x, c9.x
mov r2.y, c14.y
mov r1.w, c13.w
rep i1
mul r4.xyz, r0, r2.x
frc r5.xyz, r4
add r4.xyz, r4, -r5
mul r5.xyz, r4, c13.x
frc r5.xyz, r5_abs
cmp r3.xyz, r4, r5, -r5
mad r4.xyz, r0, r2.x, -r4
mul r5.xyz, r4, r4
mad r6.xyz, r4, -c13.y, c13.z
mul r5.xyz, r5, r6
texldl r6, r3.xyww, s2
add r6, r3.z, r6
mul r7, r6.x, c12.xyyy
texldl r8, r7, s3
mad r3.xyz, r8, c12.z, c12.w
dp3 r2.z, r3, r4
add r3.xyz, r4, c12.wyyw
mul r8, r6.zxxx, c12.xyyy
texldl r9, r8, s3
mad r9.xyz, r9, c12.z, c12.w
dp3 r3.x, r9, r3
lrp r4.w, r5.x, r3.x, r2.z
add r3.xyz, r4, c12.ywyw
mul r9, r6.yxxx, c12.xyyy
texldl r10, r9, s3
mad r10.xyz, r10, c12.z, c12.w
dp3 r2.z, r10, r3
add r3.xyz, r4, c12.wwyw
mul r6, r6.wxxx, c12.xyyy
texldl r10, r6, s3
mad r10.xyz, r10, c12.z, c12.w
dp3 r3.x, r10, r3
lrp r10.x, r5.x, r3.x, r2.z
lrp r2.z, r5.y, r10.x, r4.w
add r3.xyz, r4, c12.yyww
add r7, r7, c13.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r7.xyz, r4, c12.wyww
add r8, r8, c13.xwww
texldl r8, r8, s3
mad r8.xyz, r8, c12.z, c12.w
dp3 r3.y, r8, r7
lrp r4.w, r5.x, r3.y, r3.x
add r3.xyz, r4, c12.ywww
add r7, r9, c13.xwww
texldl r7, r7, s3
mad r7.xyz, r7, c12.z, c12.w
dp3 r3.x, r7, r3
add r4.xyz, r4, c12.w
add r6, r6, c13.xwww
texldl r6, r6, s3
mad r6.xyz, r6, c12.z, c12.w
dp3 r3.y, r6, r4
lrp r4.x, r5.x, r3.y, r3.x
lrp r3.x, r5.y, r4.x, r4.w
lrp r4.x, r5.z, r3.x, r2.z
mad r1.w, r4.x, r2.y, r1.w
mul r2.x, r2.x, c5.x
mul r2.y, r2.y, c6.x
endrep
mul r0.x, r2.w, r1.w
mad r0.y, r0.w, c8.x, v3.y
mad r0.x, r0.x, c10.x, r0.y
add r0.x, r2.w, r0.x
mad r0.x, r0.x, c14.y, c14.w
mov r0.y, c13.w
texld_pp r0, r0, s4
mad r2, v2.xyzx, c12.xxxy, c12.yyyx
dp4 r3.x, c0, r2
dp4 r3.y, c1, r2
dp4 r3.z, c2, r2
dp3 r0.w, r3, r3
texld r2, r0.w, s1
texld r3, r3, s0
mul_pp r0.w, r2.x, r3.w
mul_pp r2.xyz, r0.w, c4
dp3_pp r0.w, v1, r1
max_pp r1.x, r0.w, c13.w
mul_pp r0.xyz, r0, r2
mul_pp oC0.xyz, r1.x, r0
mov_pp oC0.w, c12.x

"
}
SubProgram "d3d11 " {
// Stats: 175 math, 4 textures, 2 branches
Keywords { "POINT_COOKIE" }
SetTexture 0 [_PermTable2D] 2D 2
SetTexture 1 [_Gradient3D] 2D 3
SetTexture 2 [_StormMap] 2D 5
SetTexture 3 [_MainTex] 2D 4
SetTexture 4 [_LightTextureB0] 2D 1
SetTexture 5 [_LightTexture0] CUBE 0
ConstBuffer "$Globals" 272
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Float 220 [_MainFrequency]
Float 224 [_Distortion]
Float 228 [_StormFrequency]
Float 232 [_StormDistortion]
Vector 240 [_Evolution] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:agacagaa
eefiecedgnedcadfgccoejgnnhaahmpjmnnbeikpabaaaaaafmceaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcfecdaaaaeaaaaaaanfaiaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafkaaaaadaagabaaaafaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaafibiaaaeaahabaaaadaaaaaaffffaaaafibiaaaeaahabaaa
aeaaaaaaffffaaaafidaaaaeaahabaaaafaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaagcbaaaad
hcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacamaaaaaaaaaaaaaj
hcaabaaaaaaaaaaaegbcbaiaebaaaaaaadaaaaaaegiccaaaabaaaaaaaaaaaaaa
baaaaaahicaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaeeaaaaaf
icaabaaaaaaaaaaadkaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaabaaaaaaegbcbaaaaeaaaaaa
egiccaaaaaaaaaaaapaaaaaaebaaaaafhcaabaaaacaaaaaaegacbaaaabaaaaaa
diaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaabkaaaaaghcaabaaaadaaaaaaegacbaiaibaaaaaaadaaaaaa
dhaaaaakhcaabaaaadaaaaaaegacbaaaaeaaaaaaegacbaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaaaaaaaaaihcaabaaaacaaaaaaegacbaaaabaaaaaaegacbaia
ebaaaaaaacaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaadcaaaabahcaabaaaafaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaea
aaaaaaaadiaaaaahhcaabaaaaeaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
eiaaaaalpcaabaaaafaaaaaaegaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaadaaaaaakgakbaaaadaaaaaa
iganbaaaafaaaaaadgaaaaaffcaabaaaafaaaaaaagabbaaaadaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaaaaaaaaaegacbaaaagaaaaaaegacbaaaacaaaaaa
aaaaaaakhcaabaaaagaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
afaaaaaaegacbaaaagaaaaaaaaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaaaeaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaa
agaaaaaakgalbaaaadaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
ahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaa
egacbaaaahaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
agaaaaaaogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaafaaaaaaaaaaaaai
icaabaaaacaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaabkaabaaaaeaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaakpcaabaaaadaaaaaacgahbaaaadaaaaaaaceaaaaaaaaaiadl
aaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaafaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaagaaaaaa
fgahbaaaadaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaahaaaaaaegaabaaaagaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaa
ahaaaaaaegacbaaaafaaaaaaaaaaaaakhcaabaaaafaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaagaaaaaa
ogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
icaabaaaacaaaaaaegacbaaaagaaaaaaegacbaaaafaaaaaaaaaaaaaiicaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaadkaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaaakaabaaaaeaaaaaadkaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaak
hcaabaaaafaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialp
aaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaagaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaa
agaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaacaaaaaaegacbaaaagaaaaaa
egacbaaaafaaaaaaaaaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaadaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaadaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
acaaaaaaegacbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaa
dkaabaiaebaaaaaaacaaaaaaakaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaa
akaabaaaaeaaaaaaakaabaaaacaaaaaadkaabaaaacaaaaaaaaaaaaaibcaabaaa
acaaaaaadkaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaa
abaaaaaabkaabaaaaeaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaaaaaaaaai
icaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaaj
icaabaaaaaaaaaaackaabaaaaeaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaa
dgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaaaaadgaaaaagbcaabaaaagaaaaaa
dkiacaaaaaaaaaaaanaaaaaadgaaaaaiocaabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaiadpaaaaaaaadaaaaaabcbaaaaahbcaabaaaahaaaaaadkaabaaa
agaaaaaaabeaaaaaaeaaaaaaadaaaeadakaabaaaahaaaaaadiaaaaahhcaabaaa
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
egacbaaaajaaaaaaegacbaaaakaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaa
aiaaaaaaeghobaaaaaaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaah
pcaabaaaaiaaaaaakgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaa
acaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaacaaaaaa
egacbaaaakaaaaaaegacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaa
ahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
alaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaaakaabaaaajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaakgalbaaaaiaaaaaaeiaaaaal
pcaabaaaalaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaa
egacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
alaaaaaaegacbaaaakaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaa
acaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaa
akaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaia
ebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaabkaabaaa
ajaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaakpcaabaaaaiaaaaaa
egaobaaaaiaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialp
aaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaa
alaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahecaabaaaacaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaak
hcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialp
aaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaa
alaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaalaaaaaa
egacbaaaakaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaaakaabaaaajaaaaaaakaabaaa
adaaaaaackaabaaaacaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaa
kgalbaaaaiaaaaaaeiaaaaalpcaabaaaaiaaaaaaegaabaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaa
egacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaa
aiaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaaiaaaaaa
ogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaaakaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaai
bcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaaj
ecaabaaaacaaaaaabkaabaaaajaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaa
aaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaa
dcaaaaajbcaabaaaacaaaaaackaabaaaajaaaaaackaabaaaacaaaaaaakaabaaa
acaaaaaaaaaaaaaibcaabaaaacaaaaaadkaabaaaaaaaaaaaakaabaiambaaaaaa
acaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaakaabaaaacaaaaaa
diaaaaahecaabaaaacaaaaaabkaabaaaagaaaaaaakaabaaaacaaaaaadcaaaaaj
icaabaaaabaaaaaackaabaaaacaaaaaackaabaaaagaaaaaadkaabaaaabaaaaaa
diaaaaaidcaabaaaagaaaaaaegaabaaaagaaaaaajgifcaaaaaaaaaaaanaaaaaa
boaaaaahicaabaaaagaaaaaadkaabaaaagaaaaaaabeaaaaaabaaaaaadgaaaaaf
ecaabaaaagaaaaaaakaabaaaacaaaaaabgaaaaabefaaaaajpcaabaaaacaaaaaa
egbabaaaabaaaaaaeghobaaaacaaaaaaaagabaaaafaaaaaadgaaaaaikcaabaaa
adaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
afaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaa
acaaaaaabkiacaaaaaaaaaaaaoaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaa
aaaaaaaadgaaaaaigcaabaaaacaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaaaa
aaaaaaaadaaaaaabcbaaaaahbcaabaaaahaaaaaackaabaaaacaaaaaaabeaaaaa
adaaaaaaadaaaeadakaabaaaahaaaaaadiaaaaahhcaabaaaahaaaaaaegacbaaa
abaaaaaaagaabaaaacaaaaaaebaaaaafhcaabaaaahaaaaaaegacbaaaahaaaaaa
diaaaaakhcaabaaaaiaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaaaaabnaaaaaihcaabaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaabkaaaaaghcaabaaaaiaaaaaaegacbaiaibaaaaaaaiaaaaaa
dhaaaaakhcaabaaaaiaaaaaaegacbaaaajaaaaaaegacbaaaaiaaaaaaegacbaia
ebaaaaaaaiaaaaaadcaaaaakhcaabaaaahaaaaaaegacbaaaabaaaaaaagaabaaa
acaaaaaaegacbaiaebaaaaaaahaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaa
ahaaaaaaegacbaaaahaaaaaadcaaaabahcaabaaaakaaaaaaegacbaiaebaaaaaa
ahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaea
aaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaaajaaaaaaegacbaaaajaaaaaa
egacbaaaakaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaaiaaaaaaeghobaaa
aaaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaaiaaaaaa
kgakbaaaaiaaaaaaiganbaaaakaaaaaadgaaaaaffcaabaaaadaaaaaaagabbaaa
aiaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaaabaaaaaa
aagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaaadaaaaaaegacbaaaakaaaaaa
egacbaaaahaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaalaaaaaaogakbaaa
adaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
adaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaaiecaabaaaadaaaaaa
akaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaa
akaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaa
dgaaaaaffcaabaaaaeaaaaaakgalbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaa
egaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
ecaabaaaadaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaa
akaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaa
eiaaaaalpcaabaaaalaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaalaaaaaaegacbaaa
akaaaaaaaaaaaaaibcaabaaaaeaaaaaackaabaiaebaaaaaaadaaaaaaakaabaaa
aeaaaaaadcaaaaajecaabaaaadaaaaaaakaabaaaajaaaaaaakaabaaaaeaaaaaa
ckaabaaaadaaaaaaaaaaaaaiecaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaa
ckaabaaaadaaaaaadcaaaaajbcaabaaaadaaaaaabkaabaaaajaaaaaackaabaaa
adaaaaaaakaabaaaadaaaaaaaaaaaaakpcaabaaaaiaaaaaaegaobaaaaiaaaaaa
aceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaf
fcaabaaaafaaaaaaagabbaaaaiaaaaaaeiaaaaalpcaabaaaalaaaaaaegaabaaa
afaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
adaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaaaaaaaaakhcaabaaaakaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaal
pcaabaaaalaaaaaaogakbaaaafaaaaaaeghobaaaabaaaaaaaagabaaaadaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaalaaaaaaegacbaaaalaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaalaaaaaaegacbaaaakaaaaaa
aaaaaaaibcaabaaaaeaaaaaackaabaiaebaaaaaaadaaaaaaakaabaaaaeaaaaaa
dcaaaaajecaabaaaadaaaaaaakaabaaaajaaaaaaakaabaaaaeaaaaaackaabaaa
adaaaaaaaaaaaaakhcaabaaaakaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaaaaadgaaaaaffcaabaaaagaaaaaakgalbaaaaiaaaaaa
eiaaaaalpcaabaaaaiaaaaaaegaabaaaagaaaaaaeghobaaaabaaaaaaaagabaaa
adaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaaiaaaaaaegacbaaaaiaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaaeaaaaaaegacbaaaaiaaaaaaegacbaaa
akaaaaaaaaaaaaakhcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaaeiaaaaalpcaabaaaaiaaaaaaogakbaaaagaaaaaa
eghobaaaabaaaaaaaagabaaaadaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
aiaaaaaaegacbaaaaiaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaaeaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaaaaaaaaiecaabaaaaeaaaaaaakaabaia
ebaaaaaaaeaaaaaackaabaaaaeaaaaaadcaaaaajbcaabaaaaeaaaaaaakaabaaa
ajaaaaaackaabaaaaeaaaaaaakaabaaaaeaaaaaaaaaaaaaibcaabaaaaeaaaaaa
ckaabaiaebaaaaaaadaaaaaaakaabaaaaeaaaaaadcaaaaajecaabaaaadaaaaaa
bkaabaaaajaaaaaaakaabaaaaeaaaaaackaabaaaadaaaaaaaaaaaaaiecaabaaa
adaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaaadaaaaaadcaaaaajbcaabaaa
adaaaaaackaabaaaajaaaaaackaabaaaadaaaaaaakaabaaaadaaaaaadcaaaaaj
icaabaaaaaaaaaaaakaabaaaadaaaaaabkaabaaaacaaaaaadkaabaaaaaaaaaaa
diaaaaaidcaabaaaacaaaaaaegaabaaaacaaaaaajgifcaaaaaaaaaaaanaaaaaa
boaaaaahecaabaaaacaaaaaackaabaaaacaaaaaaabeaaaaaabaaaaaabgaaaaab
diaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaadkaabaaaaaaaaaaadcaaaaak
bcaabaaaabaaaaaadkaabaaaabaaaaaaakiacaaaaaaaaaaaaoaaaaaabkbabaaa
aeaaaaaadcaaaaakicaabaaaaaaaaaaadkaabaaaaaaaaaaackiacaaaaaaaaaaa
aoaaaaaaakaabaaaabaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaacaaaaaa
dkaabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaaalpdgaaaaafccaabaaaabaaaaaaabeaaaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaadaaaaaaaagabaaa
aeaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaaadaaaaaaegiccaaaaaaaaaaa
akaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaaajaaaaaaagbabaaa
adaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
alaaaaaakgbkbaaaadaaaaaaegacbaaaacaaaaaaaaaaaaaihcaabaaaacaaaaaa
egacbaaaacaaaaaaegiccaaaaaaaaaaaamaaaaaabaaaaaahicaabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaapgapbaaa
aaaaaaaaeghobaaaaeaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaa
egacbaaaacaaaaaaeghobaaaafaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaacaaaaaaakaabaaaadaaaaaadiaaaaaihcaabaaaacaaaaaa
pgapbaaaaaaaaaaaegiccaaaaaaaaaaaagaaaaaabaaaaaahbcaabaaaaaaaaaaa
egbcbaaaacaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaadiaaaaahocaabaaaaaaaaaaaagajbaaaabaaaaaa
agajbaaaacaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
SubProgram "d3d9 " {
// Stats: 202 math, 57 textures, 10 branches
Keywords { "DIRECTIONAL_COOKIE" }
Matrix 0 [_LightMatrix0] 2
Float 7 [_Distortion]
Vector 10 [_Evolution]
Float 5 [_Gain]
Float 4 [_Lacunarity]
Vector 3 [_LightColor0]
Float 6 [_MainFrequency]
Float 9 [_StormDistortion]
Float 8 [_StormFrequency]
Vector 2 [_WorldSpaceLightPos0]
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_PermTable2D] 2D 1
SetTexture 2 [_Gradient3D] 2D 2
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_StormMap] 2D 4
"ps_3_0
def c11, 1, 0, 2, -1
def c12, 0.00390625, 2, 3, 0
def c13, 0, 0.5, 1, -0.5
defi i0, 4, 0, 0, 0
defi i1, 3, 0, 0, 0
dcl_texcoord v0.xy
dcl_texcoord1_pp v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
add r0.xyz, c10, v3
frc r1.xyz, r0
add r1.xyz, r0, -r1
mul r2.xyz, r1, c12.x
frc r2.xyz, r2_abs
cmp r2.xyz, r1, r2, -r2
add r1.xyz, r0, -r1
mul r3.xyz, r1, r1
mad r4.xyz, r1, -c12.y, c12.z
mul r3.xyz, r3, r4
mov r2.w, c12.w
texldl r4, r2.xyww, s1
add r2, r2.z, r4
mul r4, r2.x, c11.xyyy
texldl r5, r4, s2
mad r5.xyz, r5, c11.z, c11.w
dp3 r0.w, r5, r1
add r5.xyz, r1, c11.wyyw
mul r6, r2.zxxx, c11.xyyy
texldl r7, r6, s2
mad r7.xyz, r7, c11.z, c11.w
dp3 r1.w, r7, r5
lrp r2.z, r3.x, r1.w, r0.w
add r5.xyz, r1, c11.ywyw
mul r7, r2.yxxx, c11.xyyy
texldl r8, r7, s2
mad r8.xyz, r8, c11.z, c11.w
dp3 r0.w, r8, r5
add r5.xyz, r1, c11.wwyw
mul r8, r2.wxxx, c11.xyyy
texldl r9, r8, s2
mad r2.xyw, r9.xyzz, c11.z, c11.w
dp3 r1.w, r2.xyww, r5
lrp r2.x, r3.x, r1.w, r0.w
lrp r0.w, r3.y, r2.x, r2.z
add r2.xyz, r1, c11.yyww
add r4, r4, c12.xwww
texldl r4, r4, s2
mad r4.xyz, r4, c11.z, c11.w
dp3 r1.w, r4, r2
add r2.xyz, r1, c11.wyww
add r4, r6, c12.xwww
texldl r4, r4, s2
mad r4.xyz, r4, c11.z, c11.w
dp3 r2.x, r4, r2
lrp r4.x, r3.x, r2.x, r1.w
add r2.xyz, r1, c11.ywww
add r5, r7, c12.xwww
texldl r5, r5, s2
mad r4.yzw, r5.xxyz, c11.z, c11.w
dp3 r1.w, r4.yzww, r2
add r1.xyz, r1, c11.w
add r2, r8, c12.xwww
texldl r2, r2, s2
mad r2.xyz, r2, c11.z, c11.w
dp3 r1.x, r2, r1
lrp r2.x, r3.x, r1.x, r1.w
lrp r1.x, r3.y, r2.x, r4.x
lrp r2.x, r3.z, r1.x, r0.w
mov r1.w, c12.w
mov r3.x, c6.x
mov r3.yz, c13
mov r0.w, c12.w
rep i0
mul r2.yzw, r0.xxyz, r3.x
frc r4.xyz, r2.yzww
add r2.yzw, r2, -r4.xxyz
mul r4.xyz, r2.yzww, c12.x
frc r4.xyz, r4_abs
cmp r1.xyz, r2.yzww, r4, -r4
mad r2.yzw, r0.xxyz, r3.x, -r2
mul r4.xyz, r2.yzww, r2.yzww
mad r5.xyz, r2.yzww, -c12.y, c12.z
mul r4.xyz, r4, r5
texldl r5, r1.xyww, s1
add r5, r1.z, r5
mul r6, r5.x, c11.xyyy
texldl r7, r6, s2
mad r1.xyz, r7, c11.z, c11.w
dp3 r1.x, r1, r2.yzww
add r7.xyz, r2.yzww, c11.wyyw
mul r8, r5.zxxx, c11.xyyy
texldl r9, r8, s2
mad r9.xyz, r9, c11.z, c11.w
dp3 r1.y, r9, r7
lrp r3.w, r4.x, r1.y, r1.x
add r1.xyz, r2.yzww, c11.ywyw
mul r7, r5.yxxx, c11.xyyy
texldl r9, r7, s2
mad r9.xyz, r9, c11.z, c11.w
dp3 r1.x, r9, r1
add r9.xyz, r2.yzww, c11.wwyw
mul r5, r5.wxxx, c11.xyyy
texldl r10, r5, s2
mad r10.xyz, r10, c11.z, c11.w
dp3 r1.y, r10, r9
lrp r9.x, r4.x, r1.y, r1.x
lrp r1.x, r4.y, r9.x, r3.w
add r9.xyz, r2.yzww, c11.yyww
add r6, r6, c12.xwww
texldl r6, r6, s2
mad r6.xyz, r6, c11.z, c11.w
dp3 r1.y, r6, r9
add r6.xyz, r2.yzww, c11.wyww
add r8, r8, c12.xwww
texldl r8, r8, s2
mad r8.xyz, r8, c11.z, c11.w
dp3 r1.z, r8, r6
lrp r3.w, r4.x, r1.z, r1.y
add r6.xyz, r2.yzww, c11.ywww
add r7, r7, c12.xwww
texldl r7, r7, s2
mad r7.xyz, r7, c11.z, c11.w
dp3 r1.y, r7, r6
add r2.yzw, r2, c11.w
add r5, r5, c12.xwww
texldl r5, r5, s2
mad r5.xyz, r5, c11.z, c11.w
dp3 r1.z, r5, r2.yzww
lrp r2.y, r4.x, r1.z, r1.y
lrp r1.y, r4.y, r2.y, r3.w
lrp r2.y, r4.z, r1.y, r1.x
add r1.x, -r2_abs.y, r2.x
mul r1.z, r1.x, r1.x
mul r2.y, r3.y, r1.z
mad r0.w, r2.y, r3.z, r0.w
mul r1.x, r3.x, c4.x
mul r1.y, r3.y, c5.x
mov r3.xyz, r1
endrep
texld r1, v0, s4
mov r2.w, c12.w
mov r1.x, c8.x
mov r1.y, c13.y
mov r1.z, c12.w
rep i1
mul r3.xyz, r0, r1.x
frc r4.xyz, r3
add r3.xyz, r3, -r4
mul r4.xyz, r3, c12.x
frc r4.xyz, r4_abs
cmp r2.xyz, r3, r4, -r4
mad r3.xyz, r0, r1.x, -r3
mul r4.xyz, r3, r3
mad r5.xyz, r3, -c12.y, c12.z
mul r4.xyz, r4, r5
texldl r5, r2.xyww, s1
add r5, r2.z, r5
mul r6, r5.x, c11.xyyy
texldl r7, r6, s2
mad r2.xyz, r7, c11.z, c11.w
dp3 r2.x, r2, r3
add r7.xyz, r3, c11.wyyw
mul r8, r5.zxxx, c11.xyyy
texldl r9, r8, s2
mad r9.xyz, r9, c11.z, c11.w
dp3 r2.y, r9, r7
lrp r3.w, r4.x, r2.y, r2.x
add r2.xyz, r3, c11.ywyw
mul r7, r5.yxxx, c11.xyyy
texldl r9, r7, s2
mad r9.xyz, r9, c11.z, c11.w
dp3 r2.x, r9, r2
add r9.xyz, r3, c11.wwyw
mul r5, r5.wxxx, c11.xyyy
texldl r10, r5, s2
mad r10.xyz, r10, c11.z, c11.w
dp3 r2.y, r10, r9
lrp r9.x, r4.x, r2.y, r2.x
lrp r2.x, r4.y, r9.x, r3.w
add r9.xyz, r3, c11.yyww
add r6, r6, c12.xwww
texldl r6, r6, s2
mad r6.xyz, r6, c11.z, c11.w
dp3 r2.y, r6, r9
add r6.xyz, r3, c11.wyww
add r8, r8, c12.xwww
texldl r8, r8, s2
mad r8.xyz, r8, c11.z, c11.w
dp3 r2.z, r8, r6
lrp r3.w, r4.x, r2.z, r2.y
add r6.xyz, r3, c11.ywww
add r7, r7, c12.xwww
texldl r7, r7, s2
mad r7.xyz, r7, c11.z, c11.w
dp3 r2.y, r7, r6
add r3.xyz, r3, c11.w
add r5, r5, c12.xwww
texldl r5, r5, s2
mad r5.xyz, r5, c11.z, c11.w
dp3 r2.z, r5, r3
lrp r3.x, r4.x, r2.z, r2.y
lrp r2.y, r4.y, r3.x, r3.w
lrp r3.x, r4.z, r2.y, r2.x
mad r1.z, r3.x, r1.y, r1.z
mul r1.x, r1.x, c4.x
mul r1.y, r1.y, c5.x
endrep
mul r0.x, r1.w, r1.z
mad r0.y, r0.w, c7.x, v3.y
mad r0.x, r0.x, c9.x, r0.y
add r0.x, r1.w, r0.x
mad r0.x, r0.x, c13.y, c13.w
mov r0.y, c12.w
texld_pp r0, r0, s3
mad r1, v2.xyzx, c11.xxxy, c11.yyyx
dp4 r2.x, c0, r1
dp4 r2.y, c1, r1
texld_pp r1, r2, s0
mul_pp r1.xyz, r1.w, c3
dp3_pp r0.w, v1, c2
max_pp r1.w, r0.w, c12.w
mul_pp r0.xyz, r0, r1
mul_pp oC0.xyz, r1.w, r0
mov_pp oC0.w, c11.x

"
}
SubProgram "d3d11 " {
// Stats: 169 math, 3 textures, 2 branches
Keywords { "DIRECTIONAL_COOKIE" }
SetTexture 0 [_PermTable2D] 2D 1
SetTexture 1 [_Gradient3D] 2D 2
SetTexture 2 [_StormMap] 2D 4
SetTexture 3 [_MainTex] 2D 3
SetTexture 4 [_LightTexture0] 2D 0
ConstBuffer "$Globals" 272
Matrix 144 [_LightMatrix0]
Vector 96 [_LightColor0]
Float 212 [_Lacunarity]
Float 216 [_Gain]
Float 220 [_MainFrequency]
Float 224 [_Distortion]
Float 228 [_StormFrequency]
Float 232 [_StormDistortion]
Vector 240 [_Evolution] 3
ConstBuffer "UnityLighting" 720
Vector 0 [_WorldSpaceLightPos0]
BindCB  "$Globals" 0
BindCB  "UnityLighting" 1
"ps_4_0
root12:afacafaa
eefiecedkkacjoejppfelpngbpkgjlbgegnaagaeabaaaaaahicdaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefchaccaaaaeaaaaaaajmaiaaaafjaaaaaeegiocaaaaaaaaaaabaaaaaaa
fjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafkaaaaadaagabaaaadaaaaaa
fkaaaaadaagabaaaaeaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaafibiaaae
aahabaaaadaaaaaaffffaaaafibiaaaeaahabaaaaeaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaaadaaaaaa
gcbaaaadhcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacalaaaaaa
aaaaaaaihcaabaaaaaaaaaaaegbcbaaaaeaaaaaaegiccaaaaaaaaaaaapaaaaaa
ebaaaaafhcaabaaaabaaaaaaegacbaaaaaaaaaaadiaaaaakhcaabaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaadaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaacaaaaaabkaaaaag
hcaabaaaacaaaaaaegacbaiaibaaaaaaacaaaaaadhaaaaakhcaabaaaacaaaaaa
egacbaaaadaaaaaaegacbaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaaaaaaai
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadiaaaaah
hcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadcaaaabahcaabaaa
aeaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaadaaaaaaegacbaaaaeaaaaaaeiaaaaalpcaabaaaaeaaaaaa
egaabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaabeaaaaaaaaaaaaa
aaaaaaahpcaabaaaacaaaaaakgakbaaaacaaaaaaiganbaaaaeaaaaaadgaaaaaf
fcaabaaaaeaaaaaaagabbaaaacaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaegaabaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaa
aaaaaaaaegacbaaaafaaaaaaegacbaaaabaaaaaaaaaaaaakhcaabaaaafaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaaeaaaaaaogakbaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaaeaaaaaaegacbaaaaeaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaaeaaaaaaegacbaaaafaaaaaa
aaaaaaaiicaabaaaabaaaaaadkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaa
dcaaaaajicaabaaaaaaaaaaaakaabaaaadaaaaaadkaabaaaabaaaaaadkaabaaa
aaaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaafaaaaaakgalbaaaacaaaaaa
dgaaaaaikcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
eiaaaaalpcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaa
aeaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
afaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaadaaaaaa
egacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaadaaaaaadkaabaia
ebaaaaaaabaaaaaadkaabaaaadaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaa
adaaaaaadkaabaaaadaaaaaadkaabaaaabaaaaaaaaaaaaaiicaabaaaabaaaaaa
dkaabaiaebaaaaaaaaaaaaaadkaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaa
bkaabaaaadaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaaaaaaaakpcaabaaa
acaaaaaacgahbaaaacaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaiadl
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaialpaaaaaaaadgaaaaaffcaabaaaafaaaaaafgahbaaaacaaaaaadgaaaaai
kcaabaaaafaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaagaaaaaaegaabaaaafaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaagaaaaaaegacbaaaagaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahicaabaaaabaaaaaaegacbaaaagaaaaaaegacbaaaaeaaaaaa
aaaaaaakhcaabaaaaeaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaaaaa
aaaaialpaaaaaaaaeiaaaaalpcaabaaaafaaaaaaogakbaaaafaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaafaaaaaa
egacbaaaafaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahicaabaaaadaaaaaaegacbaaa
afaaaaaaegacbaaaaeaaaaaaaaaaaaaiicaabaaaadaaaaaadkaabaiaebaaaaaa
abaaaaaadkaabaaaadaaaaaadcaaaaajicaabaaaabaaaaaaakaabaaaadaaaaaa
dkaabaaaadaaaaaadkaabaaaabaaaaaaaaaaaaakhcaabaaaaeaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaadgaaaaaikcaabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaa
afaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaafaaaaaaegacbaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaafaaaaaaegacbaaaaeaaaaaaaaaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaaeiaaaaalpcaabaaaaeaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaapocaabaaaacaaaaaaagajbaaa
aeaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaa
aaaaialpaaaaialpaaaaialpbaaaaaahbcaabaaaabaaaaaajgahbaaaacaaaaaa
egacbaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaaakaabaiaebaaaaaaacaaaaaa
akaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaaadaaaaaaakaabaaa
abaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaiaebaaaaaa
abaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaadaaaaaa
akaabaaaabaaaaaadkaabaaaabaaaaaaaaaaaaaibcaabaaaabaaaaaadkaabaia
ebaaaaaaaaaaaaaaakaabaaaabaaaaaadcaaaaajicaabaaaaaaaaaaackaabaaa
adaaaaaaakaabaaaabaaaaaadkaabaaaaaaaaaaadgaaaaaikcaabaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaa
aceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadgaaaaagccaabaaaafaaaaaa
dkiacaaaaaaaaaaaanaaaaaadgaaaaaincaabaaaafaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaadpaaaaiadpdgaaaaafbcaabaaaagaaaaaaabeaaaaaaaaaaaaa
daaaaaabcbaaaaahccaabaaaagaaaaaaakaabaaaagaaaaaaabeaaaaaaeaaaaaa
adaaaeadbkaabaaaagaaaaaadiaaaaahocaabaaaagaaaaaaagajbaaaaaaaaaaa
fgafbaaaafaaaaaaebaaaaafocaabaaaagaaaaaafgaobaaaagaaaaaadiaaaaak
hcaabaaaahaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadl
aaaaaaaabnaaaaaihcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaa
ahaaaaaabkaaaaaghcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaak
hcaabaaaahaaaaaaegacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaa
ahaaaaaadcaaaaakocaabaaaagaaaaaaagajbaaaaaaaaaaafgafbaaaafaaaaaa
fgaobaiaebaaaaaaagaaaaaadiaaaaahhcaabaaaaiaaaaaajgahbaaaagaaaaaa
jgahbaaaagaaaaaadcaaaabahcaabaaaajaaaaaajgahbaiaebaaaaaaagaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaea
aaaaeaeaaaaaaaaadiaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaa
ajaaaaaaeiaaaaalpcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaa
ahaaaaaaiganbaaaajaaaaaadgaaaaaffcaabaaaabaaaaaaagabbaaaahaaaaaa
eiaaaaalpcaabaaaajaaaaaaegaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahbcaabaaaabaaaaaaegacbaaaajaaaaaajgahbaaa
agaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaialp
aaaaaaaaaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaia
ebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaaakaabaaa
aiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaakhcaabaaaajaaaaaa
jgahbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaf
fcaabaaaacaaaaaakgalbaaaahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaa
acaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaa
abaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaa
jgahbaaaagaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaal
pcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaa
aaaaaaaibcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaa
dcaaaaajecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaa
abaaaaaaaaaaaaaiecaabaaaabaaaaaaakaabaiaebaaaaaaabaaaaaackaabaaa
abaaaaaadcaaaaajbcaabaaaabaaaaaabkaabaaaaiaaaaaackaabaaaabaaaaaa
akaabaaaabaaaaaaaaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaa
aaaaiadlaaaaiadlaaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaajgahbaaa
agaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaa
adaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaa
eghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaa
akaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaabaaaaaa
egacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaa
agaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaa
akaaaaaaogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaai
bcaabaaaacaaaaaackaabaiaebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaaj
ecaabaaaabaaaaaaakaabaaaaiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaa
aaaaaaakhcaabaaaajaaaaaajgahbaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaakgalbaaaahaaaaaaeiaaaaal
pcaabaaaahaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaa
abeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaabaaaaaahbcaabaaaacaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaa
aaaaaaakocaabaaaagaaaaaafgaobaaaagaaaaaaaceaaaaaaaaaaaaaaaaaialp
aaaaialpaaaaialpeiaaaaalpcaabaaaahaaaaaaogakbaaaaeaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaa
egacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
ahaaaaaajgahbaaaagaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaaaaaaaaaibcaabaaaacaaaaaackaabaia
ebaaaaaaabaaaaaaakaabaaaacaaaaaadcaaaaajecaabaaaabaaaaaabkaabaaa
aiaaaaaaakaabaaaacaaaaaackaabaaaabaaaaaaaaaaaaaiecaabaaaabaaaaaa
akaabaiaebaaaaaaabaaaaaackaabaaaabaaaaaadcaaaaajbcaabaaaabaaaaaa
ckaabaaaaiaaaaaackaabaaaabaaaaaaakaabaaaabaaaaaaaaaaaaaibcaabaaa
abaaaaaadkaabaaaaaaaaaaaakaabaiambaaaaaaabaaaaaadiaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaakaabaaaabaaaaaadiaaaaahecaabaaaabaaaaaa
ckaabaaaafaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaaafaaaaaackaabaaa
abaaaaaadkaabaaaafaaaaaaakaabaaaafaaaaaadiaaaaaigcaabaaaafaaaaaa
fgagbaaaafaaaaaafgigcaaaaaaaaaaaanaaaaaaboaaaaahbcaabaaaagaaaaaa
akaabaaaagaaaaaaabeaaaaaabaaaaaadgaaaaaficaabaaaafaaaaaaakaabaaa
abaaaaaabgaaaaabefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
acaaaaaaaagabaaaaeaaaaaadgaaaaaikcaabaaaacaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaaeaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaaikcaabaaaagaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaadgaaaaagbcaabaaaabaaaaaabkiacaaaaaaaaaaa
aoaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaaaaadgaaaaaigcaabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaaaaaaaaaaaadaaaaaabcbaaaaah
ccaabaaaafaaaaaackaabaaaabaaaaaaabeaaaaaadaaaaaaadaaaeadbkaabaaa
afaaaaaadiaaaaahocaabaaaafaaaaaaagajbaaaaaaaaaaaagaabaaaabaaaaaa
ebaaaaafocaabaaaafaaaaaafgaobaaaafaaaaaadiaaaaakhcaabaaaahaaaaaa
jgahbaaaafaaaaaaaceaaaaaaaaaiadlaaaaiadlaaaaiadlaaaaaaaabnaaaaai
hcaabaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaabkaaaaag
hcaabaaaahaaaaaaegacbaiaibaaaaaaahaaaaaadhaaaaakhcaabaaaahaaaaaa
egacbaaaaiaaaaaaegacbaaaahaaaaaaegacbaiaebaaaaaaahaaaaaadcaaaaak
ocaabaaaafaaaaaaagajbaaaaaaaaaaaagaabaaaabaaaaaafgaobaiaebaaaaaa
afaaaaaadiaaaaahhcaabaaaaiaaaaaajgahbaaaafaaaaaajgahbaaaafaaaaaa
dcaaaabahcaabaaaajaaaaaajgahbaiaebaaaaaaafaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaeaeaaaaaeaeaaaaaeaeaaaaaaaaa
diaaaaahhcaabaaaaiaaaaaaegacbaaaaiaaaaaaegacbaaaajaaaaaaeiaaaaal
pcaabaaaajaaaaaaegaabaaaahaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
abeaaaaaaaaaaaaaaaaaaaahpcaabaaaahaaaaaakgakbaaaahaaaaaaiganbaaa
ajaaaaaadgaaaaaffcaabaaaacaaaaaaagabbaaaahaaaaaaeiaaaaalpcaabaaa
ajaaaaaaegaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaa
aaaaaaaadcaaaaaphcaabaaaajaaaaaaegacbaaaajaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
baaaaaahbcaabaaaacaaaaaaegacbaaaajaaaaaajgahbaaaafaaaaaaaaaaaaak
hcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaialpaaaaaaaaaaaaaaaa
aaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaaacaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaa
ckaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaaakaabaaaaiaaaaaackaabaaa
acaaaaaaakaabaaaacaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaa
aceaaaaaaaaaaaaaaaaaialpaaaaaaaaaaaaaaaadgaaaaaffcaabaaaadaaaaaa
kgalbaaaahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaa
egacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaa
akaaaaaaegacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaaeiaaaaalpcaabaaaakaaaaaa
ogakbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaadaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaa
adaaaaaackaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaa
acaaaaaaakaabaaaaiaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaai
ecaabaaaacaaaaaaakaabaiaebaaaaaaacaaaaaackaabaaaacaaaaaadcaaaaaj
bcaabaaaacaaaaaabkaabaaaaiaaaaaackaabaaaacaaaaaaakaabaaaacaaaaaa
aaaaaaakpcaabaaaahaaaaaaegaobaaaahaaaaaaaceaaaaaaaaaiadlaaaaiadl
aaaaiadlaaaaiadlaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaialpaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagabbaaa
ahaaaaaaeiaaaaalpcaabaaaakaaaaaaegaabaaaaeaaaaaaeghobaaaabaaaaaa
aagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaakaaaaaaegacbaaa
akaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaabaaaaaahecaabaaaacaaaaaaegacbaaaakaaaaaa
egacbaaaajaaaaaaaaaaaaakhcaabaaaajaaaaaajgahbaaaafaaaaaaaceaaaaa
aaaaialpaaaaaaaaaaaaialpaaaaaaaaeiaaaaalpcaabaaaakaaaaaaogakbaaa
aeaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaadcaaaaap
hcaabaaaakaaaaaaegacbaaaakaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaahbcaabaaa
adaaaaaaegacbaaaakaaaaaaegacbaaaajaaaaaaaaaaaaaibcaabaaaadaaaaaa
ckaabaiaebaaaaaaacaaaaaaakaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaa
akaabaaaaiaaaaaaakaabaaaadaaaaaackaabaaaacaaaaaaaaaaaaakhcaabaaa
ajaaaaaajgahbaaaafaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaaaaa
dgaaaaaffcaabaaaagaaaaaakgalbaaaahaaaaaaeiaaaaalpcaabaaaahaaaaaa
egaabaaaagaaaaaaeghobaaaabaaaaaaaagabaaaacaaaaaaabeaaaaaaaaaaaaa
dcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaabaaaaaah
bcaabaaaadaaaaaaegacbaaaahaaaaaaegacbaaaajaaaaaaaaaaaaakocaabaaa
afaaaaaafgaobaaaafaaaaaaaceaaaaaaaaaaaaaaaaaialpaaaaialpaaaaialp
eiaaaaalpcaabaaaahaaaaaaogakbaaaagaaaaaaeghobaaaabaaaaaaaagabaaa
acaaaaaaabeaaaaaaaaaaaaadcaaaaaphcaabaaaahaaaaaaegacbaaaahaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaabaaaaaahecaabaaaadaaaaaaegacbaaaahaaaaaajgahbaaa
afaaaaaaaaaaaaaiecaabaaaadaaaaaaakaabaiaebaaaaaaadaaaaaackaabaaa
adaaaaaadcaaaaajbcaabaaaadaaaaaaakaabaaaaiaaaaaackaabaaaadaaaaaa
akaabaaaadaaaaaaaaaaaaaibcaabaaaadaaaaaackaabaiaebaaaaaaacaaaaaa
akaabaaaadaaaaaadcaaaaajecaabaaaacaaaaaabkaabaaaaiaaaaaaakaabaaa
adaaaaaackaabaaaacaaaaaaaaaaaaaiecaabaaaacaaaaaaakaabaiaebaaaaaa
acaaaaaackaabaaaacaaaaaadcaaaaajbcaabaaaacaaaaaackaabaaaaiaaaaaa
ckaabaaaacaaaaaaakaabaaaacaaaaaadcaaaaajicaabaaaaaaaaaaaakaabaaa
acaaaaaabkaabaaaabaaaaaadkaabaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaa
egaabaaaabaaaaaajgifcaaaaaaaaaaaanaaaaaaboaaaaahecaabaaaabaaaaaa
ckaabaaaabaaaaaaabeaaaaaabaaaaaabgaaaaabdiaaaaahbcaabaaaaaaaaaaa
dkaabaaaabaaaaaadkaabaaaaaaaaaaadcaaaaakccaabaaaaaaaaaaaakaabaaa
afaaaaaaakiacaaaaaaaaaaaaoaaaaaabkbabaaaaeaaaaaadcaaaaakbcaabaaa
aaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaaoaaaaaabkaabaaaaaaaaaaa
aaaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaaakaabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaaalp
dgaaaaafccaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaadaaaaaaaagabaaaadaaaaaadiaaaaaidcaabaaa
abaaaaaafgbfbaaaadaaaaaaegiacaaaaaaaaaaaakaaaaaadcaaaaakdcaabaaa
abaaaaaaegiacaaaaaaaaaaaajaaaaaaagbabaaaadaaaaaaegaabaaaabaaaaaa
dcaaaaakdcaabaaaabaaaaaaegiacaaaaaaaaaaaalaaaaaakgbkbaaaadaaaaaa
egaabaaaabaaaaaaaaaaaaaidcaabaaaabaaaaaaegaabaaaabaaaaaaegiacaaa
aaaaaaaaamaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaa
aeaaaaaaaagabaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaapgapbaaaabaaaaaa
egiccaaaaaaaaaaaagaaaaaabaaaaaaiicaabaaaaaaaaaaaegbcbaaaacaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaiadpdoaaaaab"
}
}
 }
}
Fallback "Diffuse"
}