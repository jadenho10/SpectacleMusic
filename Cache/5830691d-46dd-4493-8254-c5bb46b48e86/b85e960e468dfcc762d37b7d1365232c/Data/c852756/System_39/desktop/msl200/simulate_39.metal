#pragma clang diagnostic ignored "-Wmissing-prototypes"
#include <metal_stdlib>
#include <simd/simd.h>
using namespace metal;
//efine SC_DISABLE_FRUSTUM_CULLING
#define SC_ALLOW_16_TEXTURES
#define SC_ENABLE_INSTANCED_RENDERING
namespace SNAP_VS {
int sc_GetStereoViewIndex()
{
    return 0;
}
}
    #ifndef sc_TextureRenderingLayout_Regular
        #define sc_TextureRenderingLayout_Regular 0
        #define sc_TextureRenderingLayout_StereoInstancedClipped 1
        #define sc_TextureRenderingLayout_StereoMultiview 2
    #endif
    #define depthToGlobal   depthScreenToViewSpace
    #define depthToLocal    depthViewToScreenSpace
    #ifndef quantizeUV
        #define quantizeUV sc_QuantizeUV
        #define sc_platformUVFlip sc_PlatformFlipV
        #define sc_PlatformFlipUV sc_PlatformFlipV
    #endif
    #ifndef sc_SampleTexture
        #define sc_SampleTexture sc_SampleTextureBiasOrLevel
    #endif
    #ifndef sc_texture2DLod
        #define sc_texture2DLod sc_InternalTextureLevel
        #define sc_textureLod sc_InternalTextureLevel
        #define sc_textureBias sc_InternalTextureBiasOrLevel
        #define sc_texture sc_InternalTexture
    #endif
//SG_REFLECTION_BEGIN(200)
//attribute vec4 position 0
//attribute vec2 texture0 3
//attribute vec2 texture1 4
//attribute vec3 normal 1
//attribute vec4 tangent 2
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//sampler sampler renderTarget0SmpSC 0:20
//sampler sampler renderTarget1SmpSC 0:21
//sampler sampler renderTarget2SmpSC 0:22
//sampler sampler renderTarget3SmpSC 0:23
//texture texture2D renderTarget0 0:1:0:20
//texture texture2D renderTarget1 0:2:0:21
//texture texture2D renderTarget2 0:3:0:22
//texture texture2D renderTarget3 0:4:0:23
//ubo int UserUniforms 0:31:7696 {
//sc_PointLight_t sc_PointLights 0:[3]:80
//bool sc_PointLights.falloffEnabled 0
//float sc_PointLights.falloffEndDistance 4
//float sc_PointLights.negRcpFalloffEndDistance4 8
//float sc_PointLights.angleScale 12
//float sc_PointLights.angleOffset 16
//float3 sc_PointLights.direction 32
//float3 sc_PointLights.position 48
//float4 sc_PointLights.color 64
//sc_DirectionalLight_t sc_DirectionalLights 240:[5]:32
//float3 sc_DirectionalLights.direction 0
//float4 sc_DirectionalLights.color 16
//sc_AmbientLight_t sc_AmbientLights 400:[3]:32
//float3 sc_AmbientLights.color 0
//float sc_AmbientLights.intensity 16
//sc_LightEstimationData_t sc_LightEstimationData 496
//sc_SphericalGaussianLight_t sc_LightEstimationData.sg 0:[12]:48
//float3 sc_LightEstimationData.sg.color 0
//float sc_LightEstimationData.sg.sharpness 16
//float3 sc_LightEstimationData.sg.axis 32
//float3 sc_LightEstimationData.ambientLight 576
//float4 sc_EnvmapDiffuseSize 1088
//float4 sc_EnvmapDiffuseDims 1104
//float4 sc_EnvmapDiffuseView 1120
//float4 sc_EnvmapSpecularSize 1136
//float4 sc_EnvmapSpecularDims 1152
//float4 sc_EnvmapSpecularView 1168
//float3 sc_EnvmapRotation 1184
//float sc_EnvmapExposure 1200
//float3 sc_Sh 1216:[9]:16
//float sc_ShIntensity 1360
//float4 sc_Time 1376
//float4 sc_UniformConstants 1392
//float4 sc_GeometryInfo 1408
//float4x4 sc_ModelViewProjectionMatrixArray 1424:[2]:64
//float4x4 sc_ModelViewProjectionMatrixInverseArray 1552:[2]:64
//float4x4 sc_ViewProjectionMatrixArray 1680:[2]:64
//float4x4 sc_ViewProjectionMatrixInverseArray 1808:[2]:64
//float4x4 sc_ModelViewMatrixArray 1936:[2]:64
//float4x4 sc_ModelViewMatrixInverseArray 2064:[2]:64
//float3x3 sc_ViewNormalMatrixArray 2192:[2]:48
//float3x3 sc_ViewNormalMatrixInverseArray 2288:[2]:48
//float4x4 sc_ProjectionMatrixArray 2384:[2]:64
//float4x4 sc_ProjectionMatrixInverseArray 2512:[2]:64
//float4x4 sc_ViewMatrixArray 2640:[2]:64
//float4x4 sc_ViewMatrixInverseArray 2768:[2]:64
//float4x4 sc_PrevFrameViewProjectionMatrixArray 2896:[2]:64
//float4x4 sc_ModelMatrix 3024
//float4x4 sc_ModelMatrixInverse 3088
//float3x3 sc_NormalMatrix 3152
//float3x3 sc_NormalMatrixInverse 3200
//float4x4 sc_PrevFrameModelMatrix 3248
//float4x4 sc_PrevFrameModelMatrixInverse 3312
//float3 sc_LocalAabbMin 3376
//float3 sc_LocalAabbMax 3392
//float3 sc_WorldAabbMin 3408
//float3 sc_WorldAabbMax 3424
//float4 sc_WindowToViewportTransform 3440
//float4 sc_CurrentRenderTargetDims 3456
//sc_Camera_t sc_Camera 3472
//float3 sc_Camera.position 0
//float sc_Camera.aspect 16
//float2 sc_Camera.clipPlanes 24
//float sc_ShadowDensity 3504
//float4 sc_ShadowColor 3520
//float4x4 sc_ProjectorMatrix 3536
//float _sc_GetFramebufferColorInvalidUsageMarker 3600
//float shaderComplexityValue 3604
//float sc_DisableFrustumCullingMarker 3608
//float4 weights0 3616
//float4 weights1 3632
//float4 weights2 3648
//float4 sc_StereoClipPlanes 3664:[2]:16
//int sc_FallbackInstanceID 3696
//float _sc_framebufferFetchMarker 3700
//float2 sc_TAAJitterOffset 3704
//float strandWidth 3712
//float strandTaper 3716
//float4 sc_StrandDataMapTextureSize 3728
//float clumpInstanceCount 3744
//float clumpRadius 3748
//float clumpTipScale 3752
//float hairstyleInstanceCount 3756
//float hairstyleNoise 3760
//float4 sc_ScreenTextureSize 3776
//float4 sc_ScreenTextureDims 3792
//float4 sc_ScreenTextureView 3808
//float correctedIntensity 3824
//float4 intensityTextureSize 3840
//float4 intensityTextureDims 3856
//float4 intensityTextureView 3872
//float3x3 intensityTextureTransform 3888
//float4 intensityTextureUvMinMax 3936
//float4 intensityTextureBorderColor 3952
//float reflBlurWidth 3968
//float reflBlurMinRough 3972
//float reflBlurMaxRough 3976
//int overrideTimeEnabled 3980
//float overrideTimeElapsed 3984
//float overrideTimeDelta 3988
//int vfxNumCopies 3992
//bool vfxBatchEnable 3996:[32]:4
//bool vfxEmitParticle 4124:[32]:4
//float4x4 vfxModelMatrix 4256:[32]:64
//float4 renderTarget0Size 6304
//float4 renderTarget0Dims 6320
//float4 renderTarget0View 6336
//float4 renderTarget1Size 6352
//float4 renderTarget1Dims 6368
//float4 renderTarget1View 6384
//float4 renderTarget2Size 6400
//float4 renderTarget2Dims 6416
//float4 renderTarget2View 6432
//float4 renderTarget3Size 6448
//float4 renderTarget3Dims 6464
//float4 renderTarget3View 6480
//float3 vfxLocalAabbMin 6496
//float3 vfxLocalAabbMax 6512
//float vfxCameraAspect 6528
//float vfxCameraNear 6532
//float vfxCameraFar 6536
//float3 vfxCameraUp 6544
//float3 vfxCameraForward 6560
//float3 vfxCameraRight 6576
//float4x4 vfxProjectionMatrix 6592
//float4x4 vfxProjectionMatrixInverse 6656
//float4x4 vfxViewMatrix 6720
//float4x4 vfxViewMatrixInverse 6784
//float4x4 vfxViewProjectionMatrix 6848
//float4x4 vfxViewProjectionMatrixInverse 6912
//int vfxFrame 6976
//int vfxOffsetInstancesRead 6980
//int vfxOffsetInstancesWrite 6984
//float2 vfxTargetSizeRead 6992
//float2 vfxTargetSizeWrite 7000
//int vfxTargetWidth 7008
//float particles_speed 7012
//float particlesReduce 7016
//float Tweak_N12 7020
//float particle_scale 7024
//float3 Port_Import_N216 7040
//float Port_Input1_N149 7056
//float3 Port_Min_N150 7072
//float3 Port_Max_N150 7088
//float Port_Import_N151 7104
//float Port_Input1_N153 7108
//float3 Port_Max_N154 7120
//float Port_Import_N157 7136
//float3 Port_Import_N158 7152
//float Port_Input1_N162 7168
//float Port_Input1_N165 7172
//float Port_Import_N042 7176
//float Port_Import_N043 7180
//float Port_Import_N023 7184
//float Port_Import_N024 7188
//float Port_Import_N053 7192
//float3 Port_Import_N054 7200
//float3 Port_Import_N187 7216
//float Port_Import_N189 7232
//float3 Port_Import_N142 7248
//float3 Port_Import_N006 7264
//float Port_Input1_N014 7280
//float3 Port_Import_N206 7296
//float3 Port_Import_N208 7312
//float3 Port_Import_N318 7328
//float Port_Multiplier_N319 7344
//float3 Port_Import_N322 7360
//float2 Port_Input1_N326 7376
//float2 Port_Scale_N327 7384
//float2 Port_Input1_N329 7392
//float2 Port_Scale_N330 7400
//float2 Port_Input1_N332 7408
//float2 Port_Scale_N333 7416
//float3 Port_Input1_N335 7424
//float Port_Import_N126 7440
//float Port_Import_N127 7444
//float Port_Import_N128 7448
//float Port_Input4_N137 7452
//float Port_Multiplier_N272 7456
//float3 Port_Import_N112 7472
//float Port_Value1_N213 7488
//float Port_Value2_N213 7492
//float Port_Value3_N213 7496
//float3 Port_Import_N113 7504
//float Port_Import_N114 7520
//float Port_Import_N115 7524
//float Port_Import_N116 7528
//float Port_CollisionCount_N118 7532
//float Port_VelocityThreshold_N118 7536
//float Port_DefaultFloat_N119 7540
//float Port_Input1_N171 7544
//float Port_Input1_N109 7548
//float Port_Input2_N109 7552
//float Port_Input1_N184 7556
//float4 Port_Value0_N176 7568
//float Port_Position1_N176 7584
//float4 Port_Value1_N176 7600
//float Port_Position2_N176 7616
//float4 Port_Value2_N176 7632
//float Port_Position3_N176 7648
//float4 Port_Value3_N176 7664
//float4 Port_Value4_N176 7680
//}
//spec_const bool renderTarget0HasSwappedViews 0
//spec_const bool renderTarget1HasSwappedViews 1
//spec_const bool renderTarget2HasSwappedViews 2
//spec_const bool renderTarget3HasSwappedViews 3
//spec_const int SC_DEVICE_CLASS 4
//spec_const int renderTarget0Layout 5
//spec_const int renderTarget1Layout 6
//spec_const int renderTarget2Layout 7
//spec_const int renderTarget3Layout 8
//spec_const int sc_ShaderCacheConstant 9
//spec_const int sc_StereoRenderingMode 10
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 11
//SG_REFLECTION_END
constant bool renderTarget0HasSwappedViews [[function_constant(0)]];
constant bool renderTarget0HasSwappedViews_tmp = is_function_constant_defined(renderTarget0HasSwappedViews) ? renderTarget0HasSwappedViews : false;
constant bool renderTarget1HasSwappedViews [[function_constant(1)]];
constant bool renderTarget1HasSwappedViews_tmp = is_function_constant_defined(renderTarget1HasSwappedViews) ? renderTarget1HasSwappedViews : false;
constant bool renderTarget2HasSwappedViews [[function_constant(2)]];
constant bool renderTarget2HasSwappedViews_tmp = is_function_constant_defined(renderTarget2HasSwappedViews) ? renderTarget2HasSwappedViews : false;
constant bool renderTarget3HasSwappedViews [[function_constant(3)]];
constant bool renderTarget3HasSwappedViews_tmp = is_function_constant_defined(renderTarget3HasSwappedViews) ? renderTarget3HasSwappedViews : false;
constant int SC_DEVICE_CLASS [[function_constant(4)]];
constant int SC_DEVICE_CLASS_tmp = is_function_constant_defined(SC_DEVICE_CLASS) ? SC_DEVICE_CLASS : -1;
constant int renderTarget0Layout [[function_constant(5)]];
constant int renderTarget0Layout_tmp = is_function_constant_defined(renderTarget0Layout) ? renderTarget0Layout : 0;
constant int renderTarget1Layout [[function_constant(6)]];
constant int renderTarget1Layout_tmp = is_function_constant_defined(renderTarget1Layout) ? renderTarget1Layout : 0;
constant int renderTarget2Layout [[function_constant(7)]];
constant int renderTarget2Layout_tmp = is_function_constant_defined(renderTarget2Layout) ? renderTarget2Layout : 0;
constant int renderTarget3Layout [[function_constant(8)]];
constant int renderTarget3Layout_tmp = is_function_constant_defined(renderTarget3Layout) ? renderTarget3Layout : 0;
constant int sc_ShaderCacheConstant [[function_constant(9)]];
constant int sc_ShaderCacheConstant_tmp = is_function_constant_defined(sc_ShaderCacheConstant) ? sc_ShaderCacheConstant : 0;
constant int sc_StereoRenderingMode [[function_constant(10)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(11)]];
constant int sc_StereoRendering_IsClipDistanceEnabled_tmp = is_function_constant_defined(sc_StereoRendering_IsClipDistanceEnabled) ? sc_StereoRendering_IsClipDistanceEnabled : 0;

namespace SNAP_VS {
struct sc_Vertex_t
{
float4 position;
float3 normal;
float3 tangent;
float2 texture0;
float2 texture1;
};
struct ssParticle
{
float3 Position;
float3 Velocity;
float4 Color;
float Size;
float Age;
float Life;
float Mass;
float3x3 Matrix;
bool Dead;
float4 Quaternion;
float SpawnIndex;
float SpawnIndexRemainder;
float NextBurstTime;
float collisionCount_N119;
float SpawnOffset;
float Seed;
float2 Seed2000;
float TimeShift;
int Index1D;
int Index1DPerCopy;
float Index1DPerCopyF;
int StateID;
float Coord1D;
float Ratio1D;
float Ratio1DPerCopy;
int2 Index2D;
float2 Coord2D;
float2 Ratio2D;
float3 Force;
bool Spawned;
float CopyId;
float SpawnAmount;
float BurstAmount;
float BurstPeriod;
};
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
};
struct N118_CollisionPlane
{
bool isColliding;
float3 velocity;
float3 position;
float3 force;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[5];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
float4 sc_CurrentRenderTargetDims;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int vfxNumCopies;
int vfxBatchEnable[32];
int vfxEmitParticle[32];
float4x4 vfxModelMatrix[32];
float4 renderTarget0Size;
float4 renderTarget0Dims;
float4 renderTarget0View;
float4 renderTarget1Size;
float4 renderTarget1Dims;
float4 renderTarget1View;
float4 renderTarget2Size;
float4 renderTarget2Dims;
float4 renderTarget2View;
float4 renderTarget3Size;
float4 renderTarget3Dims;
float4 renderTarget3View;
float3 vfxLocalAabbMin;
float3 vfxLocalAabbMax;
float vfxCameraAspect;
float vfxCameraNear;
float vfxCameraFar;
float3 vfxCameraUp;
float3 vfxCameraForward;
float3 vfxCameraRight;
float4x4 vfxProjectionMatrix;
float4x4 vfxProjectionMatrixInverse;
float4x4 vfxViewMatrix;
float4x4 vfxViewMatrixInverse;
float4x4 vfxViewProjectionMatrix;
float4x4 vfxViewProjectionMatrixInverse;
int vfxFrame;
int vfxOffsetInstancesRead;
int vfxOffsetInstancesWrite;
float2 vfxTargetSizeRead;
float2 vfxTargetSizeWrite;
int vfxTargetWidth;
float particles_speed;
float particlesReduce;
float Tweak_N12;
float particle_scale;
float3 Port_Import_N216;
float Port_Input1_N149;
float3 Port_Min_N150;
float3 Port_Max_N150;
float Port_Import_N151;
float Port_Input1_N153;
float3 Port_Max_N154;
float Port_Import_N157;
float3 Port_Import_N158;
float Port_Input1_N162;
float Port_Input1_N165;
float Port_Import_N042;
float Port_Import_N043;
float Port_Import_N023;
float Port_Import_N024;
float Port_Import_N053;
float3 Port_Import_N054;
float3 Port_Import_N187;
float Port_Import_N189;
float3 Port_Import_N142;
float3 Port_Import_N006;
float Port_Input1_N014;
float3 Port_Import_N206;
float3 Port_Import_N208;
float3 Port_Import_N318;
float Port_Multiplier_N319;
float3 Port_Import_N322;
float2 Port_Input1_N326;
float2 Port_Scale_N327;
float2 Port_Input1_N329;
float2 Port_Scale_N330;
float2 Port_Input1_N332;
float2 Port_Scale_N333;
float3 Port_Input1_N335;
float Port_Import_N126;
float Port_Import_N127;
float Port_Import_N128;
float Port_Input4_N137;
float Port_Multiplier_N272;
float3 Port_Import_N112;
float Port_Value1_N213;
float Port_Value2_N213;
float Port_Value3_N213;
float3 Port_Import_N113;
float Port_Import_N114;
float Port_Import_N115;
float Port_Import_N116;
float Port_CollisionCount_N118;
float Port_VelocityThreshold_N118;
float Port_DefaultFloat_N119;
float Port_Input1_N171;
float Port_Input1_N109;
float Port_Input2_N109;
float Port_Input1_N184;
float4 Port_Value0_N176;
float Port_Position1_N176;
float4 Port_Value1_N176;
float Port_Position2_N176;
float4 Port_Value2_N176;
float Port_Position3_N176;
float4 Port_Value3_N176;
float4 Port_Value4_N176;
};
struct sc_Set0
{
texture2d<float> renderTarget0 [[id(1)]];
texture2d<float> renderTarget1 [[id(2)]];
texture2d<float> renderTarget2 [[id(3)]];
texture2d<float> renderTarget3 [[id(4)]];
sampler renderTarget0SmpSC [[id(20)]];
sampler renderTarget1SmpSC [[id(21)]];
sampler renderTarget2SmpSC [[id(22)]];
sampler renderTarget3SmpSC [[id(23)]];
constant userUniformsObj* UserUniforms [[id(31)]];
};
struct main_vert_out
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float2 varShadowTex [[user(locn6)]];
int varStereoViewID [[user(locn7)]];
float varClipDistance [[user(locn8)]];
float4 varColor [[user(locn9)]];
int Interp_Particle_Index [[user(locn10)]];
float3 Interp_Particle_Force [[user(locn11)]];
float2 Interp_Particle_Coord [[user(locn12)]];
float Interp_Particle_SpawnIndex [[user(locn13)]];
float Interp_Particle_NextBurstTime [[user(locn14)]];
float3 Interp_Particle_Position [[user(locn15)]];
float3 Interp_Particle_Velocity [[user(locn16)]];
float Interp_Particle_Life [[user(locn17)]];
float Interp_Particle_Age [[user(locn18)]];
float Interp_Particle_Size [[user(locn19)]];
float4 Interp_Particle_Color [[user(locn20)]];
float4 Interp_Particle_Quaternion [[user(locn21)]];
float Interp_Particle_collisionCount_N119 [[user(locn22)]];
float Interp_Particle_Mass [[user(locn23)]];
float4 gl_Position [[position]];
};
struct main_vert_in
{
float4 position [[attribute(0)]];
float3 normal [[attribute(1)]];
float4 tangent [[attribute(2)]];
float2 texture0 [[attribute(3)]];
float2 texture1 [[attribute(4)]];
};
// Implementation of the GLSL mod() function,which is slightly different than Metal fmod()
template<typename Tx,typename Ty>
Tx mod(Tx x,Ty y)
{
return x-y*floor(x/y);
}
bool ssDecodeParticle(thread const int& InstanceID,thread uint& gl_InstanceIndex,constant userUniformsObj& UserUniforms,thread texture2d<float> renderTarget0,thread sampler renderTarget0SmpSC,thread texture2d<float> renderTarget1,thread sampler renderTarget1SmpSC,thread texture2d<float> renderTarget2,thread sampler renderTarget2SmpSC,thread texture2d<float> renderTarget3,thread sampler renderTarget3SmpSC,thread ssParticle& gParticle)
{
gParticle.Position=float3(0.0);
gParticle.Velocity=float3(0.0);
gParticle.Color=float4(0.0);
gParticle.Size=0.0;
gParticle.Age=0.0;
gParticle.Life=0.0;
gParticle.Mass=1.0;
gParticle.Matrix=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
gParticle.Quaternion=float4(0.0,0.0,0.0,1.0);
gParticle.CopyId=float(InstanceID/40);
gParticle.SpawnIndex=-1.0;
gParticle.SpawnIndexRemainder=-1.0;
gParticle.SpawnAmount=0.0;
gParticle.BurstAmount=0.0;
gParticle.BurstPeriod=0.0;
gParticle.NextBurstTime=0.0;
int param=InstanceID;
ssParticle param_1=gParticle;
param_1.Spawned=false;
param_1.Dead=false;
param_1.Force=float3(0.0);
param_1.Index1D=param;
param_1.Index1DPerCopy=param%40;
param_1.Index1DPerCopyF=float(param_1.Index1DPerCopy);
param_1.StateID=(40*((param/40)+1))-1;
int l9_0=param_1.Index1D;
int2 l9_1=int2(l9_0%40,l9_0/40);
param_1.Index2D=l9_1;
int l9_2=param_1.Index1D;
float l9_3=(float(l9_2)+0.5)/40.0;
param_1.Coord1D=l9_3;
int2 l9_4=param_1.Index2D;
float2 l9_5=(float2(l9_4)+float2(0.5))/float2(40.0,1.0);
param_1.Coord2D=l9_5;
int l9_6=param_1.Index1D;
float l9_7=float(l9_6)/39.0;
param_1.Ratio1D=l9_7;
int l9_8=param_1.Index1DPerCopy;
float l9_9=float(l9_8)/39.0;
param_1.Ratio1DPerCopy=l9_9;
int2 l9_10=param_1.Index2D;
float2 l9_11=float2(l9_10)/float2(39.0,1.0);
param_1.Ratio2D=l9_11;
param_1.Seed=0.0;
int l9_12=param_1.Index1D;
int l9_13=l9_12;
int l9_14=((l9_13*((l9_13*1471343)+101146501))+1559861749)&2147483647;
int l9_15=l9_14;
float l9_16=float(l9_15)*4.6566129e-10;
float l9_17=l9_16;
param_1.TimeShift=l9_17;
param_1.SpawnOffset=param_1.Ratio1D*0.2;
ssParticle l9_18=param_1;
float l9_19;
if (UserUniforms.overrideTimeEnabled==1)
{
l9_19=UserUniforms.overrideTimeElapsed;
}
else
{
l9_19=UserUniforms.sc_Time.x;
}
float l9_20=l9_19;
l9_18.Seed=(l9_18.Ratio1D*0.97637898)+0.151235;
l9_18.Seed+=(floor(((((l9_20-l9_18.SpawnOffset)-0.0)+0.0)+0.40000001)/0.2)*4.32723);
l9_18.Seed=fract(abs(l9_18.Seed));
int2 l9_21=int2(l9_18.Index1D%400,l9_18.Index1D/400);
l9_18.Seed2000=(float2(l9_21)+float2(1.0))/float2(399.0);
param_1=l9_18;
gParticle=param_1;
int offsetPixelId=(UserUniforms.vfxOffsetInstancesRead+InstanceID)*4;
int param_2=offsetPixelId;
int param_3=UserUniforms.vfxTargetWidth;
int l9_22=param_2-((param_2/param_3)*param_3);
int2 Index2D=int2(l9_22,offsetPixelId/UserUniforms.vfxTargetWidth);
float2 Coord=(float2(Index2D)+float2(0.5))/float2(2048.0,UserUniforms.vfxTargetSizeRead.y);
float2 Offset=float2(0.00048828125,0.0);
float2 uv=float2(0.0);
float Scalar0=0.0;
float Scalar1=0.0;
float Scalar2=0.0;
float Scalar3=0.0;
float Scalar4=0.0;
float Scalar5=0.0;
float Scalar6=0.0;
float Scalar7=0.0;
float Scalar8=0.0;
float Scalar9=0.0;
float Scalar10=0.0;
float Scalar11=0.0;
float Scalar12=0.0;
float Scalar13=0.0;
float Scalar14=0.0;
float Scalar15=0.0;
uv=Coord+(Offset*0.0);
float2 param_4=uv;
int l9_23=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_24=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_24=0;
}
else
{
l9_24=gl_InstanceIndex%2;
}
int l9_25=l9_24;
l9_23=1-l9_25;
}
else
{
int l9_26=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_26=0;
}
else
{
l9_26=gl_InstanceIndex%2;
}
int l9_27=l9_26;
l9_23=l9_27;
}
int l9_28=l9_23;
float2 l9_29=param_4;
int l9_30=l9_28;
float2 l9_31=l9_29;
int l9_32=l9_30;
float l9_33=0.0;
float4 l9_34=float4(0.0);
float2 l9_35=l9_31;
int l9_36=l9_32;
float l9_37=l9_33;
float4 l9_38=float4(0.0);
float2 l9_39=l9_35;
int l9_40=renderTarget0Layout_tmp;
int l9_41=l9_36;
float l9_42=l9_37;
float2 l9_43=l9_39;
int l9_44=l9_40;
int l9_45=l9_41;
float3 l9_46=float3(0.0);
if (l9_44==0)
{
l9_46=float3(l9_43,0.0);
}
else
{
if (l9_44==1)
{
l9_46=float3(l9_43.x,(l9_43.y*0.5)+(0.5-(float(l9_45)*0.5)),0.0);
}
else
{
l9_46=float3(l9_43,float(l9_45));
}
}
float3 l9_47=l9_46;
float3 l9_48=l9_47;
float2 l9_49=l9_48.xy;
float l9_50=l9_42;
float4 l9_51=renderTarget0.sample(renderTarget0SmpSC,l9_49,level(l9_50));
float4 l9_52=l9_51;
l9_38=l9_52;
float4 l9_53=l9_38;
l9_34=l9_53;
float4 l9_54=l9_34;
float4 l9_55=l9_54;
float4 l9_56=l9_55;
float4 renderTarget0Sample=l9_56;
float4 l9_57=renderTarget0Sample;
bool l9_58=dot(abs(l9_57),float4(1.0))<9.9999997e-06;
bool l9_59;
if (!l9_58)
{
int l9_60=gl_InstanceIndex;
l9_59=!(UserUniforms.vfxBatchEnable[l9_60/40]!=0);
}
else
{
l9_59=l9_58;
}
if (l9_59)
{
return false;
}
Scalar0=renderTarget0Sample.x;
Scalar1=renderTarget0Sample.y;
Scalar2=renderTarget0Sample.z;
Scalar3=renderTarget0Sample.w;
float2 param_5=uv;
int l9_61=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_62=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_62=0;
}
else
{
l9_62=gl_InstanceIndex%2;
}
int l9_63=l9_62;
l9_61=1-l9_63;
}
else
{
int l9_64=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_64=0;
}
else
{
l9_64=gl_InstanceIndex%2;
}
int l9_65=l9_64;
l9_61=l9_65;
}
int l9_66=l9_61;
float2 l9_67=param_5;
int l9_68=l9_66;
float2 l9_69=l9_67;
int l9_70=l9_68;
float l9_71=0.0;
float4 l9_72=float4(0.0);
float2 l9_73=l9_69;
int l9_74=l9_70;
float l9_75=l9_71;
float4 l9_76=float4(0.0);
float2 l9_77=l9_73;
int l9_78=renderTarget1Layout_tmp;
int l9_79=l9_74;
float l9_80=l9_75;
float2 l9_81=l9_77;
int l9_82=l9_78;
int l9_83=l9_79;
float3 l9_84=float3(0.0);
if (l9_82==0)
{
l9_84=float3(l9_81,0.0);
}
else
{
if (l9_82==1)
{
l9_84=float3(l9_81.x,(l9_81.y*0.5)+(0.5-(float(l9_83)*0.5)),0.0);
}
else
{
l9_84=float3(l9_81,float(l9_83));
}
}
float3 l9_85=l9_84;
float3 l9_86=l9_85;
float2 l9_87=l9_86.xy;
float l9_88=l9_80;
float4 l9_89=renderTarget1.sample(renderTarget1SmpSC,l9_87,level(l9_88));
float4 l9_90=l9_89;
l9_76=l9_90;
float4 l9_91=l9_76;
l9_72=l9_91;
float4 l9_92=l9_72;
float4 l9_93=l9_92;
float4 l9_94=l9_93;
float4 renderTarget1Sample=l9_94;
Scalar4=renderTarget1Sample.x;
Scalar5=renderTarget1Sample.y;
Scalar6=renderTarget1Sample.z;
Scalar7=renderTarget1Sample.w;
float2 param_6=uv;
int l9_95=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_96=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_96=0;
}
else
{
l9_96=gl_InstanceIndex%2;
}
int l9_97=l9_96;
l9_95=1-l9_97;
}
else
{
int l9_98=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_98=0;
}
else
{
l9_98=gl_InstanceIndex%2;
}
int l9_99=l9_98;
l9_95=l9_99;
}
int l9_100=l9_95;
float2 l9_101=param_6;
int l9_102=l9_100;
float2 l9_103=l9_101;
int l9_104=l9_102;
float l9_105=0.0;
float4 l9_106=float4(0.0);
float2 l9_107=l9_103;
int l9_108=l9_104;
float l9_109=l9_105;
float4 l9_110=float4(0.0);
float2 l9_111=l9_107;
int l9_112=renderTarget2Layout_tmp;
int l9_113=l9_108;
float l9_114=l9_109;
float2 l9_115=l9_111;
int l9_116=l9_112;
int l9_117=l9_113;
float3 l9_118=float3(0.0);
if (l9_116==0)
{
l9_118=float3(l9_115,0.0);
}
else
{
if (l9_116==1)
{
l9_118=float3(l9_115.x,(l9_115.y*0.5)+(0.5-(float(l9_117)*0.5)),0.0);
}
else
{
l9_118=float3(l9_115,float(l9_117));
}
}
float3 l9_119=l9_118;
float3 l9_120=l9_119;
float2 l9_121=l9_120.xy;
float l9_122=l9_114;
float4 l9_123=renderTarget2.sample(renderTarget2SmpSC,l9_121,level(l9_122));
float4 l9_124=l9_123;
l9_110=l9_124;
float4 l9_125=l9_110;
l9_106=l9_125;
float4 l9_126=l9_106;
float4 l9_127=l9_126;
float4 l9_128=l9_127;
float4 renderTarget2Sample=l9_128;
Scalar8=renderTarget2Sample.x;
Scalar9=renderTarget2Sample.y;
Scalar10=renderTarget2Sample.z;
Scalar11=renderTarget2Sample.w;
float2 param_7=uv;
int l9_129=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_130=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_130=0;
}
else
{
l9_130=gl_InstanceIndex%2;
}
int l9_131=l9_130;
l9_129=1-l9_131;
}
else
{
int l9_132=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_132=0;
}
else
{
l9_132=gl_InstanceIndex%2;
}
int l9_133=l9_132;
l9_129=l9_133;
}
int l9_134=l9_129;
float2 l9_135=param_7;
int l9_136=l9_134;
float2 l9_137=l9_135;
int l9_138=l9_136;
float l9_139=0.0;
float4 l9_140=float4(0.0);
float2 l9_141=l9_137;
int l9_142=l9_138;
float l9_143=l9_139;
float4 l9_144=float4(0.0);
float2 l9_145=l9_141;
int l9_146=renderTarget3Layout_tmp;
int l9_147=l9_142;
float l9_148=l9_143;
float2 l9_149=l9_145;
int l9_150=l9_146;
int l9_151=l9_147;
float3 l9_152=float3(0.0);
if (l9_150==0)
{
l9_152=float3(l9_149,0.0);
}
else
{
if (l9_150==1)
{
l9_152=float3(l9_149.x,(l9_149.y*0.5)+(0.5-(float(l9_151)*0.5)),0.0);
}
else
{
l9_152=float3(l9_149,float(l9_151));
}
}
float3 l9_153=l9_152;
float3 l9_154=l9_153;
float2 l9_155=l9_154.xy;
float l9_156=l9_148;
float4 l9_157=renderTarget3.sample(renderTarget3SmpSC,l9_155,level(l9_156));
float4 l9_158=l9_157;
l9_144=l9_158;
float4 l9_159=l9_144;
l9_140=l9_159;
float4 l9_160=l9_140;
float4 l9_161=l9_160;
float4 l9_162=l9_161;
float4 renderTarget3Sample=l9_162;
Scalar12=renderTarget3Sample.x;
Scalar13=renderTarget3Sample.y;
Scalar14=renderTarget3Sample.z;
Scalar15=renderTarget3Sample.w;
float4 param_8=float4(Scalar0,Scalar1,Scalar2,Scalar3);
float param_9=-1000.0;
float param_10=1000.0;
float4 l9_163=param_8;
float l9_164=param_9;
float l9_165=param_10;
float l9_166=0.99998999;
float4 l9_167=l9_163;
#if (1)
{
l9_167=floor((l9_167*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_168=dot(l9_167,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_169=l9_168;
float l9_170=0.0;
float l9_171=l9_166;
float l9_172=l9_164;
float l9_173=l9_165;
float l9_174=l9_172+(((l9_169-l9_170)*(l9_173-l9_172))/(l9_171-l9_170));
float l9_175=l9_174;
float l9_176=l9_175;
gParticle.Position.x=l9_176;
float4 param_11=float4(Scalar4,Scalar5,Scalar6,Scalar7);
float param_12=-1000.0;
float param_13=1000.0;
float4 l9_177=param_11;
float l9_178=param_12;
float l9_179=param_13;
float l9_180=0.99998999;
float4 l9_181=l9_177;
#if (1)
{
l9_181=floor((l9_181*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_182=dot(l9_181,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_183=l9_182;
float l9_184=0.0;
float l9_185=l9_180;
float l9_186=l9_178;
float l9_187=l9_179;
float l9_188=l9_186+(((l9_183-l9_184)*(l9_187-l9_186))/(l9_185-l9_184));
float l9_189=l9_188;
float l9_190=l9_189;
gParticle.Position.y=l9_190;
float4 param_14=float4(Scalar8,Scalar9,Scalar10,Scalar11);
float param_15=-1000.0;
float param_16=1000.0;
float4 l9_191=param_14;
float l9_192=param_15;
float l9_193=param_16;
float l9_194=0.99998999;
float4 l9_195=l9_191;
#if (1)
{
l9_195=floor((l9_195*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_196=dot(l9_195,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_197=l9_196;
float l9_198=0.0;
float l9_199=l9_194;
float l9_200=l9_192;
float l9_201=l9_193;
float l9_202=l9_200+(((l9_197-l9_198)*(l9_201-l9_200))/(l9_199-l9_198));
float l9_203=l9_202;
float l9_204=l9_203;
gParticle.Position.z=l9_204;
float4 param_17=float4(Scalar12,Scalar13,Scalar14,Scalar15);
float param_18=-1000.0;
float param_19=1000.0;
float4 l9_205=param_17;
float l9_206=param_18;
float l9_207=param_19;
float l9_208=0.99998999;
float4 l9_209=l9_205;
#if (1)
{
l9_209=floor((l9_209*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_210=dot(l9_209,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_211=l9_210;
float l9_212=0.0;
float l9_213=l9_208;
float l9_214=l9_206;
float l9_215=l9_207;
float l9_216=l9_214+(((l9_211-l9_212)*(l9_215-l9_214))/(l9_213-l9_212));
float l9_217=l9_216;
float l9_218=l9_217;
gParticle.Velocity.x=l9_218;
uv=Coord+(Offset*1.0);
float2 param_20=uv;
int l9_219=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_220=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_220=0;
}
else
{
l9_220=gl_InstanceIndex%2;
}
int l9_221=l9_220;
l9_219=1-l9_221;
}
else
{
int l9_222=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_222=0;
}
else
{
l9_222=gl_InstanceIndex%2;
}
int l9_223=l9_222;
l9_219=l9_223;
}
int l9_224=l9_219;
float2 l9_225=param_20;
int l9_226=l9_224;
float2 l9_227=l9_225;
int l9_228=l9_226;
float l9_229=0.0;
float4 l9_230=float4(0.0);
float2 l9_231=l9_227;
int l9_232=l9_228;
float l9_233=l9_229;
float4 l9_234=float4(0.0);
float2 l9_235=l9_231;
int l9_236=renderTarget0Layout_tmp;
int l9_237=l9_232;
float l9_238=l9_233;
float2 l9_239=l9_235;
int l9_240=l9_236;
int l9_241=l9_237;
float3 l9_242=float3(0.0);
if (l9_240==0)
{
l9_242=float3(l9_239,0.0);
}
else
{
if (l9_240==1)
{
l9_242=float3(l9_239.x,(l9_239.y*0.5)+(0.5-(float(l9_241)*0.5)),0.0);
}
else
{
l9_242=float3(l9_239,float(l9_241));
}
}
float3 l9_243=l9_242;
float3 l9_244=l9_243;
float2 l9_245=l9_244.xy;
float l9_246=l9_238;
float4 l9_247=renderTarget0.sample(renderTarget0SmpSC,l9_245,level(l9_246));
float4 l9_248=l9_247;
l9_234=l9_248;
float4 l9_249=l9_234;
l9_230=l9_249;
float4 l9_250=l9_230;
float4 l9_251=l9_250;
float4 l9_252=l9_251;
float4 renderTarget0Sample_1=l9_252;
Scalar0=renderTarget0Sample_1.x;
Scalar1=renderTarget0Sample_1.y;
Scalar2=renderTarget0Sample_1.z;
Scalar3=renderTarget0Sample_1.w;
float2 param_21=uv;
int l9_253=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_254=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_254=0;
}
else
{
l9_254=gl_InstanceIndex%2;
}
int l9_255=l9_254;
l9_253=1-l9_255;
}
else
{
int l9_256=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_256=0;
}
else
{
l9_256=gl_InstanceIndex%2;
}
int l9_257=l9_256;
l9_253=l9_257;
}
int l9_258=l9_253;
float2 l9_259=param_21;
int l9_260=l9_258;
float2 l9_261=l9_259;
int l9_262=l9_260;
float l9_263=0.0;
float4 l9_264=float4(0.0);
float2 l9_265=l9_261;
int l9_266=l9_262;
float l9_267=l9_263;
float4 l9_268=float4(0.0);
float2 l9_269=l9_265;
int l9_270=renderTarget1Layout_tmp;
int l9_271=l9_266;
float l9_272=l9_267;
float2 l9_273=l9_269;
int l9_274=l9_270;
int l9_275=l9_271;
float3 l9_276=float3(0.0);
if (l9_274==0)
{
l9_276=float3(l9_273,0.0);
}
else
{
if (l9_274==1)
{
l9_276=float3(l9_273.x,(l9_273.y*0.5)+(0.5-(float(l9_275)*0.5)),0.0);
}
else
{
l9_276=float3(l9_273,float(l9_275));
}
}
float3 l9_277=l9_276;
float3 l9_278=l9_277;
float2 l9_279=l9_278.xy;
float l9_280=l9_272;
float4 l9_281=renderTarget1.sample(renderTarget1SmpSC,l9_279,level(l9_280));
float4 l9_282=l9_281;
l9_268=l9_282;
float4 l9_283=l9_268;
l9_264=l9_283;
float4 l9_284=l9_264;
float4 l9_285=l9_284;
float4 l9_286=l9_285;
float4 renderTarget1Sample_1=l9_286;
Scalar4=renderTarget1Sample_1.x;
Scalar5=renderTarget1Sample_1.y;
Scalar6=renderTarget1Sample_1.z;
Scalar7=renderTarget1Sample_1.w;
float2 param_22=uv;
int l9_287=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_288=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_288=0;
}
else
{
l9_288=gl_InstanceIndex%2;
}
int l9_289=l9_288;
l9_287=1-l9_289;
}
else
{
int l9_290=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_290=0;
}
else
{
l9_290=gl_InstanceIndex%2;
}
int l9_291=l9_290;
l9_287=l9_291;
}
int l9_292=l9_287;
float2 l9_293=param_22;
int l9_294=l9_292;
float2 l9_295=l9_293;
int l9_296=l9_294;
float l9_297=0.0;
float4 l9_298=float4(0.0);
float2 l9_299=l9_295;
int l9_300=l9_296;
float l9_301=l9_297;
float4 l9_302=float4(0.0);
float2 l9_303=l9_299;
int l9_304=renderTarget2Layout_tmp;
int l9_305=l9_300;
float l9_306=l9_301;
float2 l9_307=l9_303;
int l9_308=l9_304;
int l9_309=l9_305;
float3 l9_310=float3(0.0);
if (l9_308==0)
{
l9_310=float3(l9_307,0.0);
}
else
{
if (l9_308==1)
{
l9_310=float3(l9_307.x,(l9_307.y*0.5)+(0.5-(float(l9_309)*0.5)),0.0);
}
else
{
l9_310=float3(l9_307,float(l9_309));
}
}
float3 l9_311=l9_310;
float3 l9_312=l9_311;
float2 l9_313=l9_312.xy;
float l9_314=l9_306;
float4 l9_315=renderTarget2.sample(renderTarget2SmpSC,l9_313,level(l9_314));
float4 l9_316=l9_315;
l9_302=l9_316;
float4 l9_317=l9_302;
l9_298=l9_317;
float4 l9_318=l9_298;
float4 l9_319=l9_318;
float4 l9_320=l9_319;
float4 renderTarget2Sample_1=l9_320;
Scalar8=renderTarget2Sample_1.x;
Scalar9=renderTarget2Sample_1.y;
Scalar10=renderTarget2Sample_1.z;
Scalar11=renderTarget2Sample_1.w;
float2 param_23=uv;
int l9_321=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_322=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_322=0;
}
else
{
l9_322=gl_InstanceIndex%2;
}
int l9_323=l9_322;
l9_321=1-l9_323;
}
else
{
int l9_324=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_324=0;
}
else
{
l9_324=gl_InstanceIndex%2;
}
int l9_325=l9_324;
l9_321=l9_325;
}
int l9_326=l9_321;
float2 l9_327=param_23;
int l9_328=l9_326;
float2 l9_329=l9_327;
int l9_330=l9_328;
float l9_331=0.0;
float4 l9_332=float4(0.0);
float2 l9_333=l9_329;
int l9_334=l9_330;
float l9_335=l9_331;
float4 l9_336=float4(0.0);
float2 l9_337=l9_333;
int l9_338=renderTarget3Layout_tmp;
int l9_339=l9_334;
float l9_340=l9_335;
float2 l9_341=l9_337;
int l9_342=l9_338;
int l9_343=l9_339;
float3 l9_344=float3(0.0);
if (l9_342==0)
{
l9_344=float3(l9_341,0.0);
}
else
{
if (l9_342==1)
{
l9_344=float3(l9_341.x,(l9_341.y*0.5)+(0.5-(float(l9_343)*0.5)),0.0);
}
else
{
l9_344=float3(l9_341,float(l9_343));
}
}
float3 l9_345=l9_344;
float3 l9_346=l9_345;
float2 l9_347=l9_346.xy;
float l9_348=l9_340;
float4 l9_349=renderTarget3.sample(renderTarget3SmpSC,l9_347,level(l9_348));
float4 l9_350=l9_349;
l9_336=l9_350;
float4 l9_351=l9_336;
l9_332=l9_351;
float4 l9_352=l9_332;
float4 l9_353=l9_352;
float4 l9_354=l9_353;
float4 renderTarget3Sample_1=l9_354;
Scalar12=renderTarget3Sample_1.x;
Scalar13=renderTarget3Sample_1.y;
Scalar14=renderTarget3Sample_1.z;
Scalar15=renderTarget3Sample_1.w;
float4 param_24=float4(Scalar0,Scalar1,Scalar2,Scalar3);
float param_25=-1000.0;
float param_26=1000.0;
float4 l9_355=param_24;
float l9_356=param_25;
float l9_357=param_26;
float l9_358=0.99998999;
float4 l9_359=l9_355;
#if (1)
{
l9_359=floor((l9_359*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_360=dot(l9_359,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_361=l9_360;
float l9_362=0.0;
float l9_363=l9_358;
float l9_364=l9_356;
float l9_365=l9_357;
float l9_366=l9_364+(((l9_361-l9_362)*(l9_365-l9_364))/(l9_363-l9_362));
float l9_367=l9_366;
float l9_368=l9_367;
gParticle.Velocity.y=l9_368;
float4 param_27=float4(Scalar4,Scalar5,Scalar6,Scalar7);
float param_28=-1000.0;
float param_29=1000.0;
float4 l9_369=param_27;
float l9_370=param_28;
float l9_371=param_29;
float l9_372=0.99998999;
float4 l9_373=l9_369;
#if (1)
{
l9_373=floor((l9_373*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_374=dot(l9_373,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_375=l9_374;
float l9_376=0.0;
float l9_377=l9_372;
float l9_378=l9_370;
float l9_379=l9_371;
float l9_380=l9_378+(((l9_375-l9_376)*(l9_379-l9_378))/(l9_377-l9_376));
float l9_381=l9_380;
float l9_382=l9_381;
gParticle.Velocity.z=l9_382;
float4 param_30=float4(Scalar8,Scalar9,Scalar10,Scalar11);
float param_31=0.0;
float param_32=0.2;
float4 l9_383=param_30;
float l9_384=param_31;
float l9_385=param_32;
float l9_386=0.99998999;
float4 l9_387=l9_383;
#if (1)
{
l9_387=floor((l9_387*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_388=dot(l9_387,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_389=l9_388;
float l9_390=0.0;
float l9_391=l9_386;
float l9_392=l9_384;
float l9_393=l9_385;
float l9_394=l9_392+(((l9_389-l9_390)*(l9_393-l9_392))/(l9_391-l9_390));
float l9_395=l9_394;
float l9_396=l9_395;
gParticle.Life=l9_396;
float4 param_33=float4(Scalar12,Scalar13,Scalar14,Scalar15);
float param_34=0.0;
float param_35=0.2;
float4 l9_397=param_33;
float l9_398=param_34;
float l9_399=param_35;
float l9_400=0.99998999;
float4 l9_401=l9_397;
#if (1)
{
l9_401=floor((l9_401*255.0)+float4(0.5))/float4(255.0);
}
#endif
float l9_402=dot(l9_401,float4(1.0,0.0039215689,1.53787e-05,6.0308629e-08));
float l9_403=l9_402;
float l9_404=0.0;
float l9_405=l9_400;
float l9_406=l9_398;
float l9_407=l9_399;
float l9_408=l9_406+(((l9_403-l9_404)*(l9_407-l9_406))/(l9_405-l9_404));
float l9_409=l9_408;
float l9_410=l9_409;
gParticle.Age=l9_410;
uv=Coord+(Offset*2.0);
float2 param_36=uv;
int l9_411=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_412=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_412=0;
}
else
{
l9_412=gl_InstanceIndex%2;
}
int l9_413=l9_412;
l9_411=1-l9_413;
}
else
{
int l9_414=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_414=0;
}
else
{
l9_414=gl_InstanceIndex%2;
}
int l9_415=l9_414;
l9_411=l9_415;
}
int l9_416=l9_411;
float2 l9_417=param_36;
int l9_418=l9_416;
float2 l9_419=l9_417;
int l9_420=l9_418;
float l9_421=0.0;
float4 l9_422=float4(0.0);
float2 l9_423=l9_419;
int l9_424=l9_420;
float l9_425=l9_421;
float4 l9_426=float4(0.0);
float2 l9_427=l9_423;
int l9_428=renderTarget0Layout_tmp;
int l9_429=l9_424;
float l9_430=l9_425;
float2 l9_431=l9_427;
int l9_432=l9_428;
int l9_433=l9_429;
float3 l9_434=float3(0.0);
if (l9_432==0)
{
l9_434=float3(l9_431,0.0);
}
else
{
if (l9_432==1)
{
l9_434=float3(l9_431.x,(l9_431.y*0.5)+(0.5-(float(l9_433)*0.5)),0.0);
}
else
{
l9_434=float3(l9_431,float(l9_433));
}
}
float3 l9_435=l9_434;
float3 l9_436=l9_435;
float2 l9_437=l9_436.xy;
float l9_438=l9_430;
float4 l9_439=renderTarget0.sample(renderTarget0SmpSC,l9_437,level(l9_438));
float4 l9_440=l9_439;
l9_426=l9_440;
float4 l9_441=l9_426;
l9_422=l9_441;
float4 l9_442=l9_422;
float4 l9_443=l9_442;
float4 l9_444=l9_443;
float4 renderTarget0Sample_2=l9_444;
Scalar0=renderTarget0Sample_2.x;
Scalar1=renderTarget0Sample_2.y;
Scalar2=renderTarget0Sample_2.z;
Scalar3=renderTarget0Sample_2.w;
float2 param_37=uv;
int l9_445=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_446=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_446=0;
}
else
{
l9_446=gl_InstanceIndex%2;
}
int l9_447=l9_446;
l9_445=1-l9_447;
}
else
{
int l9_448=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_448=0;
}
else
{
l9_448=gl_InstanceIndex%2;
}
int l9_449=l9_448;
l9_445=l9_449;
}
int l9_450=l9_445;
float2 l9_451=param_37;
int l9_452=l9_450;
float2 l9_453=l9_451;
int l9_454=l9_452;
float l9_455=0.0;
float4 l9_456=float4(0.0);
float2 l9_457=l9_453;
int l9_458=l9_454;
float l9_459=l9_455;
float4 l9_460=float4(0.0);
float2 l9_461=l9_457;
int l9_462=renderTarget1Layout_tmp;
int l9_463=l9_458;
float l9_464=l9_459;
float2 l9_465=l9_461;
int l9_466=l9_462;
int l9_467=l9_463;
float3 l9_468=float3(0.0);
if (l9_466==0)
{
l9_468=float3(l9_465,0.0);
}
else
{
if (l9_466==1)
{
l9_468=float3(l9_465.x,(l9_465.y*0.5)+(0.5-(float(l9_467)*0.5)),0.0);
}
else
{
l9_468=float3(l9_465,float(l9_467));
}
}
float3 l9_469=l9_468;
float3 l9_470=l9_469;
float2 l9_471=l9_470.xy;
float l9_472=l9_464;
float4 l9_473=renderTarget1.sample(renderTarget1SmpSC,l9_471,level(l9_472));
float4 l9_474=l9_473;
l9_460=l9_474;
float4 l9_475=l9_460;
l9_456=l9_475;
float4 l9_476=l9_456;
float4 l9_477=l9_476;
float4 l9_478=l9_477;
float4 renderTarget1Sample_2=l9_478;
Scalar4=renderTarget1Sample_2.x;
Scalar5=renderTarget1Sample_2.y;
Scalar6=renderTarget1Sample_2.z;
Scalar7=renderTarget1Sample_2.w;
float2 param_38=uv;
int l9_479=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_480=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_480=0;
}
else
{
l9_480=gl_InstanceIndex%2;
}
int l9_481=l9_480;
l9_479=1-l9_481;
}
else
{
int l9_482=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_482=0;
}
else
{
l9_482=gl_InstanceIndex%2;
}
int l9_483=l9_482;
l9_479=l9_483;
}
int l9_484=l9_479;
float2 l9_485=param_38;
int l9_486=l9_484;
float2 l9_487=l9_485;
int l9_488=l9_486;
float l9_489=0.0;
float4 l9_490=float4(0.0);
float2 l9_491=l9_487;
int l9_492=l9_488;
float l9_493=l9_489;
float4 l9_494=float4(0.0);
float2 l9_495=l9_491;
int l9_496=renderTarget2Layout_tmp;
int l9_497=l9_492;
float l9_498=l9_493;
float2 l9_499=l9_495;
int l9_500=l9_496;
int l9_501=l9_497;
float3 l9_502=float3(0.0);
if (l9_500==0)
{
l9_502=float3(l9_499,0.0);
}
else
{
if (l9_500==1)
{
l9_502=float3(l9_499.x,(l9_499.y*0.5)+(0.5-(float(l9_501)*0.5)),0.0);
}
else
{
l9_502=float3(l9_499,float(l9_501));
}
}
float3 l9_503=l9_502;
float3 l9_504=l9_503;
float2 l9_505=l9_504.xy;
float l9_506=l9_498;
float4 l9_507=renderTarget2.sample(renderTarget2SmpSC,l9_505,level(l9_506));
float4 l9_508=l9_507;
l9_494=l9_508;
float4 l9_509=l9_494;
l9_490=l9_509;
float4 l9_510=l9_490;
float4 l9_511=l9_510;
float4 l9_512=l9_511;
float4 renderTarget2Sample_2=l9_512;
Scalar8=renderTarget2Sample_2.x;
Scalar9=renderTarget2Sample_2.y;
Scalar10=renderTarget2Sample_2.z;
Scalar11=renderTarget2Sample_2.w;
float2 param_39=uv;
int l9_513=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_514=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_514=0;
}
else
{
l9_514=gl_InstanceIndex%2;
}
int l9_515=l9_514;
l9_513=1-l9_515;
}
else
{
int l9_516=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_516=0;
}
else
{
l9_516=gl_InstanceIndex%2;
}
int l9_517=l9_516;
l9_513=l9_517;
}
int l9_518=l9_513;
float2 l9_519=param_39;
int l9_520=l9_518;
float2 l9_521=l9_519;
int l9_522=l9_520;
float l9_523=0.0;
float4 l9_524=float4(0.0);
float2 l9_525=l9_521;
int l9_526=l9_522;
float l9_527=l9_523;
float4 l9_528=float4(0.0);
float2 l9_529=l9_525;
int l9_530=renderTarget3Layout_tmp;
int l9_531=l9_526;
float l9_532=l9_527;
float2 l9_533=l9_529;
int l9_534=l9_530;
int l9_535=l9_531;
float3 l9_536=float3(0.0);
if (l9_534==0)
{
l9_536=float3(l9_533,0.0);
}
else
{
if (l9_534==1)
{
l9_536=float3(l9_533.x,(l9_533.y*0.5)+(0.5-(float(l9_535)*0.5)),0.0);
}
else
{
l9_536=float3(l9_533,float(l9_535));
}
}
float3 l9_537=l9_536;
float3 l9_538=l9_537;
float2 l9_539=l9_538.xy;
float l9_540=l9_532;
float4 l9_541=renderTarget3.sample(renderTarget3SmpSC,l9_539,level(l9_540));
float4 l9_542=l9_541;
l9_528=l9_542;
float4 l9_543=l9_528;
l9_524=l9_543;
float4 l9_544=l9_524;
float4 l9_545=l9_544;
float4 l9_546=l9_545;
float4 renderTarget3Sample_2=l9_546;
Scalar12=renderTarget3Sample_2.x;
Scalar13=renderTarget3Sample_2.y;
Scalar14=renderTarget3Sample_2.z;
Scalar15=renderTarget3Sample_2.w;
float2 param_40=float2(Scalar0,Scalar1);
float param_41=0.0;
float param_42=100.0;
float2 l9_547=param_40;
float l9_548=param_41;
float l9_549=param_42;
float l9_550=0.99998999;
float2 l9_551=l9_547;
#if (1)
{
l9_551=floor((l9_551*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_552=dot(l9_551,float2(1.0,0.0039215689));
float l9_553=l9_552;
float l9_554=0.0;
float l9_555=l9_550;
float l9_556=l9_548;
float l9_557=l9_549;
float l9_558=l9_556+(((l9_553-l9_554)*(l9_557-l9_556))/(l9_555-l9_554));
float l9_559=l9_558;
float l9_560=l9_559;
gParticle.Size=l9_560;
float2 param_43=float2(Scalar2,Scalar3);
float param_44=-1.0;
float param_45=1.0;
float2 l9_561=param_43;
float l9_562=param_44;
float l9_563=param_45;
float l9_564=0.99998999;
float2 l9_565=l9_561;
#if (1)
{
l9_565=floor((l9_565*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_566=dot(l9_565,float2(1.0,0.0039215689));
float l9_567=l9_566;
float l9_568=0.0;
float l9_569=l9_564;
float l9_570=l9_562;
float l9_571=l9_563;
float l9_572=l9_570+(((l9_567-l9_568)*(l9_571-l9_570))/(l9_569-l9_568));
float l9_573=l9_572;
float l9_574=l9_573;
gParticle.Quaternion.x=l9_574;
float2 param_46=float2(Scalar4,Scalar5);
float param_47=-1.0;
float param_48=1.0;
float2 l9_575=param_46;
float l9_576=param_47;
float l9_577=param_48;
float l9_578=0.99998999;
float2 l9_579=l9_575;
#if (1)
{
l9_579=floor((l9_579*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_580=dot(l9_579,float2(1.0,0.0039215689));
float l9_581=l9_580;
float l9_582=0.0;
float l9_583=l9_578;
float l9_584=l9_576;
float l9_585=l9_577;
float l9_586=l9_584+(((l9_581-l9_582)*(l9_585-l9_584))/(l9_583-l9_582));
float l9_587=l9_586;
float l9_588=l9_587;
gParticle.Quaternion.y=l9_588;
float2 param_49=float2(Scalar6,Scalar7);
float param_50=-1.0;
float param_51=1.0;
float2 l9_589=param_49;
float l9_590=param_50;
float l9_591=param_51;
float l9_592=0.99998999;
float2 l9_593=l9_589;
#if (1)
{
l9_593=floor((l9_593*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_594=dot(l9_593,float2(1.0,0.0039215689));
float l9_595=l9_594;
float l9_596=0.0;
float l9_597=l9_592;
float l9_598=l9_590;
float l9_599=l9_591;
float l9_600=l9_598+(((l9_595-l9_596)*(l9_599-l9_598))/(l9_597-l9_596));
float l9_601=l9_600;
float l9_602=l9_601;
gParticle.Quaternion.z=l9_602;
float2 param_52=float2(Scalar8,Scalar9);
float param_53=-1.0;
float param_54=1.0;
float2 l9_603=param_52;
float l9_604=param_53;
float l9_605=param_54;
float l9_606=0.99998999;
float2 l9_607=l9_603;
#if (1)
{
l9_607=floor((l9_607*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_608=dot(l9_607,float2(1.0,0.0039215689));
float l9_609=l9_608;
float l9_610=0.0;
float l9_611=l9_606;
float l9_612=l9_604;
float l9_613=l9_605;
float l9_614=l9_612+(((l9_609-l9_610)*(l9_613-l9_612))/(l9_611-l9_610));
float l9_615=l9_614;
float l9_616=l9_615;
gParticle.Quaternion.w=l9_616;
float2 param_55=float2(Scalar10,Scalar11);
float param_56=0.0;
float param_57=100.0;
float2 l9_617=param_55;
float l9_618=param_56;
float l9_619=param_57;
float l9_620=0.99998999;
float2 l9_621=l9_617;
#if (1)
{
l9_621=floor((l9_621*255.0)+float2(0.5))/float2(255.0);
}
#endif
float l9_622=dot(l9_621,float2(1.0,0.0039215689));
float l9_623=l9_622;
float l9_624=0.0;
float l9_625=l9_620;
float l9_626=l9_618;
float l9_627=l9_619;
float l9_628=l9_626+(((l9_623-l9_624)*(l9_627-l9_626))/(l9_625-l9_624));
float l9_629=l9_628;
float l9_630=l9_629;
gParticle.Mass=l9_630;
float param_58=Scalar12;
float param_59=0.0;
float param_60=1.00001;
float l9_631=param_58;
float l9_632=param_59;
float l9_633=param_60;
float l9_634=1.0;
float l9_635=l9_631;
#if (1)
{
l9_635=floor((l9_635*255.0)+0.5)/255.0;
}
#endif
float l9_636=l9_635;
float l9_637=l9_636;
float l9_638=0.0;
float l9_639=l9_634;
float l9_640=l9_632;
float l9_641=l9_633;
float l9_642=l9_640+(((l9_637-l9_638)*(l9_641-l9_640))/(l9_639-l9_638));
float l9_643=l9_642;
float l9_644=l9_643;
gParticle.Color.x=l9_644;
float param_61=Scalar13;
float param_62=0.0;
float param_63=1.00001;
float l9_645=param_61;
float l9_646=param_62;
float l9_647=param_63;
float l9_648=1.0;
float l9_649=l9_645;
#if (1)
{
l9_649=floor((l9_649*255.0)+0.5)/255.0;
}
#endif
float l9_650=l9_649;
float l9_651=l9_650;
float l9_652=0.0;
float l9_653=l9_648;
float l9_654=l9_646;
float l9_655=l9_647;
float l9_656=l9_654+(((l9_651-l9_652)*(l9_655-l9_654))/(l9_653-l9_652));
float l9_657=l9_656;
float l9_658=l9_657;
gParticle.Color.y=l9_658;
float param_64=Scalar14;
float param_65=0.0;
float param_66=1.00001;
float l9_659=param_64;
float l9_660=param_65;
float l9_661=param_66;
float l9_662=1.0;
float l9_663=l9_659;
#if (1)
{
l9_663=floor((l9_663*255.0)+0.5)/255.0;
}
#endif
float l9_664=l9_663;
float l9_665=l9_664;
float l9_666=0.0;
float l9_667=l9_662;
float l9_668=l9_660;
float l9_669=l9_661;
float l9_670=l9_668+(((l9_665-l9_666)*(l9_669-l9_668))/(l9_667-l9_666));
float l9_671=l9_670;
float l9_672=l9_671;
gParticle.Color.z=l9_672;
float param_67=Scalar15;
float param_68=0.0;
float param_69=1.00001;
float l9_673=param_67;
float l9_674=param_68;
float l9_675=param_69;
float l9_676=1.0;
float l9_677=l9_673;
#if (1)
{
l9_677=floor((l9_677*255.0)+0.5)/255.0;
}
#endif
float l9_678=l9_677;
float l9_679=l9_678;
float l9_680=0.0;
float l9_681=l9_676;
float l9_682=l9_674;
float l9_683=l9_675;
float l9_684=l9_682+(((l9_679-l9_680)*(l9_683-l9_682))/(l9_681-l9_680));
float l9_685=l9_684;
float l9_686=l9_685;
gParticle.Color.w=l9_686;
uv=Coord+(Offset*3.0);
float2 param_70=uv;
int l9_687=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_688=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_688=0;
}
else
{
l9_688=gl_InstanceIndex%2;
}
int l9_689=l9_688;
l9_687=1-l9_689;
}
else
{
int l9_690=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_690=0;
}
else
{
l9_690=gl_InstanceIndex%2;
}
int l9_691=l9_690;
l9_687=l9_691;
}
int l9_692=l9_687;
float2 l9_693=param_70;
int l9_694=l9_692;
float2 l9_695=l9_693;
int l9_696=l9_694;
float l9_697=0.0;
float4 l9_698=float4(0.0);
float2 l9_699=l9_695;
int l9_700=l9_696;
float l9_701=l9_697;
float4 l9_702=float4(0.0);
float2 l9_703=l9_699;
int l9_704=renderTarget0Layout_tmp;
int l9_705=l9_700;
float l9_706=l9_701;
float2 l9_707=l9_703;
int l9_708=l9_704;
int l9_709=l9_705;
float3 l9_710=float3(0.0);
if (l9_708==0)
{
l9_710=float3(l9_707,0.0);
}
else
{
if (l9_708==1)
{
l9_710=float3(l9_707.x,(l9_707.y*0.5)+(0.5-(float(l9_709)*0.5)),0.0);
}
else
{
l9_710=float3(l9_707,float(l9_709));
}
}
float3 l9_711=l9_710;
float3 l9_712=l9_711;
float2 l9_713=l9_712.xy;
float l9_714=l9_706;
float4 l9_715=renderTarget0.sample(renderTarget0SmpSC,l9_713,level(l9_714));
float4 l9_716=l9_715;
l9_702=l9_716;
float4 l9_717=l9_702;
l9_698=l9_717;
float4 l9_718=l9_698;
float4 l9_719=l9_718;
float4 l9_720=l9_719;
float4 renderTarget0Sample_3=l9_720;
Scalar0=renderTarget0Sample_3.x;
Scalar1=renderTarget0Sample_3.y;
Scalar2=renderTarget0Sample_3.z;
Scalar3=renderTarget0Sample_3.w;
float2 param_71=uv;
int l9_721=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_722=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_722=0;
}
else
{
l9_722=gl_InstanceIndex%2;
}
int l9_723=l9_722;
l9_721=1-l9_723;
}
else
{
int l9_724=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_724=0;
}
else
{
l9_724=gl_InstanceIndex%2;
}
int l9_725=l9_724;
l9_721=l9_725;
}
int l9_726=l9_721;
float2 l9_727=param_71;
int l9_728=l9_726;
float2 l9_729=l9_727;
int l9_730=l9_728;
float l9_731=0.0;
float4 l9_732=float4(0.0);
float2 l9_733=l9_729;
int l9_734=l9_730;
float l9_735=l9_731;
float4 l9_736=float4(0.0);
float2 l9_737=l9_733;
int l9_738=renderTarget1Layout_tmp;
int l9_739=l9_734;
float l9_740=l9_735;
float2 l9_741=l9_737;
int l9_742=l9_738;
int l9_743=l9_739;
float3 l9_744=float3(0.0);
if (l9_742==0)
{
l9_744=float3(l9_741,0.0);
}
else
{
if (l9_742==1)
{
l9_744=float3(l9_741.x,(l9_741.y*0.5)+(0.5-(float(l9_743)*0.5)),0.0);
}
else
{
l9_744=float3(l9_741,float(l9_743));
}
}
float3 l9_745=l9_744;
float3 l9_746=l9_745;
float2 l9_747=l9_746.xy;
float l9_748=l9_740;
float4 l9_749=renderTarget1.sample(renderTarget1SmpSC,l9_747,level(l9_748));
float4 l9_750=l9_749;
l9_736=l9_750;
float4 l9_751=l9_736;
l9_732=l9_751;
float4 l9_752=l9_732;
float4 l9_753=l9_752;
float4 l9_754=l9_753;
float4 renderTarget1Sample_3=l9_754;
Scalar4=renderTarget1Sample_3.x;
Scalar5=renderTarget1Sample_3.y;
Scalar6=renderTarget1Sample_3.z;
Scalar7=renderTarget1Sample_3.w;
float2 param_72=uv;
int l9_755=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_756=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_756=0;
}
else
{
l9_756=gl_InstanceIndex%2;
}
int l9_757=l9_756;
l9_755=1-l9_757;
}
else
{
int l9_758=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_758=0;
}
else
{
l9_758=gl_InstanceIndex%2;
}
int l9_759=l9_758;
l9_755=l9_759;
}
int l9_760=l9_755;
float2 l9_761=param_72;
int l9_762=l9_760;
float2 l9_763=l9_761;
int l9_764=l9_762;
float l9_765=0.0;
float4 l9_766=float4(0.0);
float2 l9_767=l9_763;
int l9_768=l9_764;
float l9_769=l9_765;
float4 l9_770=float4(0.0);
float2 l9_771=l9_767;
int l9_772=renderTarget2Layout_tmp;
int l9_773=l9_768;
float l9_774=l9_769;
float2 l9_775=l9_771;
int l9_776=l9_772;
int l9_777=l9_773;
float3 l9_778=float3(0.0);
if (l9_776==0)
{
l9_778=float3(l9_775,0.0);
}
else
{
if (l9_776==1)
{
l9_778=float3(l9_775.x,(l9_775.y*0.5)+(0.5-(float(l9_777)*0.5)),0.0);
}
else
{
l9_778=float3(l9_775,float(l9_777));
}
}
float3 l9_779=l9_778;
float3 l9_780=l9_779;
float2 l9_781=l9_780.xy;
float l9_782=l9_774;
float4 l9_783=renderTarget2.sample(renderTarget2SmpSC,l9_781,level(l9_782));
float4 l9_784=l9_783;
l9_770=l9_784;
float4 l9_785=l9_770;
l9_766=l9_785;
float4 l9_786=l9_766;
float4 l9_787=l9_786;
float4 l9_788=l9_787;
float4 renderTarget2Sample_3=l9_788;
Scalar8=renderTarget2Sample_3.x;
Scalar9=renderTarget2Sample_3.y;
Scalar10=renderTarget2Sample_3.z;
Scalar11=renderTarget2Sample_3.w;
float2 param_73=uv;
int l9_789=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_790=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_790=0;
}
else
{
l9_790=gl_InstanceIndex%2;
}
int l9_791=l9_790;
l9_789=1-l9_791;
}
else
{
int l9_792=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_792=0;
}
else
{
l9_792=gl_InstanceIndex%2;
}
int l9_793=l9_792;
l9_789=l9_793;
}
int l9_794=l9_789;
float2 l9_795=param_73;
int l9_796=l9_794;
float2 l9_797=l9_795;
int l9_798=l9_796;
float l9_799=0.0;
float4 l9_800=float4(0.0);
float2 l9_801=l9_797;
int l9_802=l9_798;
float l9_803=l9_799;
float4 l9_804=float4(0.0);
float2 l9_805=l9_801;
int l9_806=renderTarget3Layout_tmp;
int l9_807=l9_802;
float l9_808=l9_803;
float2 l9_809=l9_805;
int l9_810=l9_806;
int l9_811=l9_807;
float3 l9_812=float3(0.0);
if (l9_810==0)
{
l9_812=float3(l9_809,0.0);
}
else
{
if (l9_810==1)
{
l9_812=float3(l9_809.x,(l9_809.y*0.5)+(0.5-(float(l9_811)*0.5)),0.0);
}
else
{
l9_812=float3(l9_809,float(l9_811));
}
}
float3 l9_813=l9_812;
float3 l9_814=l9_813;
float2 l9_815=l9_814.xy;
float l9_816=l9_808;
float4 l9_817=renderTarget3.sample(renderTarget3SmpSC,l9_815,level(l9_816));
float4 l9_818=l9_817;
l9_804=l9_818;
float4 l9_819=l9_804;
l9_800=l9_819;
float4 l9_820=l9_800;
float4 l9_821=l9_820;
float4 l9_822=l9_821;
float4 renderTarget3Sample_3=l9_822;
Scalar12=renderTarget3Sample_3.x;
Scalar13=renderTarget3Sample_3.y;
Scalar14=renderTarget3Sample_3.z;
Scalar15=renderTarget3Sample_3.w;
float param_74=Scalar0;
float param_75=0.0;
float param_76=255.0;
float l9_823=param_74;
float l9_824=param_75;
float l9_825=param_76;
float l9_826=1.0;
float l9_827=l9_823;
#if (1)
{
l9_827=floor((l9_827*255.0)+0.5)/255.0;
}
#endif
float l9_828=l9_827;
float l9_829=l9_828;
float l9_830=0.0;
float l9_831=l9_826;
float l9_832=l9_824;
float l9_833=l9_825;
float l9_834=l9_832+(((l9_829-l9_830)*(l9_833-l9_832))/(l9_831-l9_830));
float l9_835=l9_834;
float l9_836=l9_835;
gParticle.collisionCount_N119=l9_836;
float4 param_77=gParticle.Quaternion;
param_77=normalize(param_77.yzwx);
float l9_837=param_77.x*param_77.x;
float l9_838=param_77.y*param_77.y;
float l9_839=param_77.z*param_77.z;
float l9_840=param_77.x*param_77.z;
float l9_841=param_77.x*param_77.y;
float l9_842=param_77.y*param_77.z;
float l9_843=param_77.w*param_77.x;
float l9_844=param_77.w*param_77.y;
float l9_845=param_77.w*param_77.z;
float3x3 l9_846=float3x3(float3(1.0-(2.0*(l9_838+l9_839)),2.0*(l9_841+l9_845),2.0*(l9_840-l9_844)),float3(2.0*(l9_841-l9_845),1.0-(2.0*(l9_837+l9_839)),2.0*(l9_842+l9_843)),float3(2.0*(l9_840+l9_844),2.0*(l9_842-l9_843),1.0-(2.0*(l9_837+l9_838))));
gParticle.Matrix=l9_846;
gParticle.Velocity=floor((gParticle.Velocity*2000.0)+float3(0.5))*0.00050000002;
gParticle.Position=floor((gParticle.Position*2000.0)+float3(0.5))*0.00050000002;
gParticle.Color=floor((gParticle.Color*2000.0)+float4(0.5))*0.00050000002;
gParticle.Size=floor((gParticle.Size*2000.0)+0.5)*0.00050000002;
gParticle.Mass=floor((gParticle.Mass*2000.0)+0.5)*0.00050000002;
gParticle.Life=floor((gParticle.Life*2000.0)+0.5)*0.00050000002;
return true;
}
float snoise(thread const float2& v)
{
if (SC_DEVICE_CLASS_tmp>=2)
{
float2 i=floor(v+float2(dot(v,float2(0.36602542))));
float2 x0=(v-i)+float2(dot(i,float2(0.21132487)));
float2 i1=float2(0.0);
bool2 l9_0=bool2(x0.x>x0.y);
i1=float2(l9_0.x ? float2(1.0,0.0).x : float2(0.0,1.0).x,l9_0.y ? float2(1.0,0.0).y : float2(0.0,1.0).y);
float2 x1=(x0+float2(0.21132487))-i1;
float2 x2=x0+float2(-0.57735026);
float2 param=i;
float2 l9_1=param-(floor(param*0.0034602077)*289.0);
i=l9_1;
float3 param_1=float3(i.y)+float3(0.0,i1.y,1.0);
float3 l9_2=((param_1*34.0)+float3(1.0))*param_1;
float3 l9_3=l9_2-(floor(l9_2*0.0034602077)*289.0);
float3 l9_4=l9_3;
float3 param_2=(l9_4+float3(i.x))+float3(0.0,i1.x,1.0);
float3 l9_5=((param_2*34.0)+float3(1.0))*param_2;
float3 l9_6=l9_5-(floor(l9_5*0.0034602077)*289.0);
float3 l9_7=l9_6;
float3 p=l9_7;
float3 m=fast::max(float3(0.5)-float3(dot(x0,x0),dot(x1,x1),dot(x2,x2)),float3(0.0));
m*=m;
m*=m;
float3 x=(fract(p*float3(0.024390243))*2.0)-float3(1.0);
float3 h=abs(x)-float3(0.5);
float3 ox=floor(x+float3(0.5));
float3 a0=x-ox;
m*=(float3(1.7928429)-(((a0*a0)+(h*h))*0.85373473));
float3 g=float3(0.0);
g.x=(a0.x*x0.x)+(h.x*x0.y);
float2 l9_8=(a0.yz*float2(x1.x,x2.x))+(h.yz*float2(x1.y,x2.y));
g=float3(g.x,l9_8.x,l9_8.y);
return 130.0*dot(m,g);
}
else
{
return 0.0;
}
}
float4 matrixToQuaternion(thread const float3x3& m)
{
float fourXSquaredMinus1=(m[0].x-m[1].y)-m[2].z;
float fourYSquaredMinus1=(m[1].y-m[0].x)-m[2].z;
float fourZSquaredMinus1=(m[2].z-m[0].x)-m[1].y;
float fourWSquaredMinus1=(m[0].x+m[1].y)+m[2].z;
int biggestIndex=0;
float fourBiggestSquaredMinus1=fourWSquaredMinus1;
if (fourXSquaredMinus1>fourBiggestSquaredMinus1)
{
fourBiggestSquaredMinus1=fourXSquaredMinus1;
biggestIndex=1;
}
if (fourYSquaredMinus1>fourBiggestSquaredMinus1)
{
fourBiggestSquaredMinus1=fourYSquaredMinus1;
biggestIndex=2;
}
if (fourZSquaredMinus1>fourBiggestSquaredMinus1)
{
fourBiggestSquaredMinus1=fourZSquaredMinus1;
biggestIndex=3;
}
float biggestVal=sqrt(fourBiggestSquaredMinus1+1.0)*0.5;
float mult=0.25/biggestVal;
if (biggestIndex==0)
{
return float4(biggestVal,(m[1].z-m[2].y)*mult,(m[2].x-m[0].z)*mult,(m[0].y-m[1].x)*mult);
}
else
{
if (biggestIndex==1)
{
return float4((m[1].z-m[2].y)*mult,biggestVal,(m[0].y+m[1].x)*mult,(m[2].x+m[0].z)*mult);
}
else
{
if (biggestIndex==2)
{
return float4((m[2].x-m[0].z)*mult,(m[0].y+m[1].x)*mult,biggestVal,(m[1].z+m[2].y)*mult);
}
else
{
if (biggestIndex==3)
{
return float4((m[0].y-m[1].x)*mult,(m[2].x+m[0].z)*mult,(m[1].z+m[2].y)*mult,biggestVal);
}
else
{
return float4(1.0,0.0,0.0,0.0);
}
}
}
}
}
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
int N118_OnCollision=0;
float3 N118_PlanePos=float3(0.0);
float3 N118_PlaneNormal=float3(0.0);
float N118_Bounciness=0.0;
float N118_Friction=0.0;
float N118_PlaneOffset=0.0;
float N118_CollisionCount=0.0;
float N118_VelocityThreshold=0.0;
float N118_SetCollisionCount=0.0;
float3 N118_SetForce=float3(0.0);
float3 N118_SetVelocity=float3(0.0);
float3 N118_SetPosition=float3(0.0);
float N118_KillParticle=0.0;
sc_Vertex_t l9_0;
l9_0.position=in.position;
l9_0.texture0=in.texture0;
l9_0.texture1=in.texture1;
sc_Vertex_t l9_1=l9_0;
sc_Vertex_t v=l9_1;
int l9_2=gl_InstanceIndex;
int InstanceID=l9_2;
int param=InstanceID;
ssParticle gParticle;
bool l9_3=ssDecodeParticle(param,gl_InstanceIndex,(*sc_set0.UserUniforms),sc_set0.renderTarget0,sc_set0.renderTarget0SmpSC,sc_set0.renderTarget1,sc_set0.renderTarget1SmpSC,sc_set0.renderTarget2,sc_set0.renderTarget2SmpSC,sc_set0.renderTarget3,sc_set0.renderTarget3SmpSC,gParticle);
float l9_4;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_4=(*sc_set0.UserUniforms).overrideTimeElapsed;
}
else
{
l9_4=(*sc_set0.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_4;
float l9_5;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_5=(*sc_set0.UserUniforms).overrideTimeDelta;
}
else
{
l9_5=fast::max((*sc_set0.UserUniforms).sc_Time.y,0.0);
}
Globals.gTimeDelta=l9_5;
Globals.gTimeElapsedShifted=(Globals.gTimeElapsed-(gParticle.TimeShift*Globals.gTimeDelta))-0.0;
float Warmup=0.0;
float Delay=0.0;
gParticle.Age=mod((Globals.gTimeElapsedShifted-gParticle.SpawnOffset)+Warmup,0.2);
float l9_6=Globals.gTimeElapsed;
float l9_7=gParticle.SpawnOffset;
float l9_8=Delay;
float l9_9=Warmup;
bool l9_10=(l9_6-l9_7)<(l9_8-l9_9);
bool l9_11;
if (!l9_10)
{
l9_11=gParticle.Age>0.2;
}
else
{
l9_11=l9_10;
}
bool Dead=l9_11 ? true : false;
bool l9_12=Dead;
bool l9_13=!l9_12;
bool l9_14;
if (l9_13)
{
l9_14=gParticle.Life<=9.9999997e-05;
}
else
{
l9_14=l9_13;
}
bool l9_15;
if (!l9_14)
{
l9_15=mod(((fast::max(Globals.gTimeElapsed,0.1)-gParticle.SpawnOffset)-Delay)+Warmup,0.2)<=Globals.gTimeDelta;
}
else
{
l9_15=l9_14;
}
if (l9_15)
{
ssGlobals param_1=Globals;
ssParticle l9_16=gParticle;
float l9_17;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_17=(*sc_set0.UserUniforms).overrideTimeElapsed;
}
else
{
l9_17=(*sc_set0.UserUniforms).sc_Time.x;
}
float l9_18=l9_17;
l9_16.Seed=(l9_16.Ratio1D*0.97637898)+0.151235;
l9_16.Seed+=(floor(((((l9_18-l9_16.SpawnOffset)-0.0)+0.0)+0.40000001)/0.2)*4.32723);
l9_16.Seed=fract(abs(l9_16.Seed));
int2 l9_19=int2(l9_16.Index1D%400,l9_16.Index1D/400);
l9_16.Seed2000=(float2(l9_19)+float2(1.0))/float2(399.0);
gParticle=l9_16;
float l9_20=6.0;
gParticle.Position=(float3(((floor(mod(gParticle.Index1DPerCopyF,floor(l9_20)))/l9_20)*2.0)-1.0,((floor(gParticle.Index1DPerCopyF/floor(l9_20))/l9_20)*2.0)-1.0,0.0)*20.0)+float3(1.0,1.0,0.0);
gParticle.Velocity=float3(0.0);
gParticle.Color=float4(1.0);
gParticle.Age=0.0;
gParticle.Life=0.2;
gParticle.Size=1.0;
gParticle.Mass=1.0;
gParticle.Matrix=float3x3(float3(1.0,0.0,0.0),float3(0.0,1.0,0.0),float3(0.0,0.0,1.0));
gParticle.Quaternion=float4(0.0,0.0,0.0,1.0);
float3 l9_21=float3(0.0);
l9_21=(*sc_set0.UserUniforms).Port_Import_N216;
float l9_22=0.0;
float l9_23=0.0;
float l9_24=0.0;
float l9_25=0.0;
ssGlobals l9_26=param_1;
float l9_27=0.0;
l9_27=0.0;
float l9_28=0.0;
l9_28=float(l9_27==(*sc_set0.UserUniforms).Port_Input1_N149);
l9_23=l9_28;
float l9_29;
if ((l9_23*1.0)!=0.0)
{
float3 l9_30=float3(0.0);
float3 l9_31=(*sc_set0.UserUniforms).Port_Min_N150;
float3 l9_32=(*sc_set0.UserUniforms).Port_Max_N150;
ssGlobals l9_33=l9_26;
int l9_34=3;
bool l9_35=true;
bool l9_36=true;
bool l9_37=true;
float l9_38=150.0;
ssParticle l9_39=gParticle;
float l9_40=0.0;
float l9_41=l9_33.gTimeElapsed;
float4 l9_42=float4(0.0);
float4 l9_43=float4(0.0);
if (l9_35)
{
l9_43.x=floor(fract(l9_41)*1000.0);
}
if (l9_37)
{
l9_43.y=float(l9_39.Index1D^((l9_39.Index1D*15299)+l9_39.Index1D));
}
if (l9_36)
{
l9_43.z=l9_38;
}
l9_43.w=l9_40*1000.0;
int l9_44=int(l9_43.x);
int l9_45=int(l9_43.y);
int l9_46=int(l9_43.z);
int l9_47=int(l9_43.w);
int l9_48=(((l9_44*15299)^(l9_45*30133))^(l9_46*17539))^(l9_47*12113);
int l9_49=l9_48;
if (l9_34==1)
{
int l9_50=l9_49;
int l9_51=l9_50;
int l9_52=((l9_51*((l9_51*1471343)+101146501))+1559861749)&2147483647;
int l9_53=l9_52;
float l9_54=float(l9_53)*4.6566129e-10;
float l9_55=l9_54;
l9_42.x=l9_55;
}
else
{
if (l9_34==2)
{
int l9_56=l9_49;
int l9_57=l9_56;
int l9_58=((l9_57*((l9_57*1471343)+101146501))+1559861749)&2147483647;
int l9_59=l9_58;
int l9_60=l9_56*1399;
int l9_61=((l9_60*((l9_60*1471343)+101146501))+1559861749)&2147483647;
int l9_62=l9_61;
int l9_63=l9_59;
float l9_64=float(l9_63)*4.6566129e-10;
int l9_65=l9_62;
float l9_66=float(l9_65)*4.6566129e-10;
float2 l9_67=float2(l9_64,l9_66);
l9_42=float4(l9_67.x,l9_67.y,l9_42.z,l9_42.w);
}
else
{
if (l9_34==3)
{
int l9_68=l9_49;
int l9_69=l9_68;
int l9_70=((l9_69*((l9_69*1471343)+101146501))+1559861749)&2147483647;
int l9_71=l9_70;
int l9_72=l9_68*1399;
int l9_73=((l9_72*((l9_72*1471343)+101146501))+1559861749)&2147483647;
int l9_74=l9_73;
int l9_75=l9_68*7177;
int l9_76=((l9_75*((l9_75*1471343)+101146501))+1559861749)&2147483647;
int l9_77=l9_76;
int l9_78=l9_71;
float l9_79=float(l9_78)*4.6566129e-10;
int l9_80=l9_74;
float l9_81=float(l9_80)*4.6566129e-10;
int l9_82=l9_77;
float l9_83=float(l9_82)*4.6566129e-10;
float3 l9_84=float3(l9_79,l9_81,l9_83);
l9_42=float4(l9_84.x,l9_84.y,l9_84.z,l9_42.w);
}
else
{
int l9_85=l9_49;
int l9_86=l9_85;
int l9_87=((l9_86*((l9_86*1471343)+101146501))+1559861749)&2147483647;
int l9_88=l9_87;
int l9_89=l9_85*1399;
int l9_90=((l9_89*((l9_89*1471343)+101146501))+1559861749)&2147483647;
int l9_91=l9_90;
int l9_92=l9_85*7177;
int l9_93=((l9_92*((l9_92*1471343)+101146501))+1559861749)&2147483647;
int l9_94=l9_93;
int l9_95=l9_85*18919;
int l9_96=((l9_95*((l9_95*1471343)+101146501))+1559861749)&2147483647;
int l9_97=l9_96;
int l9_98=l9_88;
float l9_99=float(l9_98)*4.6566129e-10;
int l9_100=l9_91;
float l9_101=float(l9_100)*4.6566129e-10;
int l9_102=l9_94;
float l9_103=float(l9_102)*4.6566129e-10;
int l9_104=l9_97;
float l9_105=float(l9_104)*4.6566129e-10;
float4 l9_106=float4(l9_99,l9_101,l9_103,l9_105);
l9_42=l9_106;
}
}
}
float4 l9_107=l9_42;
float4 l9_108=l9_107;
float3 l9_109=mix(l9_31,l9_32,l9_108.xyz);
l9_30=l9_109;
float l9_110=0.0;
l9_110=length(l9_30);
float3 l9_111=float3(0.0);
l9_111=l9_30/(float3(l9_110)+float3(1.234e-06));
float l9_112=0.0;
l9_112=fast::clamp((*sc_set0.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_113=0.0;
l9_113=1.0-l9_112;
float l9_114=0.0;
float l9_115;
if (l9_113<=0.0)
{
l9_115=0.0;
}
else
{
l9_115=pow(l9_113,(*sc_set0.UserUniforms).Port_Input1_N153);
}
l9_114=l9_115;
float3 l9_116=float3(0.0);
float3 l9_117=float3(l9_114);
float3 l9_118=(*sc_set0.UserUniforms).Port_Max_N154;
ssGlobals l9_119=l9_26;
int l9_120=3;
bool l9_121=true;
bool l9_122=true;
bool l9_123=true;
float l9_124=154.0;
ssParticle l9_125=gParticle;
float l9_126=0.0;
float l9_127=l9_119.gTimeElapsed;
float4 l9_128=float4(0.0);
float4 l9_129=float4(0.0);
if (l9_121)
{
l9_129.x=floor(fract(l9_127)*1000.0);
}
if (l9_123)
{
l9_129.y=float(l9_125.Index1D^((l9_125.Index1D*15299)+l9_125.Index1D));
}
if (l9_122)
{
l9_129.z=l9_124;
}
l9_129.w=l9_126*1000.0;
int l9_130=int(l9_129.x);
int l9_131=int(l9_129.y);
int l9_132=int(l9_129.z);
int l9_133=int(l9_129.w);
int l9_134=(((l9_130*15299)^(l9_131*30133))^(l9_132*17539))^(l9_133*12113);
int l9_135=l9_134;
if (l9_120==1)
{
int l9_136=l9_135;
int l9_137=l9_136;
int l9_138=((l9_137*((l9_137*1471343)+101146501))+1559861749)&2147483647;
int l9_139=l9_138;
float l9_140=float(l9_139)*4.6566129e-10;
float l9_141=l9_140;
l9_128.x=l9_141;
}
else
{
if (l9_120==2)
{
int l9_142=l9_135;
int l9_143=l9_142;
int l9_144=((l9_143*((l9_143*1471343)+101146501))+1559861749)&2147483647;
int l9_145=l9_144;
int l9_146=l9_142*1399;
int l9_147=((l9_146*((l9_146*1471343)+101146501))+1559861749)&2147483647;
int l9_148=l9_147;
int l9_149=l9_145;
float l9_150=float(l9_149)*4.6566129e-10;
int l9_151=l9_148;
float l9_152=float(l9_151)*4.6566129e-10;
float2 l9_153=float2(l9_150,l9_152);
l9_128=float4(l9_153.x,l9_153.y,l9_128.z,l9_128.w);
}
else
{
if (l9_120==3)
{
int l9_154=l9_135;
int l9_155=l9_154;
int l9_156=((l9_155*((l9_155*1471343)+101146501))+1559861749)&2147483647;
int l9_157=l9_156;
int l9_158=l9_154*1399;
int l9_159=((l9_158*((l9_158*1471343)+101146501))+1559861749)&2147483647;
int l9_160=l9_159;
int l9_161=l9_154*7177;
int l9_162=((l9_161*((l9_161*1471343)+101146501))+1559861749)&2147483647;
int l9_163=l9_162;
int l9_164=l9_157;
float l9_165=float(l9_164)*4.6566129e-10;
int l9_166=l9_160;
float l9_167=float(l9_166)*4.6566129e-10;
int l9_168=l9_163;
float l9_169=float(l9_168)*4.6566129e-10;
float3 l9_170=float3(l9_165,l9_167,l9_169);
l9_128=float4(l9_170.x,l9_170.y,l9_170.z,l9_128.w);
}
else
{
int l9_171=l9_135;
int l9_172=l9_171;
int l9_173=((l9_172*((l9_172*1471343)+101146501))+1559861749)&2147483647;
int l9_174=l9_173;
int l9_175=l9_171*1399;
int l9_176=((l9_175*((l9_175*1471343)+101146501))+1559861749)&2147483647;
int l9_177=l9_176;
int l9_178=l9_171*7177;
int l9_179=((l9_178*((l9_178*1471343)+101146501))+1559861749)&2147483647;
int l9_180=l9_179;
int l9_181=l9_171*18919;
int l9_182=((l9_181*((l9_181*1471343)+101146501))+1559861749)&2147483647;
int l9_183=l9_182;
int l9_184=l9_174;
float l9_185=float(l9_184)*4.6566129e-10;
int l9_186=l9_177;
float l9_187=float(l9_186)*4.6566129e-10;
int l9_188=l9_180;
float l9_189=float(l9_188)*4.6566129e-10;
int l9_190=l9_183;
float l9_191=float(l9_190)*4.6566129e-10;
float4 l9_192=float4(l9_185,l9_187,l9_189,l9_191);
l9_128=l9_192;
}
}
}
float4 l9_193=l9_128;
float4 l9_194=l9_193;
float3 l9_195=mix(l9_117,l9_118,l9_194.xyz);
l9_116=l9_195;
float3 l9_196=float3(0.0);
float l9_197;
if (l9_116.x<=0.0)
{
l9_197=0.0;
}
else
{
l9_197=sqrt(l9_116.x);
}
float l9_198=l9_197;
float l9_199;
if (l9_116.y<=0.0)
{
l9_199=0.0;
}
else
{
l9_199=sqrt(l9_116.y);
}
float l9_200=l9_199;
float l9_201;
if (l9_116.z<=0.0)
{
l9_201=0.0;
}
else
{
l9_201=sqrt(l9_116.z);
}
l9_196=float3(l9_198,l9_200,l9_201);
float3 l9_202=float3(0.0);
float l9_203;
if (l9_196.x<=0.0)
{
l9_203=0.0;
}
else
{
l9_203=sqrt(l9_196.x);
}
float l9_204=l9_203;
float l9_205;
if (l9_196.y<=0.0)
{
l9_205=0.0;
}
else
{
l9_205=sqrt(l9_196.y);
}
float l9_206=l9_205;
float l9_207;
if (l9_196.z<=0.0)
{
l9_207=0.0;
}
else
{
l9_207=sqrt(l9_196.z);
}
l9_202=float3(l9_204,l9_206,l9_207);
float l9_208=0.0;
l9_208=(*sc_set0.UserUniforms).Port_Import_N157;
float3 l9_209=float3(0.0);
l9_209=(*sc_set0.UserUniforms).Port_Import_N158;
float3 l9_210=float3(0.0);
l9_210=((l9_111*l9_202)*float3(l9_208))*l9_209;
float l9_211=0.0;
float3 l9_212=l9_210;
float l9_213=l9_212.x;
l9_211=l9_213;
float l9_214=0.0;
l9_214=abs(l9_211);
l9_24=l9_214;
l9_29=l9_24;
}
else
{
float3 l9_215=float3(0.0);
float3 l9_216=(*sc_set0.UserUniforms).Port_Min_N150;
float3 l9_217=(*sc_set0.UserUniforms).Port_Max_N150;
ssGlobals l9_218=l9_26;
int l9_219=3;
bool l9_220=true;
bool l9_221=true;
bool l9_222=true;
float l9_223=150.0;
ssParticle l9_224=gParticle;
float l9_225=0.0;
float l9_226=l9_218.gTimeElapsed;
float4 l9_227=float4(0.0);
float4 l9_228=float4(0.0);
if (l9_220)
{
l9_228.x=floor(fract(l9_226)*1000.0);
}
if (l9_222)
{
l9_228.y=float(l9_224.Index1D^((l9_224.Index1D*15299)+l9_224.Index1D));
}
if (l9_221)
{
l9_228.z=l9_223;
}
l9_228.w=l9_225*1000.0;
int l9_229=int(l9_228.x);
int l9_230=int(l9_228.y);
int l9_231=int(l9_228.z);
int l9_232=int(l9_228.w);
int l9_233=(((l9_229*15299)^(l9_230*30133))^(l9_231*17539))^(l9_232*12113);
int l9_234=l9_233;
if (l9_219==1)
{
int l9_235=l9_234;
int l9_236=l9_235;
int l9_237=((l9_236*((l9_236*1471343)+101146501))+1559861749)&2147483647;
int l9_238=l9_237;
float l9_239=float(l9_238)*4.6566129e-10;
float l9_240=l9_239;
l9_227.x=l9_240;
}
else
{
if (l9_219==2)
{
int l9_241=l9_234;
int l9_242=l9_241;
int l9_243=((l9_242*((l9_242*1471343)+101146501))+1559861749)&2147483647;
int l9_244=l9_243;
int l9_245=l9_241*1399;
int l9_246=((l9_245*((l9_245*1471343)+101146501))+1559861749)&2147483647;
int l9_247=l9_246;
int l9_248=l9_244;
float l9_249=float(l9_248)*4.6566129e-10;
int l9_250=l9_247;
float l9_251=float(l9_250)*4.6566129e-10;
float2 l9_252=float2(l9_249,l9_251);
l9_227=float4(l9_252.x,l9_252.y,l9_227.z,l9_227.w);
}
else
{
if (l9_219==3)
{
int l9_253=l9_234;
int l9_254=l9_253;
int l9_255=((l9_254*((l9_254*1471343)+101146501))+1559861749)&2147483647;
int l9_256=l9_255;
int l9_257=l9_253*1399;
int l9_258=((l9_257*((l9_257*1471343)+101146501))+1559861749)&2147483647;
int l9_259=l9_258;
int l9_260=l9_253*7177;
int l9_261=((l9_260*((l9_260*1471343)+101146501))+1559861749)&2147483647;
int l9_262=l9_261;
int l9_263=l9_256;
float l9_264=float(l9_263)*4.6566129e-10;
int l9_265=l9_259;
float l9_266=float(l9_265)*4.6566129e-10;
int l9_267=l9_262;
float l9_268=float(l9_267)*4.6566129e-10;
float3 l9_269=float3(l9_264,l9_266,l9_268);
l9_227=float4(l9_269.x,l9_269.y,l9_269.z,l9_227.w);
}
else
{
int l9_270=l9_234;
int l9_271=l9_270;
int l9_272=((l9_271*((l9_271*1471343)+101146501))+1559861749)&2147483647;
int l9_273=l9_272;
int l9_274=l9_270*1399;
int l9_275=((l9_274*((l9_274*1471343)+101146501))+1559861749)&2147483647;
int l9_276=l9_275;
int l9_277=l9_270*7177;
int l9_278=((l9_277*((l9_277*1471343)+101146501))+1559861749)&2147483647;
int l9_279=l9_278;
int l9_280=l9_270*18919;
int l9_281=((l9_280*((l9_280*1471343)+101146501))+1559861749)&2147483647;
int l9_282=l9_281;
int l9_283=l9_273;
float l9_284=float(l9_283)*4.6566129e-10;
int l9_285=l9_276;
float l9_286=float(l9_285)*4.6566129e-10;
int l9_287=l9_279;
float l9_288=float(l9_287)*4.6566129e-10;
int l9_289=l9_282;
float l9_290=float(l9_289)*4.6566129e-10;
float4 l9_291=float4(l9_284,l9_286,l9_288,l9_290);
l9_227=l9_291;
}
}
}
float4 l9_292=l9_227;
float4 l9_293=l9_292;
float3 l9_294=mix(l9_216,l9_217,l9_293.xyz);
l9_215=l9_294;
float l9_295=0.0;
l9_295=length(l9_215);
float3 l9_296=float3(0.0);
l9_296=l9_215/(float3(l9_295)+float3(1.234e-06));
float l9_297=0.0;
l9_297=fast::clamp((*sc_set0.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_298=0.0;
l9_298=1.0-l9_297;
float l9_299=0.0;
float l9_300;
if (l9_298<=0.0)
{
l9_300=0.0;
}
else
{
l9_300=pow(l9_298,(*sc_set0.UserUniforms).Port_Input1_N153);
}
l9_299=l9_300;
float3 l9_301=float3(0.0);
float3 l9_302=float3(l9_299);
float3 l9_303=(*sc_set0.UserUniforms).Port_Max_N154;
ssGlobals l9_304=l9_26;
int l9_305=3;
bool l9_306=true;
bool l9_307=true;
bool l9_308=true;
float l9_309=154.0;
ssParticle l9_310=gParticle;
float l9_311=0.0;
float l9_312=l9_304.gTimeElapsed;
float4 l9_313=float4(0.0);
float4 l9_314=float4(0.0);
if (l9_306)
{
l9_314.x=floor(fract(l9_312)*1000.0);
}
if (l9_308)
{
l9_314.y=float(l9_310.Index1D^((l9_310.Index1D*15299)+l9_310.Index1D));
}
if (l9_307)
{
l9_314.z=l9_309;
}
l9_314.w=l9_311*1000.0;
int l9_315=int(l9_314.x);
int l9_316=int(l9_314.y);
int l9_317=int(l9_314.z);
int l9_318=int(l9_314.w);
int l9_319=(((l9_315*15299)^(l9_316*30133))^(l9_317*17539))^(l9_318*12113);
int l9_320=l9_319;
if (l9_305==1)
{
int l9_321=l9_320;
int l9_322=l9_321;
int l9_323=((l9_322*((l9_322*1471343)+101146501))+1559861749)&2147483647;
int l9_324=l9_323;
float l9_325=float(l9_324)*4.6566129e-10;
float l9_326=l9_325;
l9_313.x=l9_326;
}
else
{
if (l9_305==2)
{
int l9_327=l9_320;
int l9_328=l9_327;
int l9_329=((l9_328*((l9_328*1471343)+101146501))+1559861749)&2147483647;
int l9_330=l9_329;
int l9_331=l9_327*1399;
int l9_332=((l9_331*((l9_331*1471343)+101146501))+1559861749)&2147483647;
int l9_333=l9_332;
int l9_334=l9_330;
float l9_335=float(l9_334)*4.6566129e-10;
int l9_336=l9_333;
float l9_337=float(l9_336)*4.6566129e-10;
float2 l9_338=float2(l9_335,l9_337);
l9_313=float4(l9_338.x,l9_338.y,l9_313.z,l9_313.w);
}
else
{
if (l9_305==3)
{
int l9_339=l9_320;
int l9_340=l9_339;
int l9_341=((l9_340*((l9_340*1471343)+101146501))+1559861749)&2147483647;
int l9_342=l9_341;
int l9_343=l9_339*1399;
int l9_344=((l9_343*((l9_343*1471343)+101146501))+1559861749)&2147483647;
int l9_345=l9_344;
int l9_346=l9_339*7177;
int l9_347=((l9_346*((l9_346*1471343)+101146501))+1559861749)&2147483647;
int l9_348=l9_347;
int l9_349=l9_342;
float l9_350=float(l9_349)*4.6566129e-10;
int l9_351=l9_345;
float l9_352=float(l9_351)*4.6566129e-10;
int l9_353=l9_348;
float l9_354=float(l9_353)*4.6566129e-10;
float3 l9_355=float3(l9_350,l9_352,l9_354);
l9_313=float4(l9_355.x,l9_355.y,l9_355.z,l9_313.w);
}
else
{
int l9_356=l9_320;
int l9_357=l9_356;
int l9_358=((l9_357*((l9_357*1471343)+101146501))+1559861749)&2147483647;
int l9_359=l9_358;
int l9_360=l9_356*1399;
int l9_361=((l9_360*((l9_360*1471343)+101146501))+1559861749)&2147483647;
int l9_362=l9_361;
int l9_363=l9_356*7177;
int l9_364=((l9_363*((l9_363*1471343)+101146501))+1559861749)&2147483647;
int l9_365=l9_364;
int l9_366=l9_356*18919;
int l9_367=((l9_366*((l9_366*1471343)+101146501))+1559861749)&2147483647;
int l9_368=l9_367;
int l9_369=l9_359;
float l9_370=float(l9_369)*4.6566129e-10;
int l9_371=l9_362;
float l9_372=float(l9_371)*4.6566129e-10;
int l9_373=l9_365;
float l9_374=float(l9_373)*4.6566129e-10;
int l9_375=l9_368;
float l9_376=float(l9_375)*4.6566129e-10;
float4 l9_377=float4(l9_370,l9_372,l9_374,l9_376);
l9_313=l9_377;
}
}
}
float4 l9_378=l9_313;
float4 l9_379=l9_378;
float3 l9_380=mix(l9_302,l9_303,l9_379.xyz);
l9_301=l9_380;
float3 l9_381=float3(0.0);
float l9_382;
if (l9_301.x<=0.0)
{
l9_382=0.0;
}
else
{
l9_382=sqrt(l9_301.x);
}
float l9_383=l9_382;
float l9_384;
if (l9_301.y<=0.0)
{
l9_384=0.0;
}
else
{
l9_384=sqrt(l9_301.y);
}
float l9_385=l9_384;
float l9_386;
if (l9_301.z<=0.0)
{
l9_386=0.0;
}
else
{
l9_386=sqrt(l9_301.z);
}
l9_381=float3(l9_383,l9_385,l9_386);
float3 l9_387=float3(0.0);
float l9_388;
if (l9_381.x<=0.0)
{
l9_388=0.0;
}
else
{
l9_388=sqrt(l9_381.x);
}
float l9_389=l9_388;
float l9_390;
if (l9_381.y<=0.0)
{
l9_390=0.0;
}
else
{
l9_390=sqrt(l9_381.y);
}
float l9_391=l9_390;
float l9_392;
if (l9_381.z<=0.0)
{
l9_392=0.0;
}
else
{
l9_392=sqrt(l9_381.z);
}
l9_387=float3(l9_389,l9_391,l9_392);
float l9_393=0.0;
l9_393=(*sc_set0.UserUniforms).Port_Import_N157;
float3 l9_394=float3(0.0);
l9_394=(*sc_set0.UserUniforms).Port_Import_N158;
float3 l9_395=float3(0.0);
l9_395=((l9_296*l9_387)*float3(l9_393))*l9_394;
float l9_396=0.0;
float3 l9_397=l9_395;
float l9_398=l9_397.x;
l9_396=l9_398;
l9_25=l9_396;
l9_29=l9_25;
}
l9_22=l9_29;
float l9_399=0.0;
float l9_400=0.0;
float l9_401=0.0;
float l9_402=0.0;
ssGlobals l9_403=param_1;
float l9_404=0.0;
l9_404=0.0;
float l9_405=0.0;
l9_405=float(l9_404==(*sc_set0.UserUniforms).Port_Input1_N162);
l9_400=l9_405;
float l9_406;
if ((l9_400*1.0)!=0.0)
{
float3 l9_407=float3(0.0);
float3 l9_408=(*sc_set0.UserUniforms).Port_Min_N150;
float3 l9_409=(*sc_set0.UserUniforms).Port_Max_N150;
ssGlobals l9_410=l9_403;
int l9_411=3;
bool l9_412=true;
bool l9_413=true;
bool l9_414=true;
float l9_415=150.0;
ssParticle l9_416=gParticle;
float l9_417=0.0;
float l9_418=l9_410.gTimeElapsed;
float4 l9_419=float4(0.0);
float4 l9_420=float4(0.0);
if (l9_412)
{
l9_420.x=floor(fract(l9_418)*1000.0);
}
if (l9_414)
{
l9_420.y=float(l9_416.Index1D^((l9_416.Index1D*15299)+l9_416.Index1D));
}
if (l9_413)
{
l9_420.z=l9_415;
}
l9_420.w=l9_417*1000.0;
int l9_421=int(l9_420.x);
int l9_422=int(l9_420.y);
int l9_423=int(l9_420.z);
int l9_424=int(l9_420.w);
int l9_425=(((l9_421*15299)^(l9_422*30133))^(l9_423*17539))^(l9_424*12113);
int l9_426=l9_425;
if (l9_411==1)
{
int l9_427=l9_426;
int l9_428=l9_427;
int l9_429=((l9_428*((l9_428*1471343)+101146501))+1559861749)&2147483647;
int l9_430=l9_429;
float l9_431=float(l9_430)*4.6566129e-10;
float l9_432=l9_431;
l9_419.x=l9_432;
}
else
{
if (l9_411==2)
{
int l9_433=l9_426;
int l9_434=l9_433;
int l9_435=((l9_434*((l9_434*1471343)+101146501))+1559861749)&2147483647;
int l9_436=l9_435;
int l9_437=l9_433*1399;
int l9_438=((l9_437*((l9_437*1471343)+101146501))+1559861749)&2147483647;
int l9_439=l9_438;
int l9_440=l9_436;
float l9_441=float(l9_440)*4.6566129e-10;
int l9_442=l9_439;
float l9_443=float(l9_442)*4.6566129e-10;
float2 l9_444=float2(l9_441,l9_443);
l9_419=float4(l9_444.x,l9_444.y,l9_419.z,l9_419.w);
}
else
{
if (l9_411==3)
{
int l9_445=l9_426;
int l9_446=l9_445;
int l9_447=((l9_446*((l9_446*1471343)+101146501))+1559861749)&2147483647;
int l9_448=l9_447;
int l9_449=l9_445*1399;
int l9_450=((l9_449*((l9_449*1471343)+101146501))+1559861749)&2147483647;
int l9_451=l9_450;
int l9_452=l9_445*7177;
int l9_453=((l9_452*((l9_452*1471343)+101146501))+1559861749)&2147483647;
int l9_454=l9_453;
int l9_455=l9_448;
float l9_456=float(l9_455)*4.6566129e-10;
int l9_457=l9_451;
float l9_458=float(l9_457)*4.6566129e-10;
int l9_459=l9_454;
float l9_460=float(l9_459)*4.6566129e-10;
float3 l9_461=float3(l9_456,l9_458,l9_460);
l9_419=float4(l9_461.x,l9_461.y,l9_461.z,l9_419.w);
}
else
{
int l9_462=l9_426;
int l9_463=l9_462;
int l9_464=((l9_463*((l9_463*1471343)+101146501))+1559861749)&2147483647;
int l9_465=l9_464;
int l9_466=l9_462*1399;
int l9_467=((l9_466*((l9_466*1471343)+101146501))+1559861749)&2147483647;
int l9_468=l9_467;
int l9_469=l9_462*7177;
int l9_470=((l9_469*((l9_469*1471343)+101146501))+1559861749)&2147483647;
int l9_471=l9_470;
int l9_472=l9_462*18919;
int l9_473=((l9_472*((l9_472*1471343)+101146501))+1559861749)&2147483647;
int l9_474=l9_473;
int l9_475=l9_465;
float l9_476=float(l9_475)*4.6566129e-10;
int l9_477=l9_468;
float l9_478=float(l9_477)*4.6566129e-10;
int l9_479=l9_471;
float l9_480=float(l9_479)*4.6566129e-10;
int l9_481=l9_474;
float l9_482=float(l9_481)*4.6566129e-10;
float4 l9_483=float4(l9_476,l9_478,l9_480,l9_482);
l9_419=l9_483;
}
}
}
float4 l9_484=l9_419;
float4 l9_485=l9_484;
float3 l9_486=mix(l9_408,l9_409,l9_485.xyz);
l9_407=l9_486;
float l9_487=0.0;
l9_487=length(l9_407);
float3 l9_488=float3(0.0);
l9_488=l9_407/(float3(l9_487)+float3(1.234e-06));
float l9_489=0.0;
l9_489=fast::clamp((*sc_set0.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_490=0.0;
l9_490=1.0-l9_489;
float l9_491=0.0;
float l9_492;
if (l9_490<=0.0)
{
l9_492=0.0;
}
else
{
l9_492=pow(l9_490,(*sc_set0.UserUniforms).Port_Input1_N153);
}
l9_491=l9_492;
float3 l9_493=float3(0.0);
float3 l9_494=float3(l9_491);
float3 l9_495=(*sc_set0.UserUniforms).Port_Max_N154;
ssGlobals l9_496=l9_403;
int l9_497=3;
bool l9_498=true;
bool l9_499=true;
bool l9_500=true;
float l9_501=154.0;
ssParticle l9_502=gParticle;
float l9_503=0.0;
float l9_504=l9_496.gTimeElapsed;
float4 l9_505=float4(0.0);
float4 l9_506=float4(0.0);
if (l9_498)
{
l9_506.x=floor(fract(l9_504)*1000.0);
}
if (l9_500)
{
l9_506.y=float(l9_502.Index1D^((l9_502.Index1D*15299)+l9_502.Index1D));
}
if (l9_499)
{
l9_506.z=l9_501;
}
l9_506.w=l9_503*1000.0;
int l9_507=int(l9_506.x);
int l9_508=int(l9_506.y);
int l9_509=int(l9_506.z);
int l9_510=int(l9_506.w);
int l9_511=(((l9_507*15299)^(l9_508*30133))^(l9_509*17539))^(l9_510*12113);
int l9_512=l9_511;
if (l9_497==1)
{
int l9_513=l9_512;
int l9_514=l9_513;
int l9_515=((l9_514*((l9_514*1471343)+101146501))+1559861749)&2147483647;
int l9_516=l9_515;
float l9_517=float(l9_516)*4.6566129e-10;
float l9_518=l9_517;
l9_505.x=l9_518;
}
else
{
if (l9_497==2)
{
int l9_519=l9_512;
int l9_520=l9_519;
int l9_521=((l9_520*((l9_520*1471343)+101146501))+1559861749)&2147483647;
int l9_522=l9_521;
int l9_523=l9_519*1399;
int l9_524=((l9_523*((l9_523*1471343)+101146501))+1559861749)&2147483647;
int l9_525=l9_524;
int l9_526=l9_522;
float l9_527=float(l9_526)*4.6566129e-10;
int l9_528=l9_525;
float l9_529=float(l9_528)*4.6566129e-10;
float2 l9_530=float2(l9_527,l9_529);
l9_505=float4(l9_530.x,l9_530.y,l9_505.z,l9_505.w);
}
else
{
if (l9_497==3)
{
int l9_531=l9_512;
int l9_532=l9_531;
int l9_533=((l9_532*((l9_532*1471343)+101146501))+1559861749)&2147483647;
int l9_534=l9_533;
int l9_535=l9_531*1399;
int l9_536=((l9_535*((l9_535*1471343)+101146501))+1559861749)&2147483647;
int l9_537=l9_536;
int l9_538=l9_531*7177;
int l9_539=((l9_538*((l9_538*1471343)+101146501))+1559861749)&2147483647;
int l9_540=l9_539;
int l9_541=l9_534;
float l9_542=float(l9_541)*4.6566129e-10;
int l9_543=l9_537;
float l9_544=float(l9_543)*4.6566129e-10;
int l9_545=l9_540;
float l9_546=float(l9_545)*4.6566129e-10;
float3 l9_547=float3(l9_542,l9_544,l9_546);
l9_505=float4(l9_547.x,l9_547.y,l9_547.z,l9_505.w);
}
else
{
int l9_548=l9_512;
int l9_549=l9_548;
int l9_550=((l9_549*((l9_549*1471343)+101146501))+1559861749)&2147483647;
int l9_551=l9_550;
int l9_552=l9_548*1399;
int l9_553=((l9_552*((l9_552*1471343)+101146501))+1559861749)&2147483647;
int l9_554=l9_553;
int l9_555=l9_548*7177;
int l9_556=((l9_555*((l9_555*1471343)+101146501))+1559861749)&2147483647;
int l9_557=l9_556;
int l9_558=l9_548*18919;
int l9_559=((l9_558*((l9_558*1471343)+101146501))+1559861749)&2147483647;
int l9_560=l9_559;
int l9_561=l9_551;
float l9_562=float(l9_561)*4.6566129e-10;
int l9_563=l9_554;
float l9_564=float(l9_563)*4.6566129e-10;
int l9_565=l9_557;
float l9_566=float(l9_565)*4.6566129e-10;
int l9_567=l9_560;
float l9_568=float(l9_567)*4.6566129e-10;
float4 l9_569=float4(l9_562,l9_564,l9_566,l9_568);
l9_505=l9_569;
}
}
}
float4 l9_570=l9_505;
float4 l9_571=l9_570;
float3 l9_572=mix(l9_494,l9_495,l9_571.xyz);
l9_493=l9_572;
float3 l9_573=float3(0.0);
float l9_574;
if (l9_493.x<=0.0)
{
l9_574=0.0;
}
else
{
l9_574=sqrt(l9_493.x);
}
float l9_575=l9_574;
float l9_576;
if (l9_493.y<=0.0)
{
l9_576=0.0;
}
else
{
l9_576=sqrt(l9_493.y);
}
float l9_577=l9_576;
float l9_578;
if (l9_493.z<=0.0)
{
l9_578=0.0;
}
else
{
l9_578=sqrt(l9_493.z);
}
l9_573=float3(l9_575,l9_577,l9_578);
float3 l9_579=float3(0.0);
float l9_580;
if (l9_573.x<=0.0)
{
l9_580=0.0;
}
else
{
l9_580=sqrt(l9_573.x);
}
float l9_581=l9_580;
float l9_582;
if (l9_573.y<=0.0)
{
l9_582=0.0;
}
else
{
l9_582=sqrt(l9_573.y);
}
float l9_583=l9_582;
float l9_584;
if (l9_573.z<=0.0)
{
l9_584=0.0;
}
else
{
l9_584=sqrt(l9_573.z);
}
l9_579=float3(l9_581,l9_583,l9_584);
float l9_585=0.0;
l9_585=(*sc_set0.UserUniforms).Port_Import_N157;
float3 l9_586=float3(0.0);
l9_586=(*sc_set0.UserUniforms).Port_Import_N158;
float3 l9_587=float3(0.0);
l9_587=((l9_488*l9_579)*float3(l9_585))*l9_586;
float l9_588=0.0;
float3 l9_589=l9_587;
float l9_590=l9_589.y;
l9_588=l9_590;
float l9_591=0.0;
l9_591=abs(l9_588);
l9_401=l9_591;
l9_406=l9_401;
}
else
{
float3 l9_592=float3(0.0);
float3 l9_593=(*sc_set0.UserUniforms).Port_Min_N150;
float3 l9_594=(*sc_set0.UserUniforms).Port_Max_N150;
ssGlobals l9_595=l9_403;
int l9_596=3;
bool l9_597=true;
bool l9_598=true;
bool l9_599=true;
float l9_600=150.0;
ssParticle l9_601=gParticle;
float l9_602=0.0;
float l9_603=l9_595.gTimeElapsed;
float4 l9_604=float4(0.0);
float4 l9_605=float4(0.0);
if (l9_597)
{
l9_605.x=floor(fract(l9_603)*1000.0);
}
if (l9_599)
{
l9_605.y=float(l9_601.Index1D^((l9_601.Index1D*15299)+l9_601.Index1D));
}
if (l9_598)
{
l9_605.z=l9_600;
}
l9_605.w=l9_602*1000.0;
int l9_606=int(l9_605.x);
int l9_607=int(l9_605.y);
int l9_608=int(l9_605.z);
int l9_609=int(l9_605.w);
int l9_610=(((l9_606*15299)^(l9_607*30133))^(l9_608*17539))^(l9_609*12113);
int l9_611=l9_610;
if (l9_596==1)
{
int l9_612=l9_611;
int l9_613=l9_612;
int l9_614=((l9_613*((l9_613*1471343)+101146501))+1559861749)&2147483647;
int l9_615=l9_614;
float l9_616=float(l9_615)*4.6566129e-10;
float l9_617=l9_616;
l9_604.x=l9_617;
}
else
{
if (l9_596==2)
{
int l9_618=l9_611;
int l9_619=l9_618;
int l9_620=((l9_619*((l9_619*1471343)+101146501))+1559861749)&2147483647;
int l9_621=l9_620;
int l9_622=l9_618*1399;
int l9_623=((l9_622*((l9_622*1471343)+101146501))+1559861749)&2147483647;
int l9_624=l9_623;
int l9_625=l9_621;
float l9_626=float(l9_625)*4.6566129e-10;
int l9_627=l9_624;
float l9_628=float(l9_627)*4.6566129e-10;
float2 l9_629=float2(l9_626,l9_628);
l9_604=float4(l9_629.x,l9_629.y,l9_604.z,l9_604.w);
}
else
{
if (l9_596==3)
{
int l9_630=l9_611;
int l9_631=l9_630;
int l9_632=((l9_631*((l9_631*1471343)+101146501))+1559861749)&2147483647;
int l9_633=l9_632;
int l9_634=l9_630*1399;
int l9_635=((l9_634*((l9_634*1471343)+101146501))+1559861749)&2147483647;
int l9_636=l9_635;
int l9_637=l9_630*7177;
int l9_638=((l9_637*((l9_637*1471343)+101146501))+1559861749)&2147483647;
int l9_639=l9_638;
int l9_640=l9_633;
float l9_641=float(l9_640)*4.6566129e-10;
int l9_642=l9_636;
float l9_643=float(l9_642)*4.6566129e-10;
int l9_644=l9_639;
float l9_645=float(l9_644)*4.6566129e-10;
float3 l9_646=float3(l9_641,l9_643,l9_645);
l9_604=float4(l9_646.x,l9_646.y,l9_646.z,l9_604.w);
}
else
{
int l9_647=l9_611;
int l9_648=l9_647;
int l9_649=((l9_648*((l9_648*1471343)+101146501))+1559861749)&2147483647;
int l9_650=l9_649;
int l9_651=l9_647*1399;
int l9_652=((l9_651*((l9_651*1471343)+101146501))+1559861749)&2147483647;
int l9_653=l9_652;
int l9_654=l9_647*7177;
int l9_655=((l9_654*((l9_654*1471343)+101146501))+1559861749)&2147483647;
int l9_656=l9_655;
int l9_657=l9_647*18919;
int l9_658=((l9_657*((l9_657*1471343)+101146501))+1559861749)&2147483647;
int l9_659=l9_658;
int l9_660=l9_650;
float l9_661=float(l9_660)*4.6566129e-10;
int l9_662=l9_653;
float l9_663=float(l9_662)*4.6566129e-10;
int l9_664=l9_656;
float l9_665=float(l9_664)*4.6566129e-10;
int l9_666=l9_659;
float l9_667=float(l9_666)*4.6566129e-10;
float4 l9_668=float4(l9_661,l9_663,l9_665,l9_667);
l9_604=l9_668;
}
}
}
float4 l9_669=l9_604;
float4 l9_670=l9_669;
float3 l9_671=mix(l9_593,l9_594,l9_670.xyz);
l9_592=l9_671;
float l9_672=0.0;
l9_672=length(l9_592);
float3 l9_673=float3(0.0);
l9_673=l9_592/(float3(l9_672)+float3(1.234e-06));
float l9_674=0.0;
l9_674=fast::clamp((*sc_set0.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_675=0.0;
l9_675=1.0-l9_674;
float l9_676=0.0;
float l9_677;
if (l9_675<=0.0)
{
l9_677=0.0;
}
else
{
l9_677=pow(l9_675,(*sc_set0.UserUniforms).Port_Input1_N153);
}
l9_676=l9_677;
float3 l9_678=float3(0.0);
float3 l9_679=float3(l9_676);
float3 l9_680=(*sc_set0.UserUniforms).Port_Max_N154;
ssGlobals l9_681=l9_403;
int l9_682=3;
bool l9_683=true;
bool l9_684=true;
bool l9_685=true;
float l9_686=154.0;
ssParticle l9_687=gParticle;
float l9_688=0.0;
float l9_689=l9_681.gTimeElapsed;
float4 l9_690=float4(0.0);
float4 l9_691=float4(0.0);
if (l9_683)
{
l9_691.x=floor(fract(l9_689)*1000.0);
}
if (l9_685)
{
l9_691.y=float(l9_687.Index1D^((l9_687.Index1D*15299)+l9_687.Index1D));
}
if (l9_684)
{
l9_691.z=l9_686;
}
l9_691.w=l9_688*1000.0;
int l9_692=int(l9_691.x);
int l9_693=int(l9_691.y);
int l9_694=int(l9_691.z);
int l9_695=int(l9_691.w);
int l9_696=(((l9_692*15299)^(l9_693*30133))^(l9_694*17539))^(l9_695*12113);
int l9_697=l9_696;
if (l9_682==1)
{
int l9_698=l9_697;
int l9_699=l9_698;
int l9_700=((l9_699*((l9_699*1471343)+101146501))+1559861749)&2147483647;
int l9_701=l9_700;
float l9_702=float(l9_701)*4.6566129e-10;
float l9_703=l9_702;
l9_690.x=l9_703;
}
else
{
if (l9_682==2)
{
int l9_704=l9_697;
int l9_705=l9_704;
int l9_706=((l9_705*((l9_705*1471343)+101146501))+1559861749)&2147483647;
int l9_707=l9_706;
int l9_708=l9_704*1399;
int l9_709=((l9_708*((l9_708*1471343)+101146501))+1559861749)&2147483647;
int l9_710=l9_709;
int l9_711=l9_707;
float l9_712=float(l9_711)*4.6566129e-10;
int l9_713=l9_710;
float l9_714=float(l9_713)*4.6566129e-10;
float2 l9_715=float2(l9_712,l9_714);
l9_690=float4(l9_715.x,l9_715.y,l9_690.z,l9_690.w);
}
else
{
if (l9_682==3)
{
int l9_716=l9_697;
int l9_717=l9_716;
int l9_718=((l9_717*((l9_717*1471343)+101146501))+1559861749)&2147483647;
int l9_719=l9_718;
int l9_720=l9_716*1399;
int l9_721=((l9_720*((l9_720*1471343)+101146501))+1559861749)&2147483647;
int l9_722=l9_721;
int l9_723=l9_716*7177;
int l9_724=((l9_723*((l9_723*1471343)+101146501))+1559861749)&2147483647;
int l9_725=l9_724;
int l9_726=l9_719;
float l9_727=float(l9_726)*4.6566129e-10;
int l9_728=l9_722;
float l9_729=float(l9_728)*4.6566129e-10;
int l9_730=l9_725;
float l9_731=float(l9_730)*4.6566129e-10;
float3 l9_732=float3(l9_727,l9_729,l9_731);
l9_690=float4(l9_732.x,l9_732.y,l9_732.z,l9_690.w);
}
else
{
int l9_733=l9_697;
int l9_734=l9_733;
int l9_735=((l9_734*((l9_734*1471343)+101146501))+1559861749)&2147483647;
int l9_736=l9_735;
int l9_737=l9_733*1399;
int l9_738=((l9_737*((l9_737*1471343)+101146501))+1559861749)&2147483647;
int l9_739=l9_738;
int l9_740=l9_733*7177;
int l9_741=((l9_740*((l9_740*1471343)+101146501))+1559861749)&2147483647;
int l9_742=l9_741;
int l9_743=l9_733*18919;
int l9_744=((l9_743*((l9_743*1471343)+101146501))+1559861749)&2147483647;
int l9_745=l9_744;
int l9_746=l9_736;
float l9_747=float(l9_746)*4.6566129e-10;
int l9_748=l9_739;
float l9_749=float(l9_748)*4.6566129e-10;
int l9_750=l9_742;
float l9_751=float(l9_750)*4.6566129e-10;
int l9_752=l9_745;
float l9_753=float(l9_752)*4.6566129e-10;
float4 l9_754=float4(l9_747,l9_749,l9_751,l9_753);
l9_690=l9_754;
}
}
}
float4 l9_755=l9_690;
float4 l9_756=l9_755;
float3 l9_757=mix(l9_679,l9_680,l9_756.xyz);
l9_678=l9_757;
float3 l9_758=float3(0.0);
float l9_759;
if (l9_678.x<=0.0)
{
l9_759=0.0;
}
else
{
l9_759=sqrt(l9_678.x);
}
float l9_760=l9_759;
float l9_761;
if (l9_678.y<=0.0)
{
l9_761=0.0;
}
else
{
l9_761=sqrt(l9_678.y);
}
float l9_762=l9_761;
float l9_763;
if (l9_678.z<=0.0)
{
l9_763=0.0;
}
else
{
l9_763=sqrt(l9_678.z);
}
l9_758=float3(l9_760,l9_762,l9_763);
float3 l9_764=float3(0.0);
float l9_765;
if (l9_758.x<=0.0)
{
l9_765=0.0;
}
else
{
l9_765=sqrt(l9_758.x);
}
float l9_766=l9_765;
float l9_767;
if (l9_758.y<=0.0)
{
l9_767=0.0;
}
else
{
l9_767=sqrt(l9_758.y);
}
float l9_768=l9_767;
float l9_769;
if (l9_758.z<=0.0)
{
l9_769=0.0;
}
else
{
l9_769=sqrt(l9_758.z);
}
l9_764=float3(l9_766,l9_768,l9_769);
float l9_770=0.0;
l9_770=(*sc_set0.UserUniforms).Port_Import_N157;
float3 l9_771=float3(0.0);
l9_771=(*sc_set0.UserUniforms).Port_Import_N158;
float3 l9_772=float3(0.0);
l9_772=((l9_673*l9_764)*float3(l9_770))*l9_771;
float l9_773=0.0;
float3 l9_774=l9_772;
float l9_775=l9_774.y;
l9_773=l9_775;
l9_402=l9_773;
l9_406=l9_402;
}
l9_399=l9_406;
float l9_776=0.0;
float l9_777=0.0;
float l9_778=0.0;
float l9_779=0.0;
ssGlobals l9_780=param_1;
float l9_781=0.0;
l9_781=0.0;
float l9_782=0.0;
l9_782=float(l9_781==(*sc_set0.UserUniforms).Port_Input1_N165);
l9_777=l9_782;
float l9_783;
if ((l9_777*1.0)!=0.0)
{
float3 l9_784=float3(0.0);
float3 l9_785=(*sc_set0.UserUniforms).Port_Min_N150;
float3 l9_786=(*sc_set0.UserUniforms).Port_Max_N150;
ssGlobals l9_787=l9_780;
int l9_788=3;
bool l9_789=true;
bool l9_790=true;
bool l9_791=true;
float l9_792=150.0;
ssParticle l9_793=gParticle;
float l9_794=0.0;
float l9_795=l9_787.gTimeElapsed;
float4 l9_796=float4(0.0);
float4 l9_797=float4(0.0);
if (l9_789)
{
l9_797.x=floor(fract(l9_795)*1000.0);
}
if (l9_791)
{
l9_797.y=float(l9_793.Index1D^((l9_793.Index1D*15299)+l9_793.Index1D));
}
if (l9_790)
{
l9_797.z=l9_792;
}
l9_797.w=l9_794*1000.0;
int l9_798=int(l9_797.x);
int l9_799=int(l9_797.y);
int l9_800=int(l9_797.z);
int l9_801=int(l9_797.w);
int l9_802=(((l9_798*15299)^(l9_799*30133))^(l9_800*17539))^(l9_801*12113);
int l9_803=l9_802;
if (l9_788==1)
{
int l9_804=l9_803;
int l9_805=l9_804;
int l9_806=((l9_805*((l9_805*1471343)+101146501))+1559861749)&2147483647;
int l9_807=l9_806;
float l9_808=float(l9_807)*4.6566129e-10;
float l9_809=l9_808;
l9_796.x=l9_809;
}
else
{
if (l9_788==2)
{
int l9_810=l9_803;
int l9_811=l9_810;
int l9_812=((l9_811*((l9_811*1471343)+101146501))+1559861749)&2147483647;
int l9_813=l9_812;
int l9_814=l9_810*1399;
int l9_815=((l9_814*((l9_814*1471343)+101146501))+1559861749)&2147483647;
int l9_816=l9_815;
int l9_817=l9_813;
float l9_818=float(l9_817)*4.6566129e-10;
int l9_819=l9_816;
float l9_820=float(l9_819)*4.6566129e-10;
float2 l9_821=float2(l9_818,l9_820);
l9_796=float4(l9_821.x,l9_821.y,l9_796.z,l9_796.w);
}
else
{
if (l9_788==3)
{
int l9_822=l9_803;
int l9_823=l9_822;
int l9_824=((l9_823*((l9_823*1471343)+101146501))+1559861749)&2147483647;
int l9_825=l9_824;
int l9_826=l9_822*1399;
int l9_827=((l9_826*((l9_826*1471343)+101146501))+1559861749)&2147483647;
int l9_828=l9_827;
int l9_829=l9_822*7177;
int l9_830=((l9_829*((l9_829*1471343)+101146501))+1559861749)&2147483647;
int l9_831=l9_830;
int l9_832=l9_825;
float l9_833=float(l9_832)*4.6566129e-10;
int l9_834=l9_828;
float l9_835=float(l9_834)*4.6566129e-10;
int l9_836=l9_831;
float l9_837=float(l9_836)*4.6566129e-10;
float3 l9_838=float3(l9_833,l9_835,l9_837);
l9_796=float4(l9_838.x,l9_838.y,l9_838.z,l9_796.w);
}
else
{
int l9_839=l9_803;
int l9_840=l9_839;
int l9_841=((l9_840*((l9_840*1471343)+101146501))+1559861749)&2147483647;
int l9_842=l9_841;
int l9_843=l9_839*1399;
int l9_844=((l9_843*((l9_843*1471343)+101146501))+1559861749)&2147483647;
int l9_845=l9_844;
int l9_846=l9_839*7177;
int l9_847=((l9_846*((l9_846*1471343)+101146501))+1559861749)&2147483647;
int l9_848=l9_847;
int l9_849=l9_839*18919;
int l9_850=((l9_849*((l9_849*1471343)+101146501))+1559861749)&2147483647;
int l9_851=l9_850;
int l9_852=l9_842;
float l9_853=float(l9_852)*4.6566129e-10;
int l9_854=l9_845;
float l9_855=float(l9_854)*4.6566129e-10;
int l9_856=l9_848;
float l9_857=float(l9_856)*4.6566129e-10;
int l9_858=l9_851;
float l9_859=float(l9_858)*4.6566129e-10;
float4 l9_860=float4(l9_853,l9_855,l9_857,l9_859);
l9_796=l9_860;
}
}
}
float4 l9_861=l9_796;
float4 l9_862=l9_861;
float3 l9_863=mix(l9_785,l9_786,l9_862.xyz);
l9_784=l9_863;
float l9_864=0.0;
l9_864=length(l9_784);
float3 l9_865=float3(0.0);
l9_865=l9_784/(float3(l9_864)+float3(1.234e-06));
float l9_866=0.0;
l9_866=fast::clamp((*sc_set0.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_867=0.0;
l9_867=1.0-l9_866;
float l9_868=0.0;
float l9_869;
if (l9_867<=0.0)
{
l9_869=0.0;
}
else
{
l9_869=pow(l9_867,(*sc_set0.UserUniforms).Port_Input1_N153);
}
l9_868=l9_869;
float3 l9_870=float3(0.0);
float3 l9_871=float3(l9_868);
float3 l9_872=(*sc_set0.UserUniforms).Port_Max_N154;
ssGlobals l9_873=l9_780;
int l9_874=3;
bool l9_875=true;
bool l9_876=true;
bool l9_877=true;
float l9_878=154.0;
ssParticle l9_879=gParticle;
float l9_880=0.0;
float l9_881=l9_873.gTimeElapsed;
float4 l9_882=float4(0.0);
float4 l9_883=float4(0.0);
if (l9_875)
{
l9_883.x=floor(fract(l9_881)*1000.0);
}
if (l9_877)
{
l9_883.y=float(l9_879.Index1D^((l9_879.Index1D*15299)+l9_879.Index1D));
}
if (l9_876)
{
l9_883.z=l9_878;
}
l9_883.w=l9_880*1000.0;
int l9_884=int(l9_883.x);
int l9_885=int(l9_883.y);
int l9_886=int(l9_883.z);
int l9_887=int(l9_883.w);
int l9_888=(((l9_884*15299)^(l9_885*30133))^(l9_886*17539))^(l9_887*12113);
int l9_889=l9_888;
if (l9_874==1)
{
int l9_890=l9_889;
int l9_891=l9_890;
int l9_892=((l9_891*((l9_891*1471343)+101146501))+1559861749)&2147483647;
int l9_893=l9_892;
float l9_894=float(l9_893)*4.6566129e-10;
float l9_895=l9_894;
l9_882.x=l9_895;
}
else
{
if (l9_874==2)
{
int l9_896=l9_889;
int l9_897=l9_896;
int l9_898=((l9_897*((l9_897*1471343)+101146501))+1559861749)&2147483647;
int l9_899=l9_898;
int l9_900=l9_896*1399;
int l9_901=((l9_900*((l9_900*1471343)+101146501))+1559861749)&2147483647;
int l9_902=l9_901;
int l9_903=l9_899;
float l9_904=float(l9_903)*4.6566129e-10;
int l9_905=l9_902;
float l9_906=float(l9_905)*4.6566129e-10;
float2 l9_907=float2(l9_904,l9_906);
l9_882=float4(l9_907.x,l9_907.y,l9_882.z,l9_882.w);
}
else
{
if (l9_874==3)
{
int l9_908=l9_889;
int l9_909=l9_908;
int l9_910=((l9_909*((l9_909*1471343)+101146501))+1559861749)&2147483647;
int l9_911=l9_910;
int l9_912=l9_908*1399;
int l9_913=((l9_912*((l9_912*1471343)+101146501))+1559861749)&2147483647;
int l9_914=l9_913;
int l9_915=l9_908*7177;
int l9_916=((l9_915*((l9_915*1471343)+101146501))+1559861749)&2147483647;
int l9_917=l9_916;
int l9_918=l9_911;
float l9_919=float(l9_918)*4.6566129e-10;
int l9_920=l9_914;
float l9_921=float(l9_920)*4.6566129e-10;
int l9_922=l9_917;
float l9_923=float(l9_922)*4.6566129e-10;
float3 l9_924=float3(l9_919,l9_921,l9_923);
l9_882=float4(l9_924.x,l9_924.y,l9_924.z,l9_882.w);
}
else
{
int l9_925=l9_889;
int l9_926=l9_925;
int l9_927=((l9_926*((l9_926*1471343)+101146501))+1559861749)&2147483647;
int l9_928=l9_927;
int l9_929=l9_925*1399;
int l9_930=((l9_929*((l9_929*1471343)+101146501))+1559861749)&2147483647;
int l9_931=l9_930;
int l9_932=l9_925*7177;
int l9_933=((l9_932*((l9_932*1471343)+101146501))+1559861749)&2147483647;
int l9_934=l9_933;
int l9_935=l9_925*18919;
int l9_936=((l9_935*((l9_935*1471343)+101146501))+1559861749)&2147483647;
int l9_937=l9_936;
int l9_938=l9_928;
float l9_939=float(l9_938)*4.6566129e-10;
int l9_940=l9_931;
float l9_941=float(l9_940)*4.6566129e-10;
int l9_942=l9_934;
float l9_943=float(l9_942)*4.6566129e-10;
int l9_944=l9_937;
float l9_945=float(l9_944)*4.6566129e-10;
float4 l9_946=float4(l9_939,l9_941,l9_943,l9_945);
l9_882=l9_946;
}
}
}
float4 l9_947=l9_882;
float4 l9_948=l9_947;
float3 l9_949=mix(l9_871,l9_872,l9_948.xyz);
l9_870=l9_949;
float3 l9_950=float3(0.0);
float l9_951;
if (l9_870.x<=0.0)
{
l9_951=0.0;
}
else
{
l9_951=sqrt(l9_870.x);
}
float l9_952=l9_951;
float l9_953;
if (l9_870.y<=0.0)
{
l9_953=0.0;
}
else
{
l9_953=sqrt(l9_870.y);
}
float l9_954=l9_953;
float l9_955;
if (l9_870.z<=0.0)
{
l9_955=0.0;
}
else
{
l9_955=sqrt(l9_870.z);
}
l9_950=float3(l9_952,l9_954,l9_955);
float3 l9_956=float3(0.0);
float l9_957;
if (l9_950.x<=0.0)
{
l9_957=0.0;
}
else
{
l9_957=sqrt(l9_950.x);
}
float l9_958=l9_957;
float l9_959;
if (l9_950.y<=0.0)
{
l9_959=0.0;
}
else
{
l9_959=sqrt(l9_950.y);
}
float l9_960=l9_959;
float l9_961;
if (l9_950.z<=0.0)
{
l9_961=0.0;
}
else
{
l9_961=sqrt(l9_950.z);
}
l9_956=float3(l9_958,l9_960,l9_961);
float l9_962=0.0;
l9_962=(*sc_set0.UserUniforms).Port_Import_N157;
float3 l9_963=float3(0.0);
l9_963=(*sc_set0.UserUniforms).Port_Import_N158;
float3 l9_964=float3(0.0);
l9_964=((l9_865*l9_956)*float3(l9_962))*l9_963;
float l9_965=0.0;
float3 l9_966=l9_964;
float l9_967=l9_966.z;
l9_965=l9_967;
float l9_968=0.0;
l9_968=abs(l9_965);
l9_778=l9_968;
l9_783=l9_778;
}
else
{
float3 l9_969=float3(0.0);
float3 l9_970=(*sc_set0.UserUniforms).Port_Min_N150;
float3 l9_971=(*sc_set0.UserUniforms).Port_Max_N150;
ssGlobals l9_972=l9_780;
int l9_973=3;
bool l9_974=true;
bool l9_975=true;
bool l9_976=true;
float l9_977=150.0;
ssParticle l9_978=gParticle;
float l9_979=0.0;
float l9_980=l9_972.gTimeElapsed;
float4 l9_981=float4(0.0);
float4 l9_982=float4(0.0);
if (l9_974)
{
l9_982.x=floor(fract(l9_980)*1000.0);
}
if (l9_976)
{
l9_982.y=float(l9_978.Index1D^((l9_978.Index1D*15299)+l9_978.Index1D));
}
if (l9_975)
{
l9_982.z=l9_977;
}
l9_982.w=l9_979*1000.0;
int l9_983=int(l9_982.x);
int l9_984=int(l9_982.y);
int l9_985=int(l9_982.z);
int l9_986=int(l9_982.w);
int l9_987=(((l9_983*15299)^(l9_984*30133))^(l9_985*17539))^(l9_986*12113);
int l9_988=l9_987;
if (l9_973==1)
{
int l9_989=l9_988;
int l9_990=l9_989;
int l9_991=((l9_990*((l9_990*1471343)+101146501))+1559861749)&2147483647;
int l9_992=l9_991;
float l9_993=float(l9_992)*4.6566129e-10;
float l9_994=l9_993;
l9_981.x=l9_994;
}
else
{
if (l9_973==2)
{
int l9_995=l9_988;
int l9_996=l9_995;
int l9_997=((l9_996*((l9_996*1471343)+101146501))+1559861749)&2147483647;
int l9_998=l9_997;
int l9_999=l9_995*1399;
int l9_1000=((l9_999*((l9_999*1471343)+101146501))+1559861749)&2147483647;
int l9_1001=l9_1000;
int l9_1002=l9_998;
float l9_1003=float(l9_1002)*4.6566129e-10;
int l9_1004=l9_1001;
float l9_1005=float(l9_1004)*4.6566129e-10;
float2 l9_1006=float2(l9_1003,l9_1005);
l9_981=float4(l9_1006.x,l9_1006.y,l9_981.z,l9_981.w);
}
else
{
if (l9_973==3)
{
int l9_1007=l9_988;
int l9_1008=l9_1007;
int l9_1009=((l9_1008*((l9_1008*1471343)+101146501))+1559861749)&2147483647;
int l9_1010=l9_1009;
int l9_1011=l9_1007*1399;
int l9_1012=((l9_1011*((l9_1011*1471343)+101146501))+1559861749)&2147483647;
int l9_1013=l9_1012;
int l9_1014=l9_1007*7177;
int l9_1015=((l9_1014*((l9_1014*1471343)+101146501))+1559861749)&2147483647;
int l9_1016=l9_1015;
int l9_1017=l9_1010;
float l9_1018=float(l9_1017)*4.6566129e-10;
int l9_1019=l9_1013;
float l9_1020=float(l9_1019)*4.6566129e-10;
int l9_1021=l9_1016;
float l9_1022=float(l9_1021)*4.6566129e-10;
float3 l9_1023=float3(l9_1018,l9_1020,l9_1022);
l9_981=float4(l9_1023.x,l9_1023.y,l9_1023.z,l9_981.w);
}
else
{
int l9_1024=l9_988;
int l9_1025=l9_1024;
int l9_1026=((l9_1025*((l9_1025*1471343)+101146501))+1559861749)&2147483647;
int l9_1027=l9_1026;
int l9_1028=l9_1024*1399;
int l9_1029=((l9_1028*((l9_1028*1471343)+101146501))+1559861749)&2147483647;
int l9_1030=l9_1029;
int l9_1031=l9_1024*7177;
int l9_1032=((l9_1031*((l9_1031*1471343)+101146501))+1559861749)&2147483647;
int l9_1033=l9_1032;
int l9_1034=l9_1024*18919;
int l9_1035=((l9_1034*((l9_1034*1471343)+101146501))+1559861749)&2147483647;
int l9_1036=l9_1035;
int l9_1037=l9_1027;
float l9_1038=float(l9_1037)*4.6566129e-10;
int l9_1039=l9_1030;
float l9_1040=float(l9_1039)*4.6566129e-10;
int l9_1041=l9_1033;
float l9_1042=float(l9_1041)*4.6566129e-10;
int l9_1043=l9_1036;
float l9_1044=float(l9_1043)*4.6566129e-10;
float4 l9_1045=float4(l9_1038,l9_1040,l9_1042,l9_1044);
l9_981=l9_1045;
}
}
}
float4 l9_1046=l9_981;
float4 l9_1047=l9_1046;
float3 l9_1048=mix(l9_970,l9_971,l9_1047.xyz);
l9_969=l9_1048;
float l9_1049=0.0;
l9_1049=length(l9_969);
float3 l9_1050=float3(0.0);
l9_1050=l9_969/(float3(l9_1049)+float3(1.234e-06));
float l9_1051=0.0;
l9_1051=fast::clamp((*sc_set0.UserUniforms).Port_Import_N151,0.0,1.0);
float l9_1052=0.0;
l9_1052=1.0-l9_1051;
float l9_1053=0.0;
float l9_1054;
if (l9_1052<=0.0)
{
l9_1054=0.0;
}
else
{
l9_1054=pow(l9_1052,(*sc_set0.UserUniforms).Port_Input1_N153);
}
l9_1053=l9_1054;
float3 l9_1055=float3(0.0);
float3 l9_1056=float3(l9_1053);
float3 l9_1057=(*sc_set0.UserUniforms).Port_Max_N154;
ssGlobals l9_1058=l9_780;
int l9_1059=3;
bool l9_1060=true;
bool l9_1061=true;
bool l9_1062=true;
float l9_1063=154.0;
ssParticle l9_1064=gParticle;
float l9_1065=0.0;
float l9_1066=l9_1058.gTimeElapsed;
float4 l9_1067=float4(0.0);
float4 l9_1068=float4(0.0);
if (l9_1060)
{
l9_1068.x=floor(fract(l9_1066)*1000.0);
}
if (l9_1062)
{
l9_1068.y=float(l9_1064.Index1D^((l9_1064.Index1D*15299)+l9_1064.Index1D));
}
if (l9_1061)
{
l9_1068.z=l9_1063;
}
l9_1068.w=l9_1065*1000.0;
int l9_1069=int(l9_1068.x);
int l9_1070=int(l9_1068.y);
int l9_1071=int(l9_1068.z);
int l9_1072=int(l9_1068.w);
int l9_1073=(((l9_1069*15299)^(l9_1070*30133))^(l9_1071*17539))^(l9_1072*12113);
int l9_1074=l9_1073;
if (l9_1059==1)
{
int l9_1075=l9_1074;
int l9_1076=l9_1075;
int l9_1077=((l9_1076*((l9_1076*1471343)+101146501))+1559861749)&2147483647;
int l9_1078=l9_1077;
float l9_1079=float(l9_1078)*4.6566129e-10;
float l9_1080=l9_1079;
l9_1067.x=l9_1080;
}
else
{
if (l9_1059==2)
{
int l9_1081=l9_1074;
int l9_1082=l9_1081;
int l9_1083=((l9_1082*((l9_1082*1471343)+101146501))+1559861749)&2147483647;
int l9_1084=l9_1083;
int l9_1085=l9_1081*1399;
int l9_1086=((l9_1085*((l9_1085*1471343)+101146501))+1559861749)&2147483647;
int l9_1087=l9_1086;
int l9_1088=l9_1084;
float l9_1089=float(l9_1088)*4.6566129e-10;
int l9_1090=l9_1087;
float l9_1091=float(l9_1090)*4.6566129e-10;
float2 l9_1092=float2(l9_1089,l9_1091);
l9_1067=float4(l9_1092.x,l9_1092.y,l9_1067.z,l9_1067.w);
}
else
{
if (l9_1059==3)
{
int l9_1093=l9_1074;
int l9_1094=l9_1093;
int l9_1095=((l9_1094*((l9_1094*1471343)+101146501))+1559861749)&2147483647;
int l9_1096=l9_1095;
int l9_1097=l9_1093*1399;
int l9_1098=((l9_1097*((l9_1097*1471343)+101146501))+1559861749)&2147483647;
int l9_1099=l9_1098;
int l9_1100=l9_1093*7177;
int l9_1101=((l9_1100*((l9_1100*1471343)+101146501))+1559861749)&2147483647;
int l9_1102=l9_1101;
int l9_1103=l9_1096;
float l9_1104=float(l9_1103)*4.6566129e-10;
int l9_1105=l9_1099;
float l9_1106=float(l9_1105)*4.6566129e-10;
int l9_1107=l9_1102;
float l9_1108=float(l9_1107)*4.6566129e-10;
float3 l9_1109=float3(l9_1104,l9_1106,l9_1108);
l9_1067=float4(l9_1109.x,l9_1109.y,l9_1109.z,l9_1067.w);
}
else
{
int l9_1110=l9_1074;
int l9_1111=l9_1110;
int l9_1112=((l9_1111*((l9_1111*1471343)+101146501))+1559861749)&2147483647;
int l9_1113=l9_1112;
int l9_1114=l9_1110*1399;
int l9_1115=((l9_1114*((l9_1114*1471343)+101146501))+1559861749)&2147483647;
int l9_1116=l9_1115;
int l9_1117=l9_1110*7177;
int l9_1118=((l9_1117*((l9_1117*1471343)+101146501))+1559861749)&2147483647;
int l9_1119=l9_1118;
int l9_1120=l9_1110*18919;
int l9_1121=((l9_1120*((l9_1120*1471343)+101146501))+1559861749)&2147483647;
int l9_1122=l9_1121;
int l9_1123=l9_1113;
float l9_1124=float(l9_1123)*4.6566129e-10;
int l9_1125=l9_1116;
float l9_1126=float(l9_1125)*4.6566129e-10;
int l9_1127=l9_1119;
float l9_1128=float(l9_1127)*4.6566129e-10;
int l9_1129=l9_1122;
float l9_1130=float(l9_1129)*4.6566129e-10;
float4 l9_1131=float4(l9_1124,l9_1126,l9_1128,l9_1130);
l9_1067=l9_1131;
}
}
}
float4 l9_1132=l9_1067;
float4 l9_1133=l9_1132;
float3 l9_1134=mix(l9_1056,l9_1057,l9_1133.xyz);
l9_1055=l9_1134;
float3 l9_1135=float3(0.0);
float l9_1136;
if (l9_1055.x<=0.0)
{
l9_1136=0.0;
}
else
{
l9_1136=sqrt(l9_1055.x);
}
float l9_1137=l9_1136;
float l9_1138;
if (l9_1055.y<=0.0)
{
l9_1138=0.0;
}
else
{
l9_1138=sqrt(l9_1055.y);
}
float l9_1139=l9_1138;
float l9_1140;
if (l9_1055.z<=0.0)
{
l9_1140=0.0;
}
else
{
l9_1140=sqrt(l9_1055.z);
}
l9_1135=float3(l9_1137,l9_1139,l9_1140);
float3 l9_1141=float3(0.0);
float l9_1142;
if (l9_1135.x<=0.0)
{
l9_1142=0.0;
}
else
{
l9_1142=sqrt(l9_1135.x);
}
float l9_1143=l9_1142;
float l9_1144;
if (l9_1135.y<=0.0)
{
l9_1144=0.0;
}
else
{
l9_1144=sqrt(l9_1135.y);
}
float l9_1145=l9_1144;
float l9_1146;
if (l9_1135.z<=0.0)
{
l9_1146=0.0;
}
else
{
l9_1146=sqrt(l9_1135.z);
}
l9_1141=float3(l9_1143,l9_1145,l9_1146);
float l9_1147=0.0;
l9_1147=(*sc_set0.UserUniforms).Port_Import_N157;
float3 l9_1148=float3(0.0);
l9_1148=(*sc_set0.UserUniforms).Port_Import_N158;
float3 l9_1149=float3(0.0);
l9_1149=((l9_1050*l9_1141)*float3(l9_1147))*l9_1148;
float l9_1150=0.0;
float3 l9_1151=l9_1149;
float l9_1152=l9_1151.z;
l9_1150=l9_1152;
l9_779=l9_1150;
l9_783=l9_779;
}
l9_776=l9_783;
float3 l9_1153=float3(0.0);
l9_1153.x=l9_22;
l9_1153.y=l9_399;
l9_1153.z=l9_776;
float3 l9_1154=float3(0.0);
l9_1154=l9_21+l9_1153;
gParticle.Position=l9_1154;
float l9_1155=0.0;
float l9_1156=1.0;
float l9_1157=1.0;
float l9_1158=0.0;
ssGlobals l9_1159=param_1;
float l9_1160=0.0;
l9_1160=1.0;
l9_1156=l9_1160;
float l9_1161;
if ((l9_1156*1.0)!=0.0)
{
float l9_1162=0.0;
l9_1162=(*sc_set0.UserUniforms).Port_Import_N042;
float l9_1163=0.0;
l9_1163=(*sc_set0.UserUniforms).Port_Import_N043;
float l9_1164=0.0;
float l9_1165=l9_1162;
float l9_1166=l9_1163;
ssGlobals l9_1167=l9_1159;
int l9_1168=1;
bool l9_1169=false;
bool l9_1170=true;
bool l9_1171=true;
float l9_1172=44.0;
ssParticle l9_1173=gParticle;
float l9_1174=0.0;
float l9_1175=l9_1167.gTimeElapsed;
float4 l9_1176=float4(0.0);
float4 l9_1177=float4(0.0);
if (l9_1169)
{
l9_1177.x=floor(fract(l9_1175)*1000.0);
}
if (l9_1171)
{
l9_1177.y=float(l9_1173.Index1D^((l9_1173.Index1D*15299)+l9_1173.Index1D));
}
if (l9_1170)
{
l9_1177.z=l9_1172;
}
l9_1177.w=l9_1174*1000.0;
int l9_1178=int(l9_1177.x);
int l9_1179=int(l9_1177.y);
int l9_1180=int(l9_1177.z);
int l9_1181=int(l9_1177.w);
int l9_1182=(((l9_1178*15299)^(l9_1179*30133))^(l9_1180*17539))^(l9_1181*12113);
int l9_1183=l9_1182;
if (l9_1168==1)
{
int l9_1184=l9_1183;
int l9_1185=l9_1184;
int l9_1186=((l9_1185*((l9_1185*1471343)+101146501))+1559861749)&2147483647;
int l9_1187=l9_1186;
float l9_1188=float(l9_1187)*4.6566129e-10;
float l9_1189=l9_1188;
l9_1176.x=l9_1189;
}
else
{
if (l9_1168==2)
{
int l9_1190=l9_1183;
int l9_1191=l9_1190;
int l9_1192=((l9_1191*((l9_1191*1471343)+101146501))+1559861749)&2147483647;
int l9_1193=l9_1192;
int l9_1194=l9_1190*1399;
int l9_1195=((l9_1194*((l9_1194*1471343)+101146501))+1559861749)&2147483647;
int l9_1196=l9_1195;
int l9_1197=l9_1193;
float l9_1198=float(l9_1197)*4.6566129e-10;
int l9_1199=l9_1196;
float l9_1200=float(l9_1199)*4.6566129e-10;
float2 l9_1201=float2(l9_1198,l9_1200);
l9_1176=float4(l9_1201.x,l9_1201.y,l9_1176.z,l9_1176.w);
}
else
{
if (l9_1168==3)
{
int l9_1202=l9_1183;
int l9_1203=l9_1202;
int l9_1204=((l9_1203*((l9_1203*1471343)+101146501))+1559861749)&2147483647;
int l9_1205=l9_1204;
int l9_1206=l9_1202*1399;
int l9_1207=((l9_1206*((l9_1206*1471343)+101146501))+1559861749)&2147483647;
int l9_1208=l9_1207;
int l9_1209=l9_1202*7177;
int l9_1210=((l9_1209*((l9_1209*1471343)+101146501))+1559861749)&2147483647;
int l9_1211=l9_1210;
int l9_1212=l9_1205;
float l9_1213=float(l9_1212)*4.6566129e-10;
int l9_1214=l9_1208;
float l9_1215=float(l9_1214)*4.6566129e-10;
int l9_1216=l9_1211;
float l9_1217=float(l9_1216)*4.6566129e-10;
float3 l9_1218=float3(l9_1213,l9_1215,l9_1217);
l9_1176=float4(l9_1218.x,l9_1218.y,l9_1218.z,l9_1176.w);
}
else
{
int l9_1219=l9_1183;
int l9_1220=l9_1219;
int l9_1221=((l9_1220*((l9_1220*1471343)+101146501))+1559861749)&2147483647;
int l9_1222=l9_1221;
int l9_1223=l9_1219*1399;
int l9_1224=((l9_1223*((l9_1223*1471343)+101146501))+1559861749)&2147483647;
int l9_1225=l9_1224;
int l9_1226=l9_1219*7177;
int l9_1227=((l9_1226*((l9_1226*1471343)+101146501))+1559861749)&2147483647;
int l9_1228=l9_1227;
int l9_1229=l9_1219*18919;
int l9_1230=((l9_1229*((l9_1229*1471343)+101146501))+1559861749)&2147483647;
int l9_1231=l9_1230;
int l9_1232=l9_1222;
float l9_1233=float(l9_1232)*4.6566129e-10;
int l9_1234=l9_1225;
float l9_1235=float(l9_1234)*4.6566129e-10;
int l9_1236=l9_1228;
float l9_1237=float(l9_1236)*4.6566129e-10;
int l9_1238=l9_1231;
float l9_1239=float(l9_1238)*4.6566129e-10;
float4 l9_1240=float4(l9_1233,l9_1235,l9_1237,l9_1239);
l9_1176=l9_1240;
}
}
}
float4 l9_1241=l9_1176;
float4 l9_1242=l9_1241;
float l9_1243=mix(l9_1165,l9_1166,l9_1242.x);
l9_1164=l9_1243;
float3 l9_1244=float3(0.0);
l9_1244=(*sc_set0.UserUniforms).vfxLocalAabbMax;
float3 l9_1245=float3(0.0);
l9_1245=(*sc_set0.UserUniforms).vfxLocalAabbMin;
float3 l9_1246=float3(0.0);
l9_1246=l9_1244-l9_1245;
float l9_1247=0.0;
l9_1247=length(l9_1246);
float l9_1248=0.0;
l9_1248=l9_1164/(l9_1247+1.234e-06);
l9_1157=l9_1248;
l9_1161=l9_1157;
}
else
{
float l9_1249=0.0;
l9_1249=(*sc_set0.UserUniforms).Port_Import_N042;
float l9_1250=0.0;
l9_1250=(*sc_set0.UserUniforms).Port_Import_N043;
float l9_1251=0.0;
float l9_1252=l9_1249;
float l9_1253=l9_1250;
ssGlobals l9_1254=l9_1159;
int l9_1255=1;
bool l9_1256=false;
bool l9_1257=true;
bool l9_1258=true;
float l9_1259=44.0;
ssParticle l9_1260=gParticle;
float l9_1261=0.0;
float l9_1262=l9_1254.gTimeElapsed;
float4 l9_1263=float4(0.0);
float4 l9_1264=float4(0.0);
if (l9_1256)
{
l9_1264.x=floor(fract(l9_1262)*1000.0);
}
if (l9_1258)
{
l9_1264.y=float(l9_1260.Index1D^((l9_1260.Index1D*15299)+l9_1260.Index1D));
}
if (l9_1257)
{
l9_1264.z=l9_1259;
}
l9_1264.w=l9_1261*1000.0;
int l9_1265=int(l9_1264.x);
int l9_1266=int(l9_1264.y);
int l9_1267=int(l9_1264.z);
int l9_1268=int(l9_1264.w);
int l9_1269=(((l9_1265*15299)^(l9_1266*30133))^(l9_1267*17539))^(l9_1268*12113);
int l9_1270=l9_1269;
if (l9_1255==1)
{
int l9_1271=l9_1270;
int l9_1272=l9_1271;
int l9_1273=((l9_1272*((l9_1272*1471343)+101146501))+1559861749)&2147483647;
int l9_1274=l9_1273;
float l9_1275=float(l9_1274)*4.6566129e-10;
float l9_1276=l9_1275;
l9_1263.x=l9_1276;
}
else
{
if (l9_1255==2)
{
int l9_1277=l9_1270;
int l9_1278=l9_1277;
int l9_1279=((l9_1278*((l9_1278*1471343)+101146501))+1559861749)&2147483647;
int l9_1280=l9_1279;
int l9_1281=l9_1277*1399;
int l9_1282=((l9_1281*((l9_1281*1471343)+101146501))+1559861749)&2147483647;
int l9_1283=l9_1282;
int l9_1284=l9_1280;
float l9_1285=float(l9_1284)*4.6566129e-10;
int l9_1286=l9_1283;
float l9_1287=float(l9_1286)*4.6566129e-10;
float2 l9_1288=float2(l9_1285,l9_1287);
l9_1263=float4(l9_1288.x,l9_1288.y,l9_1263.z,l9_1263.w);
}
else
{
if (l9_1255==3)
{
int l9_1289=l9_1270;
int l9_1290=l9_1289;
int l9_1291=((l9_1290*((l9_1290*1471343)+101146501))+1559861749)&2147483647;
int l9_1292=l9_1291;
int l9_1293=l9_1289*1399;
int l9_1294=((l9_1293*((l9_1293*1471343)+101146501))+1559861749)&2147483647;
int l9_1295=l9_1294;
int l9_1296=l9_1289*7177;
int l9_1297=((l9_1296*((l9_1296*1471343)+101146501))+1559861749)&2147483647;
int l9_1298=l9_1297;
int l9_1299=l9_1292;
float l9_1300=float(l9_1299)*4.6566129e-10;
int l9_1301=l9_1295;
float l9_1302=float(l9_1301)*4.6566129e-10;
int l9_1303=l9_1298;
float l9_1304=float(l9_1303)*4.6566129e-10;
float3 l9_1305=float3(l9_1300,l9_1302,l9_1304);
l9_1263=float4(l9_1305.x,l9_1305.y,l9_1305.z,l9_1263.w);
}
else
{
int l9_1306=l9_1270;
int l9_1307=l9_1306;
int l9_1308=((l9_1307*((l9_1307*1471343)+101146501))+1559861749)&2147483647;
int l9_1309=l9_1308;
int l9_1310=l9_1306*1399;
int l9_1311=((l9_1310*((l9_1310*1471343)+101146501))+1559861749)&2147483647;
int l9_1312=l9_1311;
int l9_1313=l9_1306*7177;
int l9_1314=((l9_1313*((l9_1313*1471343)+101146501))+1559861749)&2147483647;
int l9_1315=l9_1314;
int l9_1316=l9_1306*18919;
int l9_1317=((l9_1316*((l9_1316*1471343)+101146501))+1559861749)&2147483647;
int l9_1318=l9_1317;
int l9_1319=l9_1309;
float l9_1320=float(l9_1319)*4.6566129e-10;
int l9_1321=l9_1312;
float l9_1322=float(l9_1321)*4.6566129e-10;
int l9_1323=l9_1315;
float l9_1324=float(l9_1323)*4.6566129e-10;
int l9_1325=l9_1318;
float l9_1326=float(l9_1325)*4.6566129e-10;
float4 l9_1327=float4(l9_1320,l9_1322,l9_1324,l9_1326);
l9_1263=l9_1327;
}
}
}
float4 l9_1328=l9_1263;
float4 l9_1329=l9_1328;
float l9_1330=mix(l9_1252,l9_1253,l9_1329.x);
l9_1251=l9_1330;
l9_1158=l9_1251;
l9_1161=l9_1158;
}
l9_1155=l9_1161;
gParticle.Size=l9_1155;
float l9_1331=0.0;
l9_1331=(*sc_set0.UserUniforms).Port_Import_N023;
float l9_1332=0.0;
l9_1332=(*sc_set0.UserUniforms).Port_Import_N024;
float l9_1333=0.0;
float l9_1334=l9_1331;
float l9_1335=l9_1332;
ssGlobals l9_1336=param_1;
int l9_1337=1;
bool l9_1338=false;
bool l9_1339=true;
bool l9_1340=true;
float l9_1341=26.0;
ssParticle l9_1342=gParticle;
float l9_1343=0.0;
float l9_1344=l9_1336.gTimeElapsed;
float4 l9_1345=float4(0.0);
float4 l9_1346=float4(0.0);
if (l9_1338)
{
l9_1346.x=floor(fract(l9_1344)*1000.0);
}
if (l9_1340)
{
l9_1346.y=float(l9_1342.Index1D^((l9_1342.Index1D*15299)+l9_1342.Index1D));
}
if (l9_1339)
{
l9_1346.z=l9_1341;
}
l9_1346.w=l9_1343*1000.0;
int l9_1347=int(l9_1346.x);
int l9_1348=int(l9_1346.y);
int l9_1349=int(l9_1346.z);
int l9_1350=int(l9_1346.w);
int l9_1351=(((l9_1347*15299)^(l9_1348*30133))^(l9_1349*17539))^(l9_1350*12113);
int l9_1352=l9_1351;
if (l9_1337==1)
{
int l9_1353=l9_1352;
int l9_1354=l9_1353;
int l9_1355=((l9_1354*((l9_1354*1471343)+101146501))+1559861749)&2147483647;
int l9_1356=l9_1355;
float l9_1357=float(l9_1356)*4.6566129e-10;
float l9_1358=l9_1357;
l9_1345.x=l9_1358;
}
else
{
if (l9_1337==2)
{
int l9_1359=l9_1352;
int l9_1360=l9_1359;
int l9_1361=((l9_1360*((l9_1360*1471343)+101146501))+1559861749)&2147483647;
int l9_1362=l9_1361;
int l9_1363=l9_1359*1399;
int l9_1364=((l9_1363*((l9_1363*1471343)+101146501))+1559861749)&2147483647;
int l9_1365=l9_1364;
int l9_1366=l9_1362;
float l9_1367=float(l9_1366)*4.6566129e-10;
int l9_1368=l9_1365;
float l9_1369=float(l9_1368)*4.6566129e-10;
float2 l9_1370=float2(l9_1367,l9_1369);
l9_1345=float4(l9_1370.x,l9_1370.y,l9_1345.z,l9_1345.w);
}
else
{
if (l9_1337==3)
{
int l9_1371=l9_1352;
int l9_1372=l9_1371;
int l9_1373=((l9_1372*((l9_1372*1471343)+101146501))+1559861749)&2147483647;
int l9_1374=l9_1373;
int l9_1375=l9_1371*1399;
int l9_1376=((l9_1375*((l9_1375*1471343)+101146501))+1559861749)&2147483647;
int l9_1377=l9_1376;
int l9_1378=l9_1371*7177;
int l9_1379=((l9_1378*((l9_1378*1471343)+101146501))+1559861749)&2147483647;
int l9_1380=l9_1379;
int l9_1381=l9_1374;
float l9_1382=float(l9_1381)*4.6566129e-10;
int l9_1383=l9_1377;
float l9_1384=float(l9_1383)*4.6566129e-10;
int l9_1385=l9_1380;
float l9_1386=float(l9_1385)*4.6566129e-10;
float3 l9_1387=float3(l9_1382,l9_1384,l9_1386);
l9_1345=float4(l9_1387.x,l9_1387.y,l9_1387.z,l9_1345.w);
}
else
{
int l9_1388=l9_1352;
int l9_1389=l9_1388;
int l9_1390=((l9_1389*((l9_1389*1471343)+101146501))+1559861749)&2147483647;
int l9_1391=l9_1390;
int l9_1392=l9_1388*1399;
int l9_1393=((l9_1392*((l9_1392*1471343)+101146501))+1559861749)&2147483647;
int l9_1394=l9_1393;
int l9_1395=l9_1388*7177;
int l9_1396=((l9_1395*((l9_1395*1471343)+101146501))+1559861749)&2147483647;
int l9_1397=l9_1396;
int l9_1398=l9_1388*18919;
int l9_1399=((l9_1398*((l9_1398*1471343)+101146501))+1559861749)&2147483647;
int l9_1400=l9_1399;
int l9_1401=l9_1391;
float l9_1402=float(l9_1401)*4.6566129e-10;
int l9_1403=l9_1394;
float l9_1404=float(l9_1403)*4.6566129e-10;
int l9_1405=l9_1397;
float l9_1406=float(l9_1405)*4.6566129e-10;
int l9_1407=l9_1400;
float l9_1408=float(l9_1407)*4.6566129e-10;
float4 l9_1409=float4(l9_1402,l9_1404,l9_1406,l9_1408);
l9_1345=l9_1409;
}
}
}
float4 l9_1410=l9_1345;
float4 l9_1411=l9_1410;
float l9_1412=mix(l9_1334,l9_1335,l9_1411.x);
l9_1333=l9_1412;
float l9_1413=l9_1333;
gParticle.Mass=l9_1413;
gParticle.Mass=fast::max(9.9999997e-06,gParticle.Mass);
float l9_1414=0.0;
l9_1414=(*sc_set0.UserUniforms).Port_Import_N053;
float3 l9_1415=float3(0.0);
l9_1415=(*sc_set0.UserUniforms).Port_Import_N054;
float3 l9_1416=float3(0.0);
l9_1416=gParticle.Position;
float3 l9_1417=float3(0.0);
l9_1417=l9_1415-l9_1416;
float3 l9_1418=float3(0.0);
float3 l9_1419=l9_1417;
float l9_1420=dot(l9_1419,l9_1419);
float l9_1421;
if (l9_1420>0.0)
{
l9_1421=1.0/sqrt(l9_1420);
}
else
{
l9_1421=0.0;
}
float l9_1422=l9_1421;
float3 l9_1423=l9_1419*l9_1422;
l9_1418=l9_1423;
float3 l9_1424=float3(0.0);
l9_1424=float3(l9_1414)*l9_1418;
gParticle.Force+=l9_1424;
float3 l9_1425=float3(0.0);
l9_1425=(*sc_set0.UserUniforms).Port_Import_N187;
float3 l9_1426=float3(0.0);
float3 l9_1427=l9_1425;
float l9_1428=dot(l9_1427,l9_1427);
float l9_1429;
if (l9_1428>0.0)
{
l9_1429=1.0/sqrt(l9_1428);
}
else
{
l9_1429=0.0;
}
float l9_1430=l9_1429;
float3 l9_1431=l9_1427*l9_1430;
l9_1426=l9_1431;
float l9_1432=0.0;
float l9_1433=(*sc_set0.UserUniforms).particles_speed;
l9_1432=l9_1433;
float l9_1434=0.0;
l9_1434=l9_1432;
float3 l9_1435=float3(0.0);
l9_1435=l9_1426*float3(l9_1434);
gParticle.Force+=l9_1435;
float l9_1436=0.0;
l9_1436=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float l9_1437=0.0;
float l9_1438=(*sc_set0.UserUniforms).particlesReduce;
l9_1437=l9_1438;
float l9_1439=0.0;
l9_1439=1.0-l9_1437;
float l9_1440=0.0;
l9_1440=float(l9_1436>l9_1439);
float l9_1441=l9_1440;
if ((l9_1441*1.0)!=0.0)
{
gParticle.Dead=true;
}
gParticle.Velocity+=((gParticle.Force/float3(gParticle.Mass))*0.033330001);
gParticle.Force=float3(0.0);
int l9_1442=gl_InstanceIndex;
gParticle.Position=((*sc_set0.UserUniforms).vfxModelMatrix[l9_1442/40]*float4(gParticle.Position,1.0)).xyz;
int l9_1443=gl_InstanceIndex;
int l9_1444=l9_1443/40;
gParticle.Velocity=float3x3((*sc_set0.UserUniforms).vfxModelMatrix[l9_1444][0].xyz,(*sc_set0.UserUniforms).vfxModelMatrix[l9_1444][1].xyz,(*sc_set0.UserUniforms).vfxModelMatrix[l9_1444][2].xyz)*gParticle.Velocity;
int l9_1445=gl_InstanceIndex;
int l9_1446=l9_1445/40;
gParticle.Force=float3x3((*sc_set0.UserUniforms).vfxModelMatrix[l9_1446][0].xyz,(*sc_set0.UserUniforms).vfxModelMatrix[l9_1446][1].xyz,(*sc_set0.UserUniforms).vfxModelMatrix[l9_1446][2].xyz)*gParticle.Force;
int l9_1447=gl_InstanceIndex;
int l9_1448=gl_InstanceIndex;
int l9_1449=gl_InstanceIndex;
gParticle.Size=fast::max(length((*sc_set0.UserUniforms).vfxModelMatrix[l9_1447/40][0].xyz),fast::max(length((*sc_set0.UserUniforms).vfxModelMatrix[l9_1448/40][1].xyz),length((*sc_set0.UserUniforms).vfxModelMatrix[l9_1449/40][2].xyz)))*gParticle.Size;
int l9_1450=gl_InstanceIndex;
int l9_1451=l9_1450/40;
gParticle.Matrix=float3x3((*sc_set0.UserUniforms).vfxModelMatrix[l9_1451][0].xyz,(*sc_set0.UserUniforms).vfxModelMatrix[l9_1451][1].xyz,(*sc_set0.UserUniforms).vfxModelMatrix[l9_1451][2].xyz)*gParticle.Matrix;
gParticle.Spawned=true;
}
if (gParticle.Dead)
{
float4 param_2=float4(4334.0,4334.0,4334.0,0.0);
if (sc_ShaderCacheConstant_tmp!=0)
{
param_2.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1452=param_2;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1453=dot(l9_1452,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1454=l9_1453;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1454;
}
}
float4 l9_1455=float4(param_2.x,-param_2.y,(param_2.z*0.5)+(param_2.w*0.5),param_2.w);
out.gl_Position=l9_1455;
return out;
}
float3 Value_N142=float3(0.0);
Value_N142=(*sc_set0.UserUniforms).Port_Import_N142;
float3 Value_N6=float3(0.0);
Value_N6=(*sc_set0.UserUniforms).Port_Import_N006;
float Value_N30=0.0;
Value_N30=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float3 Output_N31=float3(0.0);
Output_N31=mix(Value_N142,Value_N6,float3(Value_N30));
float4 Value_N32=float4(0.0);
Value_N32=gParticle.Color;
float Output_N33=0.0;
Output_N33=Value_N32.w;
float4 Value_N182=float4(0.0);
Value_N182=float4(Output_N31.x,Output_N31.y,Output_N31.z,Value_N182.w);
Value_N182.w=Output_N33;
gParticle.Color=Value_N182;
float Output_N12=0.0;
float param_3=(*sc_set0.UserUniforms).Tweak_N12;
Output_N12=param_3;
float Output_N14=0.0;
Output_N14=Output_N12/((*sc_set0.UserUniforms).Port_Input1_N014+1.234e-06);
float3 Value_N13=float3(0.0);
Value_N13.x=Output_N12;
Value_N13.y=Output_N14;
Value_N13.z=Output_N12;
float3 Value_N206=float3(0.0);
Value_N206=Value_N13;
float3 Value_N207=float3(0.0);
Value_N207=gParticle.Position;
float3 Value_N208=float3(0.0);
Value_N208=(*sc_set0.UserUniforms).Port_Import_N208;
float3 Value_N318=float3(0.0);
Value_N318=(*sc_set0.UserUniforms).Port_Import_N318;
float Time_N319=0.0;
Time_N319=Globals.gTimeElapsedShifted*(*sc_set0.UserUniforms).Port_Multiplier_N319;
float3 Output_N320=float3(0.0);
Output_N320=Value_N318*float3(Time_N319);
float3 Output_N321=float3(0.0);
Output_N321=(Value_N207+Value_N208)+Output_N320;
float3 Value_N322=float3(0.0);
Value_N322=(*sc_set0.UserUniforms).Port_Import_N322;
float3 Output_N323=float3(0.0);
Output_N323=float3(1.0)/Value_N322;
float3 Output_N324=float3(0.0);
Output_N324=Output_N321*Output_N323;
float2 Output_N325=float2(0.0);
Output_N325=float2(Output_N324.x,Output_N324.y);
float2 Output_N326=float2(0.0);
Output_N326=Output_N325+(*sc_set0.UserUniforms).Port_Input1_N326;
float Noise_N327=0.0;
float2 param_4=Output_N326;
float2 param_5=(*sc_set0.UserUniforms).Port_Scale_N327;
param_4.x=floor(param_4.x*10000.0)*9.9999997e-05;
param_4.y=floor(param_4.y*10000.0)*9.9999997e-05;
param_4*=(param_5*0.5);
float2 l9_1457=param_4;
float param_6=(snoise(l9_1457)*0.5)+0.5;
param_6=floor(param_6*10000.0)*9.9999997e-05;
Noise_N327=param_6;
float2 Output_N328=float2(0.0);
Output_N328=float2(Output_N324.y,Output_N324.z);
float2 Output_N329=float2(0.0);
Output_N329=Output_N328+(*sc_set0.UserUniforms).Port_Input1_N329;
float Noise_N330=0.0;
float2 param_7=Output_N329;
float2 param_8=(*sc_set0.UserUniforms).Port_Scale_N330;
param_7.x=floor(param_7.x*10000.0)*9.9999997e-05;
param_7.y=floor(param_7.y*10000.0)*9.9999997e-05;
param_7*=(param_8*0.5);
float2 l9_1458=param_7;
float param_9=(snoise(l9_1458)*0.5)+0.5;
param_9=floor(param_9*10000.0)*9.9999997e-05;
Noise_N330=param_9;
float2 Output_N331=float2(0.0);
Output_N331=float2(Output_N324.z,Output_N324.x);
float2 Output_N332=float2(0.0);
Output_N332=Output_N331+(*sc_set0.UserUniforms).Port_Input1_N332;
float Noise_N333=0.0;
float2 param_10=Output_N332;
float2 param_11=(*sc_set0.UserUniforms).Port_Scale_N333;
param_10.x=floor(param_10.x*10000.0)*9.9999997e-05;
param_10.y=floor(param_10.y*10000.0)*9.9999997e-05;
param_10*=(param_11*0.5);
float2 l9_1459=param_10;
float param_12=(snoise(l9_1459)*0.5)+0.5;
param_12=floor(param_12*10000.0)*9.9999997e-05;
Noise_N333=param_12;
float3 Value_N334=float3(0.0);
Value_N334.x=Noise_N327;
Value_N334.y=Noise_N330;
Value_N334.z=Noise_N333;
float3 Output_N335=float3(0.0);
Output_N335=Value_N334*(*sc_set0.UserUniforms).Port_Input1_N335;
float3 Output_N336=float3(0.0);
Output_N336=Output_N335-float3(1.0);
float3 Output_N337=float3(0.0);
Output_N337=Value_N206*Output_N336;
gParticle.Force+=Output_N337;
float Value_N126=0.0;
Value_N126=(*sc_set0.UserUniforms).Port_Import_N126;
float Value_N127=0.0;
Value_N127=(*sc_set0.UserUniforms).Port_Import_N127;
float Value_N128=0.0;
Value_N128=(*sc_set0.UserUniforms).Port_Import_N128;
float3 Value_N129=float3(0.0);
Value_N129=gParticle.Velocity;
float3 Output_N264=float3(0.0);
Output_N264=-Value_N129;
float Output_N265=0.0;
Output_N265=length(Value_N129);
float3 Output_N130=float3(0.0);
Output_N130=Output_N264*float3(Output_N265);
float3 Output_N137=float3(0.0);
Output_N137=(((float3(Value_N126)*float3(Value_N127))*float3(Value_N128))*Output_N130)*float3((*sc_set0.UserUniforms).Port_Input4_N137);
float3 Value_N138=float3(0.0);
Value_N138=gParticle.Velocity;
float Value_N139=0.0;
Value_N139=gParticle.Mass;
float3 Output_N140=float3(0.0);
Output_N140=Value_N138*float3(Value_N139);
float3 Output_N141=float3(0.0);
Output_N141=abs(Output_N140);
float Time_N272=0.0;
Time_N272=Globals.gTimeDelta*(*sc_set0.UserUniforms).Port_Multiplier_N272;
float3 Output_N273=float3(0.0);
Output_N273=Output_N141/(float3(Time_N272)+float3(1.234e-06));
float3 Output_N274=float3(0.0);
Output_N274=-Output_N273;
float3 Output_N275=float3(0.0);
Output_N275=fast::clamp(Output_N137,Output_N274,Output_N273);
gParticle.Force+=Output_N275;
float Value_N111=0.0;
Value_N111=0.0;
float3 Value_N112=float3(0.0);
Value_N112=(*sc_set0.UserUniforms).Port_Import_N112;
float3 Value_N213=float3(0.0);
Value_N213.x=(*sc_set0.UserUniforms).Port_Value1_N213;
Value_N213.y=(*sc_set0.UserUniforms).Port_Value2_N213;
Value_N213.z=(*sc_set0.UserUniforms).Port_Value3_N213;
float3 Output_N212=float3(0.0);
Output_N212=Value_N112+Value_N213;
float3 Value_N113=float3(0.0);
Value_N113=(*sc_set0.UserUniforms).Port_Import_N113;
float Value_N114=0.0;
Value_N114=fast::clamp((*sc_set0.UserUniforms).Port_Import_N114,0.0,1.0);
float Value_N115=0.0;
Value_N115=fast::clamp((*sc_set0.UserUniforms).Port_Import_N115,0.0,1.0);
float Value_N116=0.0;
Value_N116=(*sc_set0.UserUniforms).Port_Import_N116;
float SetCollisionCount_N118=0.0;
float3 SetForce_N118=float3(0.0);
float3 SetVelocity_N118=float3(0.0);
float3 SetPosition_N118=float3(0.0);
float KillParticle_N118=0.0;
float param_13=Value_N111;
float3 param_14=Output_N212;
float3 param_15=Value_N113;
float param_16=Value_N114;
float param_17=Value_N115;
float param_18=Value_N116;
float param_19=(*sc_set0.UserUniforms).Port_CollisionCount_N118;
float param_20=(*sc_set0.UserUniforms).Port_VelocityThreshold_N118;
ssGlobals param_26=Globals;
ssGlobals tempGlobals=param_26;
float param_21=0.0;
float3 param_22=float3(0.0);
float3 param_23=float3(0.0);
float3 param_24=float3(0.0);
float param_25=0.0;
N118_OnCollision=int(param_13);
N118_PlanePos=param_14;
N118_PlaneNormal=param_15;
N118_Bounciness=param_16;
N118_Friction=param_17;
N118_PlaneOffset=param_18;
N118_CollisionCount=param_19;
N118_VelocityThreshold=param_20;
N118_CollisionPlane l9_1460;
N118_CollisionPlane l9_1461=l9_1460;
l9_1461.isColliding=false;
float3 l9_1462=gParticle.Velocity;
l9_1461.velocity=l9_1462;
float3 l9_1463=gParticle.Force;
l9_1461.force=l9_1463;
float3 l9_1464=gParticle.Position;
l9_1461.position=l9_1464;
float3 l9_1465=gParticle.Velocity;
float3 l9_1466=gParticle.Force;
float l9_1467=gParticle.Mass;
float l9_1468=tempGlobals.gTimeDelta;
float3 l9_1469=l9_1465+((l9_1466/float3(fast::max(9.9999997e-06,l9_1467)))*float3(l9_1468));
float l9_1470=tempGlobals.gTimeDelta;
float3 l9_1471=gParticle.Position;
float3 l9_1472=(l9_1469*float3(l9_1470))+l9_1471;
float3 l9_1473=l9_1472;
float3 l9_1474=normalize(N118_PlaneNormal);
float l9_1475=dot(l9_1474,l9_1473-N118_PlanePos)-N118_PlaneOffset;
if (l9_1475<0.0)
{
l9_1461.isColliding=true;
float3 l9_1476=l9_1474;
float l9_1477=N118_Bounciness;
float l9_1478=N118_Friction;
float3 l9_1479=gParticle.Velocity;
float3 l9_1480=l9_1476*dot(l9_1476,l9_1479);
float3 l9_1481=gParticle.Velocity;
float3 l9_1482=l9_1481-l9_1480;
l9_1482*=(1.0-l9_1478);
l9_1480*=l9_1477;
float3 l9_1483=l9_1482-l9_1480;
l9_1461.velocity=l9_1483;
l9_1461.force*=float(length(l9_1461.velocity)>N118_VelocityThreshold);
float3 l9_1484=gParticle.Position;
float l9_1485=dot(l9_1474,l9_1484-N118_PlanePos)-N118_PlaneOffset;
l9_1461.position+=(l9_1474*(-l9_1485));
}
N118_CollisionPlane l9_1486=l9_1461;
l9_1460=l9_1486;
N118_KillParticle=0.0;
N118_SetCollisionCount=floor(N118_CollisionCount);
if (l9_1460.isColliding)
{
N118_SetCollisionCount+=1.0;
}
N118_SetPosition=l9_1460.position;
N118_SetForce=l9_1460.force;
N118_SetVelocity=l9_1460.velocity;
if ((N118_OnCollision==1)&&(N118_SetCollisionCount>0.0))
{
N118_SetForce=float3(0.0);
N118_SetVelocity=float3(0.0);
}
if ((N118_OnCollision==2)&&(N118_SetCollisionCount>0.0))
{
N118_KillParticle=1.0;
}
param_21=N118_SetCollisionCount;
param_22=N118_SetForce;
param_23=N118_SetVelocity;
param_24=N118_SetPosition;
param_25=N118_KillParticle;
SetCollisionCount_N118=param_21;
SetForce_N118=param_22;
SetVelocity_N118=param_23;
SetPosition_N118=param_24;
KillParticle_N118=param_25;
float param_27=SetCollisionCount_N118;
float param_28=(*sc_set0.UserUniforms).Port_DefaultFloat_N119;
if (gParticle.Spawned)
{
gParticle.collisionCount_N119=param_28;
}
else
{
gParticle.collisionCount_N119=param_27;
}
gParticle.Force=SetForce_N118;
gParticle.Velocity=SetVelocity_N118;
gParticle.Position=SetPosition_N118;
float param_29=KillParticle_N118;
if ((param_29*1.0)!=0.0)
{
gParticle.Dead=true;
}
float Value_N105=0.0;
Value_N105=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float Output_N106=0.0;
Output_N106=1.0-Value_N105;
float Output_N171=0.0;
Output_N171=Output_N106*(*sc_set0.UserUniforms).Port_Input1_N171;
float Output_N108=0.0;
Output_N108=sin(Output_N171);
float Output_N109=0.0;
Output_N109=fast::clamp(Output_N108+0.001,(*sc_set0.UserUniforms).Port_Input1_N109+0.001,(*sc_set0.UserUniforms).Port_Input2_N109+0.001)-0.001;
float Output_N29=0.0;
float param_30=(*sc_set0.UserUniforms).particle_scale;
Output_N29=param_30;
float Output_N172=0.0;
Output_N172=Output_N109*Output_N29;
gParticle.Size=Output_N172;
float Value_N8=0.0;
Value_N8=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float Output_N7=0.0;
float param_31=(*sc_set0.UserUniforms).particlesReduce;
Output_N7=param_31;
float Output_N10=0.0;
Output_N10=1.0-Output_N7;
float Output_N9=0.0;
Output_N9=float(Value_N8>Output_N10);
float param_32=Output_N9;
if ((param_32*1.0)!=0.0)
{
gParticle.Dead=true;
}
float3x3 param_33=gParticle.Matrix;
gParticle.Quaternion=matrixToQuaternion(param_33);
float DeltaTime=fast::clamp(Globals.gTimeDelta,9.9999997e-05,0.5);
float Drift=0.0049999999;
if (gParticle.Dead)
{
float4 param_34=float4(4334.0,4334.0,4334.0,0.0);
if (sc_ShaderCacheConstant_tmp!=0)
{
param_34.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1487=param_34;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1488=dot(l9_1487,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1489=l9_1488;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1489;
}
}
float4 l9_1490=float4(param_34.x,-param_34.y,(param_34.z*0.5)+(param_34.w*0.5),param_34.w);
out.gl_Position=l9_1490;
return out;
}
float l9_1491;
if (abs(gParticle.Force.x)<Drift)
{
l9_1491=0.0;
}
else
{
l9_1491=gParticle.Force.x;
}
gParticle.Force.x=l9_1491;
float l9_1492;
if (abs(gParticle.Force.y)<Drift)
{
l9_1492=0.0;
}
else
{
l9_1492=gParticle.Force.y;
}
gParticle.Force.y=l9_1492;
float l9_1493;
if (abs(gParticle.Force.z)<Drift)
{
l9_1493=0.0;
}
else
{
l9_1493=gParticle.Force.z;
}
gParticle.Force.z=l9_1493;
gParticle.Mass=fast::max(Drift,gParticle.Mass);
gParticle.Velocity+=((gParticle.Force/float3(gParticle.Mass))*DeltaTime);
float l9_1494;
if (abs(gParticle.Velocity.x)<Drift)
{
l9_1494=0.0;
}
else
{
l9_1494=gParticle.Velocity.x;
}
gParticle.Velocity.x=l9_1494;
float l9_1495;
if (abs(gParticle.Velocity.y)<Drift)
{
l9_1495=0.0;
}
else
{
l9_1495=gParticle.Velocity.y;
}
gParticle.Velocity.y=l9_1495;
float l9_1496;
if (abs(gParticle.Velocity.z)<Drift)
{
l9_1496=0.0;
}
else
{
l9_1496=gParticle.Velocity.z;
}
gParticle.Velocity.z=l9_1496;
gParticle.Position+=(gParticle.Velocity*DeltaTime);
float2 QuadSize=float2(4.0,1.0)/float2(2048.0,(*sc_set0.UserUniforms).vfxTargetSizeWrite.y);
float2 Offset=float2(0.0);
int l9_1497=gl_InstanceIndex;
int offsetID=(*sc_set0.UserUniforms).vfxOffsetInstancesWrite+l9_1497;
int particleRow=512;
Offset.x=float(offsetID%particleRow);
Offset.y=float(offsetID/particleRow);
Offset*=QuadSize;
float2 Vertex=float2(0.0);
float l9_1498;
if (v.texture0.x<0.5)
{
l9_1498=0.0;
}
else
{
l9_1498=QuadSize.x;
}
Vertex.x=l9_1498;
float l9_1499;
if (v.texture0.y<0.5)
{
l9_1499=0.0;
}
else
{
l9_1499=QuadSize.y;
}
Vertex.y=l9_1499;
Vertex+=Offset;
float4 param_35=float4((Vertex*2.0)-float2(1.0),1.0,1.0);
if (sc_ShaderCacheConstant_tmp!=0)
{
param_35.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1500=param_35;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1501=dot(l9_1500,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1502=l9_1501;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1502;
}
}
float4 l9_1503=float4(param_35.x,-param_35.y,(param_35.z*0.5)+(param_35.w*0.5),param_35.w);
out.gl_Position=l9_1503;
int l9_1504=gl_InstanceIndex;
out.Interp_Particle_Index=l9_1504;
out.Interp_Particle_Coord=v.texture0;
out.Interp_Particle_Force=gParticle.Force;
out.Interp_Particle_SpawnIndex=gParticle.SpawnIndex;
out.Interp_Particle_NextBurstTime=gParticle.NextBurstTime;
out.Interp_Particle_Position=gParticle.Position;
out.Interp_Particle_Velocity=gParticle.Velocity;
out.Interp_Particle_Life=gParticle.Life;
out.Interp_Particle_Age=gParticle.Age;
out.Interp_Particle_Size=gParticle.Size;
out.Interp_Particle_Color=gParticle.Color;
out.Interp_Particle_Quaternion=gParticle.Quaternion;
out.Interp_Particle_collisionCount_N119=gParticle.collisionCount_N119;
out.Interp_Particle_Mass=gParticle.Mass;
if (gParticle.Dead)
{
float4 param_36=float4(4334.0,4334.0,4334.0,0.0);
if (sc_ShaderCacheConstant_tmp!=0)
{
param_36.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1505=param_36;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1506=dot(l9_1505,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1507=l9_1506;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1507;
}
}
float4 l9_1508=float4(param_36.x,-param_36.y,(param_36.z*0.5)+(param_36.w*0.5),param_36.w);
out.gl_Position=l9_1508;
return out;
}
bool l9_1509=(*sc_set0.UserUniforms).overrideTimeEnabled==1;
bool l9_1510;
if (l9_1509)
{
l9_1510=(*sc_set0.UserUniforms).overrideTimeDelta==0.0;
}
else
{
l9_1510=l9_1509;
}
if (l9_1510)
{
int l9_1511=gl_InstanceIndex;
float4 l9_1512;
if (l9_1511==0)
{
l9_1512=float4((v.texture0*2.0)-float2(1.0),1.0,1.0);
}
else
{
l9_1512=float4(0.0);
}
float4 param_37=l9_1512;
if (sc_ShaderCacheConstant_tmp!=0)
{
param_37.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_1513=param_37;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_1514=dot(l9_1513,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_1515=l9_1514;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_1515;
}
}
float4 l9_1516=float4(param_37.x,-param_37.y,(param_37.z*0.5)+(param_37.w*0.5),param_37.w);
out.gl_Position=l9_1516;
out.varPackedTex=float4(v.texture0.x,v.texture0.y,out.varPackedTex.z,out.varPackedTex.w);
}
return out;
}
} // VERTEX SHADER


namespace SNAP_FS {
struct ssParticle
{
float3 Position;
float3 Velocity;
float4 Color;
float Size;
float Age;
float Life;
float Mass;
float3x3 Matrix;
bool Dead;
float4 Quaternion;
float SpawnIndex;
float SpawnIndexRemainder;
float NextBurstTime;
float collisionCount_N119;
float SpawnOffset;
float Seed;
float2 Seed2000;
float TimeShift;
int Index1D;
int Index1DPerCopy;
float Index1DPerCopyF;
int StateID;
float Coord1D;
float Ratio1D;
float Ratio1DPerCopy;
int2 Index2D;
float2 Coord2D;
float2 Ratio2D;
float3 Force;
bool Spawned;
float CopyId;
float SpawnAmount;
float BurstAmount;
float BurstPeriod;
};
struct sc_PointLight_t
{
int falloffEnabled;
float falloffEndDistance;
float negRcpFalloffEndDistance4;
float angleScale;
float angleOffset;
float3 direction;
float3 position;
float4 color;
};
struct sc_DirectionalLight_t
{
float3 direction;
float4 color;
};
struct sc_AmbientLight_t
{
float3 color;
float intensity;
};
struct sc_SphericalGaussianLight_t
{
float3 color;
float sharpness;
float3 axis;
};
struct sc_LightEstimationData_t
{
sc_SphericalGaussianLight_t sg[12];
float3 ambientLight;
};
struct sc_Camera_t
{
float3 position;
float aspect;
float2 clipPlanes;
};
struct userUniformsObj
{
sc_PointLight_t sc_PointLights[3];
sc_DirectionalLight_t sc_DirectionalLights[5];
sc_AmbientLight_t sc_AmbientLights[3];
sc_LightEstimationData_t sc_LightEstimationData;
float4 sc_EnvmapDiffuseSize;
float4 sc_EnvmapDiffuseDims;
float4 sc_EnvmapDiffuseView;
float4 sc_EnvmapSpecularSize;
float4 sc_EnvmapSpecularDims;
float4 sc_EnvmapSpecularView;
float3 sc_EnvmapRotation;
float sc_EnvmapExposure;
float3 sc_Sh[9];
float sc_ShIntensity;
float4 sc_Time;
float4 sc_UniformConstants;
float4 sc_GeometryInfo;
float4x4 sc_ModelViewProjectionMatrixArray[2];
float4x4 sc_ModelViewProjectionMatrixInverseArray[2];
float4x4 sc_ViewProjectionMatrixArray[2];
float4x4 sc_ViewProjectionMatrixInverseArray[2];
float4x4 sc_ModelViewMatrixArray[2];
float4x4 sc_ModelViewMatrixInverseArray[2];
float3x3 sc_ViewNormalMatrixArray[2];
float3x3 sc_ViewNormalMatrixInverseArray[2];
float4x4 sc_ProjectionMatrixArray[2];
float4x4 sc_ProjectionMatrixInverseArray[2];
float4x4 sc_ViewMatrixArray[2];
float4x4 sc_ViewMatrixInverseArray[2];
float4x4 sc_PrevFrameViewProjectionMatrixArray[2];
float4x4 sc_ModelMatrix;
float4x4 sc_ModelMatrixInverse;
float3x3 sc_NormalMatrix;
float3x3 sc_NormalMatrixInverse;
float4x4 sc_PrevFrameModelMatrix;
float4x4 sc_PrevFrameModelMatrixInverse;
float3 sc_LocalAabbMin;
float3 sc_LocalAabbMax;
float3 sc_WorldAabbMin;
float3 sc_WorldAabbMax;
float4 sc_WindowToViewportTransform;
float4 sc_CurrentRenderTargetDims;
sc_Camera_t sc_Camera;
float sc_ShadowDensity;
float4 sc_ShadowColor;
float4x4 sc_ProjectorMatrix;
float _sc_GetFramebufferColorInvalidUsageMarker;
float shaderComplexityValue;
float sc_DisableFrustumCullingMarker;
float4 weights0;
float4 weights1;
float4 weights2;
float4 sc_StereoClipPlanes[2];
int sc_FallbackInstanceID;
float _sc_framebufferFetchMarker;
float2 sc_TAAJitterOffset;
float strandWidth;
float strandTaper;
float4 sc_StrandDataMapTextureSize;
float clumpInstanceCount;
float clumpRadius;
float clumpTipScale;
float hairstyleInstanceCount;
float hairstyleNoise;
float4 sc_ScreenTextureSize;
float4 sc_ScreenTextureDims;
float4 sc_ScreenTextureView;
float correctedIntensity;
float4 intensityTextureSize;
float4 intensityTextureDims;
float4 intensityTextureView;
float3x3 intensityTextureTransform;
float4 intensityTextureUvMinMax;
float4 intensityTextureBorderColor;
float reflBlurWidth;
float reflBlurMinRough;
float reflBlurMaxRough;
int overrideTimeEnabled;
float overrideTimeElapsed;
float overrideTimeDelta;
int vfxNumCopies;
int vfxBatchEnable[32];
int vfxEmitParticle[32];
float4x4 vfxModelMatrix[32];
float4 renderTarget0Size;
float4 renderTarget0Dims;
float4 renderTarget0View;
float4 renderTarget1Size;
float4 renderTarget1Dims;
float4 renderTarget1View;
float4 renderTarget2Size;
float4 renderTarget2Dims;
float4 renderTarget2View;
float4 renderTarget3Size;
float4 renderTarget3Dims;
float4 renderTarget3View;
float3 vfxLocalAabbMin;
float3 vfxLocalAabbMax;
float vfxCameraAspect;
float vfxCameraNear;
float vfxCameraFar;
float3 vfxCameraUp;
float3 vfxCameraForward;
float3 vfxCameraRight;
float4x4 vfxProjectionMatrix;
float4x4 vfxProjectionMatrixInverse;
float4x4 vfxViewMatrix;
float4x4 vfxViewMatrixInverse;
float4x4 vfxViewProjectionMatrix;
float4x4 vfxViewProjectionMatrixInverse;
int vfxFrame;
int vfxOffsetInstancesRead;
int vfxOffsetInstancesWrite;
float2 vfxTargetSizeRead;
float2 vfxTargetSizeWrite;
int vfxTargetWidth;
float particles_speed;
float particlesReduce;
float Tweak_N12;
float particle_scale;
float3 Port_Import_N216;
float Port_Input1_N149;
float3 Port_Min_N150;
float3 Port_Max_N150;
float Port_Import_N151;
float Port_Input1_N153;
float3 Port_Max_N154;
float Port_Import_N157;
float3 Port_Import_N158;
float Port_Input1_N162;
float Port_Input1_N165;
float Port_Import_N042;
float Port_Import_N043;
float Port_Import_N023;
float Port_Import_N024;
float Port_Import_N053;
float3 Port_Import_N054;
float3 Port_Import_N187;
float Port_Import_N189;
float3 Port_Import_N142;
float3 Port_Import_N006;
float Port_Input1_N014;
float3 Port_Import_N206;
float3 Port_Import_N208;
float3 Port_Import_N318;
float Port_Multiplier_N319;
float3 Port_Import_N322;
float2 Port_Input1_N326;
float2 Port_Scale_N327;
float2 Port_Input1_N329;
float2 Port_Scale_N330;
float2 Port_Input1_N332;
float2 Port_Scale_N333;
float3 Port_Input1_N335;
float Port_Import_N126;
float Port_Import_N127;
float Port_Import_N128;
float Port_Input4_N137;
float Port_Multiplier_N272;
float3 Port_Import_N112;
float Port_Value1_N213;
float Port_Value2_N213;
float Port_Value3_N213;
float3 Port_Import_N113;
float Port_Import_N114;
float Port_Import_N115;
float Port_Import_N116;
float Port_CollisionCount_N118;
float Port_VelocityThreshold_N118;
float Port_DefaultFloat_N119;
float Port_Input1_N171;
float Port_Input1_N109;
float Port_Input2_N109;
float Port_Input1_N184;
float4 Port_Value0_N176;
float Port_Position1_N176;
float4 Port_Value1_N176;
float Port_Position2_N176;
float4 Port_Value2_N176;
float Port_Position3_N176;
float4 Port_Value3_N176;
float4 Port_Value4_N176;
};
struct sc_Set0
{
texture2d<float> renderTarget0 [[id(1)]];
texture2d<float> renderTarget1 [[id(2)]];
texture2d<float> renderTarget2 [[id(3)]];
texture2d<float> renderTarget3 [[id(4)]];
sampler renderTarget0SmpSC [[id(20)]];
sampler renderTarget1SmpSC [[id(21)]];
sampler renderTarget2SmpSC [[id(22)]];
sampler renderTarget3SmpSC [[id(23)]];
constant userUniformsObj* UserUniforms [[id(31)]];
};
struct main_frag_out
{
float4 FragColor0 [[color(0)]];
float4 FragColor1 [[color(1)]];
float4 FragColor2 [[color(2)]];
float4 FragColor3 [[color(3)]];
};
struct main_frag_in
{
float3 varPos [[user(locn0)]];
float3 varNormal [[user(locn1)]];
float4 varTangent [[user(locn2)]];
float4 varPackedTex [[user(locn3)]];
float4 varScreenPos [[user(locn4)]];
float2 varScreenTexturePos [[user(locn5)]];
float2 varShadowTex [[user(locn6)]];
int varStereoViewID [[user(locn7)]];
float varClipDistance [[user(locn8)]];
float4 varColor [[user(locn9)]];
int Interp_Particle_Index [[user(locn10)]];
float3 Interp_Particle_Force [[user(locn11)]];
float2 Interp_Particle_Coord [[user(locn12)]];
float Interp_Particle_SpawnIndex [[user(locn13)]];
float Interp_Particle_NextBurstTime [[user(locn14)]];
float3 Interp_Particle_Position [[user(locn15)]];
float3 Interp_Particle_Velocity [[user(locn16)]];
float Interp_Particle_Life [[user(locn17)]];
float Interp_Particle_Age [[user(locn18)]];
float Interp_Particle_Size [[user(locn19)]];
float4 Interp_Particle_Color [[user(locn20)]];
float4 Interp_Particle_Quaternion [[user(locn21)]];
float Interp_Particle_collisionCount_N119 [[user(locn22)]];
float Interp_Particle_Mass [[user(locn23)]];
};
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]])
{
main_frag_out out={};
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
float2 param=float2(0.5);
int l9_0=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_1=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_1=0;
}
else
{
l9_1=in.varStereoViewID;
}
int l9_2=l9_1;
l9_0=1-l9_2;
}
else
{
int l9_3=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_3=0;
}
else
{
l9_3=in.varStereoViewID;
}
int l9_4=l9_3;
l9_0=l9_4;
}
int l9_5=l9_0;
float2 l9_6=param;
int l9_7=l9_5;
float2 l9_8=l9_6;
int l9_9=l9_7;
float l9_10=0.0;
float4 l9_11=float4(0.0);
float2 l9_12=l9_8;
int l9_13=renderTarget0Layout_tmp;
int l9_14=l9_9;
float l9_15=l9_10;
float2 l9_16=l9_12;
int l9_17=l9_13;
int l9_18=l9_14;
float3 l9_19=float3(0.0);
if (l9_17==0)
{
l9_19=float3(l9_16,0.0);
}
else
{
if (l9_17==1)
{
l9_19=float3(l9_16.x,(l9_16.y*0.5)+(0.5-(float(l9_18)*0.5)),0.0);
}
else
{
l9_19=float3(l9_16,float(l9_18));
}
}
float3 l9_20=l9_19;
float3 l9_21=l9_20;
float2 l9_22=l9_21.xy;
float l9_23=l9_15;
float4 l9_24=sc_set0.renderTarget0.sample(sc_set0.renderTarget0SmpSC,l9_22,bias(l9_23));
float4 l9_25=l9_24;
l9_11=l9_25;
float4 l9_26=l9_11;
float4 l9_27=l9_26;
float4 l9_28=l9_27;
float4 renderTarget0Sample=l9_28;
float2 param_1=float2(0.5);
int l9_29=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_30=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_30=0;
}
else
{
l9_30=in.varStereoViewID;
}
int l9_31=l9_30;
l9_29=1-l9_31;
}
else
{
int l9_32=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_32=0;
}
else
{
l9_32=in.varStereoViewID;
}
int l9_33=l9_32;
l9_29=l9_33;
}
int l9_34=l9_29;
float2 l9_35=param_1;
int l9_36=l9_34;
float2 l9_37=l9_35;
int l9_38=l9_36;
float l9_39=0.0;
float4 l9_40=float4(0.0);
float2 l9_41=l9_37;
int l9_42=renderTarget1Layout_tmp;
int l9_43=l9_38;
float l9_44=l9_39;
float2 l9_45=l9_41;
int l9_46=l9_42;
int l9_47=l9_43;
float3 l9_48=float3(0.0);
if (l9_46==0)
{
l9_48=float3(l9_45,0.0);
}
else
{
if (l9_46==1)
{
l9_48=float3(l9_45.x,(l9_45.y*0.5)+(0.5-(float(l9_47)*0.5)),0.0);
}
else
{
l9_48=float3(l9_45,float(l9_47));
}
}
float3 l9_49=l9_48;
float3 l9_50=l9_49;
float2 l9_51=l9_50.xy;
float l9_52=l9_44;
float4 l9_53=sc_set0.renderTarget1.sample(sc_set0.renderTarget1SmpSC,l9_51,bias(l9_52));
float4 l9_54=l9_53;
l9_40=l9_54;
float4 l9_55=l9_40;
float4 l9_56=l9_55;
float4 l9_57=l9_56;
float4 renderTarget1Sample=l9_57;
float2 param_2=float2(0.5);
int l9_58=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_59=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_59=0;
}
else
{
l9_59=in.varStereoViewID;
}
int l9_60=l9_59;
l9_58=1-l9_60;
}
else
{
int l9_61=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_61=0;
}
else
{
l9_61=in.varStereoViewID;
}
int l9_62=l9_61;
l9_58=l9_62;
}
int l9_63=l9_58;
float2 l9_64=param_2;
int l9_65=l9_63;
float2 l9_66=l9_64;
int l9_67=l9_65;
float l9_68=0.0;
float4 l9_69=float4(0.0);
float2 l9_70=l9_66;
int l9_71=renderTarget2Layout_tmp;
int l9_72=l9_67;
float l9_73=l9_68;
float2 l9_74=l9_70;
int l9_75=l9_71;
int l9_76=l9_72;
float3 l9_77=float3(0.0);
if (l9_75==0)
{
l9_77=float3(l9_74,0.0);
}
else
{
if (l9_75==1)
{
l9_77=float3(l9_74.x,(l9_74.y*0.5)+(0.5-(float(l9_76)*0.5)),0.0);
}
else
{
l9_77=float3(l9_74,float(l9_76));
}
}
float3 l9_78=l9_77;
float3 l9_79=l9_78;
float2 l9_80=l9_79.xy;
float l9_81=l9_73;
float4 l9_82=sc_set0.renderTarget2.sample(sc_set0.renderTarget2SmpSC,l9_80,bias(l9_81));
float4 l9_83=l9_82;
l9_69=l9_83;
float4 l9_84=l9_69;
float4 l9_85=l9_84;
float4 l9_86=l9_85;
float4 renderTarget2Sample=l9_86;
float2 param_3=float2(0.5);
int l9_87=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_88=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_88=0;
}
else
{
l9_88=in.varStereoViewID;
}
int l9_89=l9_88;
l9_87=1-l9_89;
}
else
{
int l9_90=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_90=0;
}
else
{
l9_90=in.varStereoViewID;
}
int l9_91=l9_90;
l9_87=l9_91;
}
int l9_92=l9_87;
float2 l9_93=param_3;
int l9_94=l9_92;
float2 l9_95=l9_93;
int l9_96=l9_94;
float l9_97=0.0;
float4 l9_98=float4(0.0);
float2 l9_99=l9_95;
int l9_100=renderTarget3Layout_tmp;
int l9_101=l9_96;
float l9_102=l9_97;
float2 l9_103=l9_99;
int l9_104=l9_100;
int l9_105=l9_101;
float3 l9_106=float3(0.0);
if (l9_104==0)
{
l9_106=float3(l9_103,0.0);
}
else
{
if (l9_104==1)
{
l9_106=float3(l9_103.x,(l9_103.y*0.5)+(0.5-(float(l9_105)*0.5)),0.0);
}
else
{
l9_106=float3(l9_103,float(l9_105));
}
}
float3 l9_107=l9_106;
float3 l9_108=l9_107;
float2 l9_109=l9_108.xy;
float l9_110=l9_102;
float4 l9_111=sc_set0.renderTarget3.sample(sc_set0.renderTarget3SmpSC,l9_109,bias(l9_110));
float4 l9_112=l9_111;
l9_98=l9_112;
float4 l9_113=l9_98;
float4 l9_114=l9_113;
float4 l9_115=l9_114;
float4 renderTarget3Sample=l9_115;
float4 Data0=float4(0.0);
float4 Data1=float4(0.0);
float4 Data2=float4(0.0);
float4 Data3=float4(0.0);
bool l9_116=(*sc_set0.UserUniforms).overrideTimeEnabled==1;
bool l9_117;
if (l9_116)
{
l9_117=(*sc_set0.UserUniforms).overrideTimeDelta==0.0;
}
else
{
l9_117=l9_116;
}
if (l9_117)
{
float2 param_4=in.varPackedTex.xy;
int l9_118=0;
if ((int(renderTarget0HasSwappedViews_tmp)!=0))
{
int l9_119=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_119=0;
}
else
{
l9_119=in.varStereoViewID;
}
int l9_120=l9_119;
l9_118=1-l9_120;
}
else
{
int l9_121=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_121=0;
}
else
{
l9_121=in.varStereoViewID;
}
int l9_122=l9_121;
l9_118=l9_122;
}
int l9_123=l9_118;
float2 l9_124=param_4;
int l9_125=l9_123;
float2 l9_126=l9_124;
int l9_127=l9_125;
float l9_128=0.0;
float4 l9_129=float4(0.0);
float2 l9_130=l9_126;
int l9_131=renderTarget0Layout_tmp;
int l9_132=l9_127;
float l9_133=l9_128;
float2 l9_134=l9_130;
int l9_135=l9_131;
int l9_136=l9_132;
float3 l9_137=float3(0.0);
if (l9_135==0)
{
l9_137=float3(l9_134,0.0);
}
else
{
if (l9_135==1)
{
l9_137=float3(l9_134.x,(l9_134.y*0.5)+(0.5-(float(l9_136)*0.5)),0.0);
}
else
{
l9_137=float3(l9_134,float(l9_136));
}
}
float3 l9_138=l9_137;
float3 l9_139=l9_138;
float2 l9_140=l9_139.xy;
float l9_141=l9_133;
float4 l9_142=sc_set0.renderTarget0.sample(sc_set0.renderTarget0SmpSC,l9_140,bias(l9_141));
float4 l9_143=l9_142;
l9_129=l9_143;
float4 l9_144=l9_129;
float4 l9_145=l9_144;
float4 l9_146=l9_145;
renderTarget0Sample=l9_146;
float2 param_5=in.varPackedTex.xy;
int l9_147=0;
if ((int(renderTarget1HasSwappedViews_tmp)!=0))
{
int l9_148=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_148=0;
}
else
{
l9_148=in.varStereoViewID;
}
int l9_149=l9_148;
l9_147=1-l9_149;
}
else
{
int l9_150=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_150=0;
}
else
{
l9_150=in.varStereoViewID;
}
int l9_151=l9_150;
l9_147=l9_151;
}
int l9_152=l9_147;
float2 l9_153=param_5;
int l9_154=l9_152;
float2 l9_155=l9_153;
int l9_156=l9_154;
float l9_157=0.0;
float4 l9_158=float4(0.0);
float2 l9_159=l9_155;
int l9_160=renderTarget1Layout_tmp;
int l9_161=l9_156;
float l9_162=l9_157;
float2 l9_163=l9_159;
int l9_164=l9_160;
int l9_165=l9_161;
float3 l9_166=float3(0.0);
if (l9_164==0)
{
l9_166=float3(l9_163,0.0);
}
else
{
if (l9_164==1)
{
l9_166=float3(l9_163.x,(l9_163.y*0.5)+(0.5-(float(l9_165)*0.5)),0.0);
}
else
{
l9_166=float3(l9_163,float(l9_165));
}
}
float3 l9_167=l9_166;
float3 l9_168=l9_167;
float2 l9_169=l9_168.xy;
float l9_170=l9_162;
float4 l9_171=sc_set0.renderTarget1.sample(sc_set0.renderTarget1SmpSC,l9_169,bias(l9_170));
float4 l9_172=l9_171;
l9_158=l9_172;
float4 l9_173=l9_158;
float4 l9_174=l9_173;
float4 l9_175=l9_174;
renderTarget1Sample=l9_175;
float2 param_6=in.varPackedTex.xy;
int l9_176=0;
if ((int(renderTarget2HasSwappedViews_tmp)!=0))
{
int l9_177=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_177=0;
}
else
{
l9_177=in.varStereoViewID;
}
int l9_178=l9_177;
l9_176=1-l9_178;
}
else
{
int l9_179=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_179=0;
}
else
{
l9_179=in.varStereoViewID;
}
int l9_180=l9_179;
l9_176=l9_180;
}
int l9_181=l9_176;
float2 l9_182=param_6;
int l9_183=l9_181;
float2 l9_184=l9_182;
int l9_185=l9_183;
float l9_186=0.0;
float4 l9_187=float4(0.0);
float2 l9_188=l9_184;
int l9_189=renderTarget2Layout_tmp;
int l9_190=l9_185;
float l9_191=l9_186;
float2 l9_192=l9_188;
int l9_193=l9_189;
int l9_194=l9_190;
float3 l9_195=float3(0.0);
if (l9_193==0)
{
l9_195=float3(l9_192,0.0);
}
else
{
if (l9_193==1)
{
l9_195=float3(l9_192.x,(l9_192.y*0.5)+(0.5-(float(l9_194)*0.5)),0.0);
}
else
{
l9_195=float3(l9_192,float(l9_194));
}
}
float3 l9_196=l9_195;
float3 l9_197=l9_196;
float2 l9_198=l9_197.xy;
float l9_199=l9_191;
float4 l9_200=sc_set0.renderTarget2.sample(sc_set0.renderTarget2SmpSC,l9_198,bias(l9_199));
float4 l9_201=l9_200;
l9_187=l9_201;
float4 l9_202=l9_187;
float4 l9_203=l9_202;
float4 l9_204=l9_203;
renderTarget2Sample=l9_204;
float2 param_7=in.varPackedTex.xy;
int l9_205=0;
if ((int(renderTarget3HasSwappedViews_tmp)!=0))
{
int l9_206=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_206=0;
}
else
{
l9_206=in.varStereoViewID;
}
int l9_207=l9_206;
l9_205=1-l9_207;
}
else
{
int l9_208=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_208=0;
}
else
{
l9_208=in.varStereoViewID;
}
int l9_209=l9_208;
l9_205=l9_209;
}
int l9_210=l9_205;
float2 l9_211=param_7;
int l9_212=l9_210;
float2 l9_213=l9_211;
int l9_214=l9_212;
float l9_215=0.0;
float4 l9_216=float4(0.0);
float2 l9_217=l9_213;
int l9_218=renderTarget3Layout_tmp;
int l9_219=l9_214;
float l9_220=l9_215;
float2 l9_221=l9_217;
int l9_222=l9_218;
int l9_223=l9_219;
float3 l9_224=float3(0.0);
if (l9_222==0)
{
l9_224=float3(l9_221,0.0);
}
else
{
if (l9_222==1)
{
l9_224=float3(l9_221.x,(l9_221.y*0.5)+(0.5-(float(l9_223)*0.5)),0.0);
}
else
{
l9_224=float3(l9_221,float(l9_223));
}
}
float3 l9_225=l9_224;
float3 l9_226=l9_225;
float2 l9_227=l9_226.xy;
float l9_228=l9_220;
float4 l9_229=sc_set0.renderTarget3.sample(sc_set0.renderTarget3SmpSC,l9_227,bias(l9_228));
float4 l9_230=l9_229;
l9_216=l9_230;
float4 l9_231=l9_216;
float4 l9_232=l9_231;
float4 l9_233=l9_232;
renderTarget3Sample=l9_233;
Data0=renderTarget0Sample;
Data1=renderTarget1Sample;
Data2=renderTarget2Sample;
Data3=renderTarget3Sample;
}
else
{
ssParticle gParticle;
gParticle.Position=in.Interp_Particle_Position;
gParticle.Velocity=in.Interp_Particle_Velocity;
gParticle.Life=in.Interp_Particle_Life;
gParticle.Age=in.Interp_Particle_Age;
gParticle.Size=in.Interp_Particle_Size;
gParticle.Color=in.Interp_Particle_Color;
gParticle.Quaternion=in.Interp_Particle_Quaternion;
gParticle.collisionCount_N119=in.Interp_Particle_collisionCount_N119;
gParticle.Mass=in.Interp_Particle_Mass;
gParticle.SpawnIndex=in.Interp_Particle_SpawnIndex;
gParticle.NextBurstTime=in.Interp_Particle_NextBurstTime;
float2 param_8=in.Interp_Particle_Coord;
int l9_234=int(floor(param_8.x*4.0));
float4 l9_235=float4(0.0);
float l9_236=0.0;
float l9_237=0.0;
float l9_238=0.0;
float l9_239=0.0;
float l9_240=0.0;
float l9_241=0.0;
float l9_242=0.0;
float l9_243=0.0;
float l9_244=0.0;
float l9_245=0.0;
float l9_246=0.0;
float l9_247=0.0;
float l9_248=0.0;
float l9_249=0.0;
float l9_250=0.0;
float l9_251=0.0;
if (l9_234==0)
{
float l9_252=gParticle.Position.x;
float l9_253=-1000.0;
float l9_254=1000.0;
float l9_255=l9_252;
float l9_256=l9_253;
float l9_257=l9_254;
float l9_258=0.99998999;
float l9_259=fast::clamp(l9_255,l9_256,l9_257);
float l9_260=l9_256;
float l9_261=l9_257;
float l9_262=0.0;
float l9_263=l9_258;
float l9_264=l9_262+(((l9_259-l9_260)*(l9_263-l9_262))/(l9_261-l9_260));
float l9_265=l9_264;
float4 l9_266=float4(1.0,255.0,65025.0,16581375.0)*l9_265;
l9_266=fract(l9_266);
l9_266-=(l9_266.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_267=l9_266;
float4 l9_268=l9_267;
float4 l9_269=l9_268;
l9_235=l9_269;
l9_236=l9_235.x;
l9_237=l9_235.y;
l9_238=l9_235.z;
l9_239=l9_235.w;
float l9_270=gParticle.Position.y;
float l9_271=-1000.0;
float l9_272=1000.0;
float l9_273=l9_270;
float l9_274=l9_271;
float l9_275=l9_272;
float l9_276=0.99998999;
float l9_277=fast::clamp(l9_273,l9_274,l9_275);
float l9_278=l9_274;
float l9_279=l9_275;
float l9_280=0.0;
float l9_281=l9_276;
float l9_282=l9_280+(((l9_277-l9_278)*(l9_281-l9_280))/(l9_279-l9_278));
float l9_283=l9_282;
float4 l9_284=float4(1.0,255.0,65025.0,16581375.0)*l9_283;
l9_284=fract(l9_284);
l9_284-=(l9_284.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_285=l9_284;
float4 l9_286=l9_285;
float4 l9_287=l9_286;
l9_235=l9_287;
l9_240=l9_235.x;
l9_241=l9_235.y;
l9_242=l9_235.z;
l9_243=l9_235.w;
float l9_288=gParticle.Position.z;
float l9_289=-1000.0;
float l9_290=1000.0;
float l9_291=l9_288;
float l9_292=l9_289;
float l9_293=l9_290;
float l9_294=0.99998999;
float l9_295=fast::clamp(l9_291,l9_292,l9_293);
float l9_296=l9_292;
float l9_297=l9_293;
float l9_298=0.0;
float l9_299=l9_294;
float l9_300=l9_298+(((l9_295-l9_296)*(l9_299-l9_298))/(l9_297-l9_296));
float l9_301=l9_300;
float4 l9_302=float4(1.0,255.0,65025.0,16581375.0)*l9_301;
l9_302=fract(l9_302);
l9_302-=(l9_302.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_303=l9_302;
float4 l9_304=l9_303;
float4 l9_305=l9_304;
l9_235=l9_305;
l9_244=l9_235.x;
l9_245=l9_235.y;
l9_246=l9_235.z;
l9_247=l9_235.w;
float l9_306=gParticle.Velocity.x;
float l9_307=-1000.0;
float l9_308=1000.0;
float l9_309=l9_306;
float l9_310=l9_307;
float l9_311=l9_308;
float l9_312=0.99998999;
float l9_313=fast::clamp(l9_309,l9_310,l9_311);
float l9_314=l9_310;
float l9_315=l9_311;
float l9_316=0.0;
float l9_317=l9_312;
float l9_318=l9_316+(((l9_313-l9_314)*(l9_317-l9_316))/(l9_315-l9_314));
float l9_319=l9_318;
float4 l9_320=float4(1.0,255.0,65025.0,16581375.0)*l9_319;
l9_320=fract(l9_320);
l9_320-=(l9_320.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_321=l9_320;
float4 l9_322=l9_321;
float4 l9_323=l9_322;
l9_235=l9_323;
l9_248=l9_235.x;
l9_249=l9_235.y;
l9_250=l9_235.z;
l9_251=l9_235.w;
}
else
{
if (l9_234==1)
{
float l9_324=gParticle.Velocity.y;
float l9_325=-1000.0;
float l9_326=1000.0;
float l9_327=l9_324;
float l9_328=l9_325;
float l9_329=l9_326;
float l9_330=0.99998999;
float l9_331=fast::clamp(l9_327,l9_328,l9_329);
float l9_332=l9_328;
float l9_333=l9_329;
float l9_334=0.0;
float l9_335=l9_330;
float l9_336=l9_334+(((l9_331-l9_332)*(l9_335-l9_334))/(l9_333-l9_332));
float l9_337=l9_336;
float4 l9_338=float4(1.0,255.0,65025.0,16581375.0)*l9_337;
l9_338=fract(l9_338);
l9_338-=(l9_338.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_339=l9_338;
float4 l9_340=l9_339;
float4 l9_341=l9_340;
l9_235=l9_341;
l9_236=l9_235.x;
l9_237=l9_235.y;
l9_238=l9_235.z;
l9_239=l9_235.w;
float l9_342=gParticle.Velocity.z;
float l9_343=-1000.0;
float l9_344=1000.0;
float l9_345=l9_342;
float l9_346=l9_343;
float l9_347=l9_344;
float l9_348=0.99998999;
float l9_349=fast::clamp(l9_345,l9_346,l9_347);
float l9_350=l9_346;
float l9_351=l9_347;
float l9_352=0.0;
float l9_353=l9_348;
float l9_354=l9_352+(((l9_349-l9_350)*(l9_353-l9_352))/(l9_351-l9_350));
float l9_355=l9_354;
float4 l9_356=float4(1.0,255.0,65025.0,16581375.0)*l9_355;
l9_356=fract(l9_356);
l9_356-=(l9_356.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_357=l9_356;
float4 l9_358=l9_357;
float4 l9_359=l9_358;
l9_235=l9_359;
l9_240=l9_235.x;
l9_241=l9_235.y;
l9_242=l9_235.z;
l9_243=l9_235.w;
float l9_360=gParticle.Life;
float l9_361=0.0;
float l9_362=0.2;
float l9_363=l9_360;
float l9_364=l9_361;
float l9_365=l9_362;
float l9_366=0.99998999;
float l9_367=fast::clamp(l9_363,l9_364,l9_365);
float l9_368=l9_364;
float l9_369=l9_365;
float l9_370=0.0;
float l9_371=l9_366;
float l9_372=l9_370+(((l9_367-l9_368)*(l9_371-l9_370))/(l9_369-l9_368));
float l9_373=l9_372;
float4 l9_374=float4(1.0,255.0,65025.0,16581375.0)*l9_373;
l9_374=fract(l9_374);
l9_374-=(l9_374.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_375=l9_374;
float4 l9_376=l9_375;
float4 l9_377=l9_376;
l9_235=l9_377;
l9_244=l9_235.x;
l9_245=l9_235.y;
l9_246=l9_235.z;
l9_247=l9_235.w;
float l9_378=gParticle.Age;
float l9_379=0.0;
float l9_380=0.2;
float l9_381=l9_378;
float l9_382=l9_379;
float l9_383=l9_380;
float l9_384=0.99998999;
float l9_385=fast::clamp(l9_381,l9_382,l9_383);
float l9_386=l9_382;
float l9_387=l9_383;
float l9_388=0.0;
float l9_389=l9_384;
float l9_390=l9_388+(((l9_385-l9_386)*(l9_389-l9_388))/(l9_387-l9_386));
float l9_391=l9_390;
float4 l9_392=float4(1.0,255.0,65025.0,16581375.0)*l9_391;
l9_392=fract(l9_392);
l9_392-=(l9_392.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float4 l9_393=l9_392;
float4 l9_394=l9_393;
float4 l9_395=l9_394;
l9_235=l9_395;
l9_248=l9_235.x;
l9_249=l9_235.y;
l9_250=l9_235.z;
l9_251=l9_235.w;
}
else
{
if (l9_234==2)
{
float l9_396=gParticle.Size;
float l9_397=0.0;
float l9_398=100.0;
float l9_399=l9_396;
float l9_400=l9_397;
float l9_401=l9_398;
float l9_402=0.99998999;
float l9_403=fast::clamp(l9_399,l9_400,l9_401);
float l9_404=l9_400;
float l9_405=l9_401;
float l9_406=0.0;
float l9_407=l9_402;
float l9_408=l9_406+(((l9_403-l9_404)*(l9_407-l9_406))/(l9_405-l9_404));
float l9_409=l9_408;
float4 l9_410=float4(1.0,255.0,65025.0,16581375.0)*l9_409;
l9_410=fract(l9_410);
l9_410-=(l9_410.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_411=l9_410.xy;
float2 l9_412=l9_411;
float2 l9_413=l9_412;
l9_235=float4(l9_413.x,l9_413.y,l9_235.z,l9_235.w);
l9_236=l9_235.x;
l9_237=l9_235.y;
float l9_414=gParticle.Quaternion.x;
float l9_415=-1.0;
float l9_416=1.0;
float l9_417=l9_414;
float l9_418=l9_415;
float l9_419=l9_416;
float l9_420=0.99998999;
float l9_421=fast::clamp(l9_417,l9_418,l9_419);
float l9_422=l9_418;
float l9_423=l9_419;
float l9_424=0.0;
float l9_425=l9_420;
float l9_426=l9_424+(((l9_421-l9_422)*(l9_425-l9_424))/(l9_423-l9_422));
float l9_427=l9_426;
float4 l9_428=float4(1.0,255.0,65025.0,16581375.0)*l9_427;
l9_428=fract(l9_428);
l9_428-=(l9_428.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_429=l9_428.xy;
float2 l9_430=l9_429;
float2 l9_431=l9_430;
l9_235=float4(l9_431.x,l9_431.y,l9_235.z,l9_235.w);
l9_238=l9_235.x;
l9_239=l9_235.y;
float l9_432=gParticle.Quaternion.y;
float l9_433=-1.0;
float l9_434=1.0;
float l9_435=l9_432;
float l9_436=l9_433;
float l9_437=l9_434;
float l9_438=0.99998999;
float l9_439=fast::clamp(l9_435,l9_436,l9_437);
float l9_440=l9_436;
float l9_441=l9_437;
float l9_442=0.0;
float l9_443=l9_438;
float l9_444=l9_442+(((l9_439-l9_440)*(l9_443-l9_442))/(l9_441-l9_440));
float l9_445=l9_444;
float4 l9_446=float4(1.0,255.0,65025.0,16581375.0)*l9_445;
l9_446=fract(l9_446);
l9_446-=(l9_446.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_447=l9_446.xy;
float2 l9_448=l9_447;
float2 l9_449=l9_448;
l9_235=float4(l9_449.x,l9_449.y,l9_235.z,l9_235.w);
l9_240=l9_235.x;
l9_241=l9_235.y;
float l9_450=gParticle.Quaternion.z;
float l9_451=-1.0;
float l9_452=1.0;
float l9_453=l9_450;
float l9_454=l9_451;
float l9_455=l9_452;
float l9_456=0.99998999;
float l9_457=fast::clamp(l9_453,l9_454,l9_455);
float l9_458=l9_454;
float l9_459=l9_455;
float l9_460=0.0;
float l9_461=l9_456;
float l9_462=l9_460+(((l9_457-l9_458)*(l9_461-l9_460))/(l9_459-l9_458));
float l9_463=l9_462;
float4 l9_464=float4(1.0,255.0,65025.0,16581375.0)*l9_463;
l9_464=fract(l9_464);
l9_464-=(l9_464.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_465=l9_464.xy;
float2 l9_466=l9_465;
float2 l9_467=l9_466;
l9_235=float4(l9_467.x,l9_467.y,l9_235.z,l9_235.w);
l9_242=l9_235.x;
l9_243=l9_235.y;
float l9_468=gParticle.Quaternion.w;
float l9_469=-1.0;
float l9_470=1.0;
float l9_471=l9_468;
float l9_472=l9_469;
float l9_473=l9_470;
float l9_474=0.99998999;
float l9_475=fast::clamp(l9_471,l9_472,l9_473);
float l9_476=l9_472;
float l9_477=l9_473;
float l9_478=0.0;
float l9_479=l9_474;
float l9_480=l9_478+(((l9_475-l9_476)*(l9_479-l9_478))/(l9_477-l9_476));
float l9_481=l9_480;
float4 l9_482=float4(1.0,255.0,65025.0,16581375.0)*l9_481;
l9_482=fract(l9_482);
l9_482-=(l9_482.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_483=l9_482.xy;
float2 l9_484=l9_483;
float2 l9_485=l9_484;
l9_235=float4(l9_485.x,l9_485.y,l9_235.z,l9_235.w);
l9_244=l9_235.x;
l9_245=l9_235.y;
float l9_486=gParticle.Mass;
float l9_487=0.0;
float l9_488=100.0;
float l9_489=l9_486;
float l9_490=l9_487;
float l9_491=l9_488;
float l9_492=0.99998999;
float l9_493=fast::clamp(l9_489,l9_490,l9_491);
float l9_494=l9_490;
float l9_495=l9_491;
float l9_496=0.0;
float l9_497=l9_492;
float l9_498=l9_496+(((l9_493-l9_494)*(l9_497-l9_496))/(l9_495-l9_494));
float l9_499=l9_498;
float4 l9_500=float4(1.0,255.0,65025.0,16581375.0)*l9_499;
l9_500=fract(l9_500);
l9_500-=(l9_500.yzww*float4(0.0039215689,0.0039215689,0.0039215689,0.0));
float2 l9_501=l9_500.xy;
float2 l9_502=l9_501;
float2 l9_503=l9_502;
l9_235=float4(l9_503.x,l9_503.y,l9_235.z,l9_235.w);
l9_246=l9_235.x;
l9_247=l9_235.y;
float l9_504=gParticle.Color.x;
float l9_505=0.0;
float l9_506=1.00001;
float l9_507=fast::clamp(l9_504,l9_505,l9_506);
float l9_508=l9_505;
float l9_509=l9_506;
float l9_510=0.0;
float l9_511=1.0;
float l9_512=l9_510+(((l9_507-l9_508)*(l9_511-l9_510))/(l9_509-l9_508));
float l9_513=l9_512;
l9_235.x=l9_513;
l9_248=l9_235.x;
float l9_514=gParticle.Color.y;
float l9_515=0.0;
float l9_516=1.00001;
float l9_517=fast::clamp(l9_514,l9_515,l9_516);
float l9_518=l9_515;
float l9_519=l9_516;
float l9_520=0.0;
float l9_521=1.0;
float l9_522=l9_520+(((l9_517-l9_518)*(l9_521-l9_520))/(l9_519-l9_518));
float l9_523=l9_522;
l9_235.x=l9_523;
l9_249=l9_235.x;
float l9_524=gParticle.Color.z;
float l9_525=0.0;
float l9_526=1.00001;
float l9_527=fast::clamp(l9_524,l9_525,l9_526);
float l9_528=l9_525;
float l9_529=l9_526;
float l9_530=0.0;
float l9_531=1.0;
float l9_532=l9_530+(((l9_527-l9_528)*(l9_531-l9_530))/(l9_529-l9_528));
float l9_533=l9_532;
l9_235.x=l9_533;
l9_250=l9_235.x;
float l9_534=gParticle.Color.w;
float l9_535=0.0;
float l9_536=1.00001;
float l9_537=fast::clamp(l9_534,l9_535,l9_536);
float l9_538=l9_535;
float l9_539=l9_536;
float l9_540=0.0;
float l9_541=1.0;
float l9_542=l9_540+(((l9_537-l9_538)*(l9_541-l9_540))/(l9_539-l9_538));
float l9_543=l9_542;
l9_235.x=l9_543;
l9_251=l9_235.x;
}
else
{
if (l9_234==3)
{
float l9_544=gParticle.collisionCount_N119;
float l9_545=0.0;
float l9_546=255.0;
float l9_547=fast::clamp(l9_544,l9_545,l9_546);
float l9_548=l9_545;
float l9_549=l9_546;
float l9_550=0.0;
float l9_551=1.0;
float l9_552=l9_550+(((l9_547-l9_548)*(l9_551-l9_550))/(l9_549-l9_548));
float l9_553=l9_552;
l9_235.x=l9_553;
l9_236=l9_235.x;
}
}
}
}
float4 param_9=float4(l9_236,l9_237,l9_238,l9_239);
float4 param_10=float4(l9_240,l9_241,l9_242,l9_243);
float4 param_11=float4(l9_244,l9_245,l9_246,l9_247);
float4 param_12=float4(l9_248,l9_249,l9_250,l9_251);
Data0=param_9;
Data1=param_10;
Data2=param_11;
Data3=param_12;
if (dot(((Data0+Data1)+Data2)+Data3,float4(0.23454))==0.34231836)
{
Data0+=float4(1e-06);
}
}
float4 param_13=Data0;
if (sc_ShaderCacheConstant_tmp!=0)
{
param_13.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
out.FragColor0=param_13;
float4 param_14=Data1;
out.FragColor1=param_14;
float4 param_15=Data2;
out.FragColor2=param_15;
float4 param_16=Data3;
out.FragColor3=param_16;
return out;
}
} // FRAGMENT SHADER
