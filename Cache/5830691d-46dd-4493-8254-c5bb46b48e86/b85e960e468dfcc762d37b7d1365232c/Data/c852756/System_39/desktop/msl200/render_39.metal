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
//attribute vec3 normal 1
//attribute vec4 tangent 2
//attribute vec2 texture0 3
//attribute vec2 texture1 4
//attribute vec4 color 5
//output vec4 FragColor0 0
//output vec4 FragColor1 1
//output vec4 FragColor2 2
//output vec4 FragColor3 3
//sampler sampler intensityTextureSmpSC 0:19
//sampler sampler renderTarget0SmpSC 0:20
//sampler sampler renderTarget1SmpSC 0:21
//sampler sampler renderTarget2SmpSC 0:22
//sampler sampler renderTarget3SmpSC 0:23
//sampler sampler sc_ScreenTextureSmpSC 0:28
//texture texture2D intensityTexture 0:0:0:19
//texture texture2D renderTarget0 0:1:0:20
//texture texture2D renderTarget1 0:2:0:21
//texture texture2D renderTarget2 0:3:0:22
//texture texture2D renderTarget3 0:4:0:23
//texture texture2D sc_ScreenTexture 0:16:0:28
//ubo int UserUniforms 0:31:7328 {
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
//float4 Port_Value1_N132 7024
//float4 Port_Value2_N132 7040
//float Port_AlphaTestThreshold_N039 7056
//float3 Port_Normal_N002 7072
//float Port_Exponent_N002 7088
//float Port_Intensity_N002 7092
//float Port_Input1_N063 7096
//float Port_Input1_N017 7100
//float Port_RangeMinA_N018 7104
//float Port_RangeMaxA_N018 7108
//float Port_RangeMinB_N018 7112
//float Port_RangeMaxB_N018 7116
//float Port_Input1_N065 7120
//float Port_Input2_N065 7124
//float4 Port_Input1_N066 7136
//float4 Port_Value0_N068 7152
//float Port_Position1_N068 7168
//float4 Port_Value1_N068 7184
//float Port_Position2_N068 7200
//float4 Port_Value2_N068 7216
//float4 Port_Value3_N068 7232
//float Port_Input1_N067 7248
//float4 Port_Value0_N178 7264
//float Port_Position1_N178 7280
//float4 Port_Value1_N178 7296
//float4 Port_Value2_N178 7312
//}
//spec_const bool BLEND_MODE_AVERAGE 0
//spec_const bool BLEND_MODE_BRIGHT 1
//spec_const bool BLEND_MODE_COLOR_BURN 2
//spec_const bool BLEND_MODE_COLOR_DODGE 3
//spec_const bool BLEND_MODE_COLOR 4
//spec_const bool BLEND_MODE_DARKEN 5
//spec_const bool BLEND_MODE_DIFFERENCE 6
//spec_const bool BLEND_MODE_DIVIDE 7
//spec_const bool BLEND_MODE_DIVISION 8
//spec_const bool BLEND_MODE_EXCLUSION 9
//spec_const bool BLEND_MODE_FORGRAY 10
//spec_const bool BLEND_MODE_HARD_GLOW 11
//spec_const bool BLEND_MODE_HARD_LIGHT 12
//spec_const bool BLEND_MODE_HARD_MIX 13
//spec_const bool BLEND_MODE_HARD_PHOENIX 14
//spec_const bool BLEND_MODE_HARD_REFLECT 15
//spec_const bool BLEND_MODE_HUE 16
//spec_const bool BLEND_MODE_INTENSE 17
//spec_const bool BLEND_MODE_LIGHTEN 18
//spec_const bool BLEND_MODE_LINEAR_LIGHT 19
//spec_const bool BLEND_MODE_LUMINOSITY 20
//spec_const bool BLEND_MODE_NEGATION 21
//spec_const bool BLEND_MODE_NOTBRIGHT 22
//spec_const bool BLEND_MODE_OVERLAY 23
//spec_const bool BLEND_MODE_PIN_LIGHT 24
//spec_const bool BLEND_MODE_REALISTIC 25
//spec_const bool BLEND_MODE_SATURATION 26
//spec_const bool BLEND_MODE_SOFT_LIGHT 27
//spec_const bool BLEND_MODE_SUBTRACT 28
//spec_const bool BLEND_MODE_VIVID_LIGHT 29
//spec_const bool SC_USE_CLAMP_TO_BORDER_intensityTexture 30
//spec_const bool SC_USE_UV_MIN_MAX_intensityTexture 31
//spec_const bool SC_USE_UV_TRANSFORM_intensityTexture 32
//spec_const bool intensityTextureHasSwappedViews 33
//spec_const bool renderTarget0HasSwappedViews 34
//spec_const bool renderTarget1HasSwappedViews 35
//spec_const bool renderTarget2HasSwappedViews 36
//spec_const bool renderTarget3HasSwappedViews 37
//spec_const bool sc_BlendMode_Custom 38
//spec_const bool sc_BlendMode_MultiplyOriginal 39
//spec_const bool sc_BlendMode_PremultipliedAlphaAuto 40
//spec_const bool sc_BlendMode_Screen 41
//spec_const bool sc_FramebufferFetch 42
//spec_const bool sc_RenderAlphaToColor 43
//spec_const bool sc_ScreenTextureHasSwappedViews 44
//spec_const bool sc_ShaderComplexityAnalyzer 45
//spec_const bool sc_UseFramebufferFetchMarker 46
//spec_const int SC_SOFTWARE_WRAP_MODE_U_intensityTexture 47
//spec_const int SC_SOFTWARE_WRAP_MODE_V_intensityTexture 48
//spec_const int intensityTextureLayout 49
//spec_const int renderTarget0Layout 50
//spec_const int renderTarget1Layout 51
//spec_const int renderTarget2Layout 52
//spec_const int renderTarget3Layout 53
//spec_const int sc_DepthBufferMode 54
//spec_const int sc_ScreenTextureLayout 55
//spec_const int sc_ShaderCacheConstant 56
//spec_const int sc_StereoRenderingMode 57
//spec_const int sc_StereoRendering_IsClipDistanceEnabled 58
//SG_REFLECTION_END
constant bool BLEND_MODE_AVERAGE [[function_constant(0)]];
constant bool BLEND_MODE_AVERAGE_tmp = is_function_constant_defined(BLEND_MODE_AVERAGE) ? BLEND_MODE_AVERAGE : false;
constant bool BLEND_MODE_BRIGHT [[function_constant(1)]];
constant bool BLEND_MODE_BRIGHT_tmp = is_function_constant_defined(BLEND_MODE_BRIGHT) ? BLEND_MODE_BRIGHT : false;
constant bool BLEND_MODE_COLOR_BURN [[function_constant(2)]];
constant bool BLEND_MODE_COLOR_BURN_tmp = is_function_constant_defined(BLEND_MODE_COLOR_BURN) ? BLEND_MODE_COLOR_BURN : false;
constant bool BLEND_MODE_COLOR_DODGE [[function_constant(3)]];
constant bool BLEND_MODE_COLOR_DODGE_tmp = is_function_constant_defined(BLEND_MODE_COLOR_DODGE) ? BLEND_MODE_COLOR_DODGE : false;
constant bool BLEND_MODE_COLOR [[function_constant(4)]];
constant bool BLEND_MODE_COLOR_tmp = is_function_constant_defined(BLEND_MODE_COLOR) ? BLEND_MODE_COLOR : false;
constant bool BLEND_MODE_DARKEN [[function_constant(5)]];
constant bool BLEND_MODE_DARKEN_tmp = is_function_constant_defined(BLEND_MODE_DARKEN) ? BLEND_MODE_DARKEN : false;
constant bool BLEND_MODE_DIFFERENCE [[function_constant(6)]];
constant bool BLEND_MODE_DIFFERENCE_tmp = is_function_constant_defined(BLEND_MODE_DIFFERENCE) ? BLEND_MODE_DIFFERENCE : false;
constant bool BLEND_MODE_DIVIDE [[function_constant(7)]];
constant bool BLEND_MODE_DIVIDE_tmp = is_function_constant_defined(BLEND_MODE_DIVIDE) ? BLEND_MODE_DIVIDE : false;
constant bool BLEND_MODE_DIVISION [[function_constant(8)]];
constant bool BLEND_MODE_DIVISION_tmp = is_function_constant_defined(BLEND_MODE_DIVISION) ? BLEND_MODE_DIVISION : false;
constant bool BLEND_MODE_EXCLUSION [[function_constant(9)]];
constant bool BLEND_MODE_EXCLUSION_tmp = is_function_constant_defined(BLEND_MODE_EXCLUSION) ? BLEND_MODE_EXCLUSION : false;
constant bool BLEND_MODE_FORGRAY [[function_constant(10)]];
constant bool BLEND_MODE_FORGRAY_tmp = is_function_constant_defined(BLEND_MODE_FORGRAY) ? BLEND_MODE_FORGRAY : false;
constant bool BLEND_MODE_HARD_GLOW [[function_constant(11)]];
constant bool BLEND_MODE_HARD_GLOW_tmp = is_function_constant_defined(BLEND_MODE_HARD_GLOW) ? BLEND_MODE_HARD_GLOW : false;
constant bool BLEND_MODE_HARD_LIGHT [[function_constant(12)]];
constant bool BLEND_MODE_HARD_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_HARD_LIGHT) ? BLEND_MODE_HARD_LIGHT : false;
constant bool BLEND_MODE_HARD_MIX [[function_constant(13)]];
constant bool BLEND_MODE_HARD_MIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_MIX) ? BLEND_MODE_HARD_MIX : false;
constant bool BLEND_MODE_HARD_PHOENIX [[function_constant(14)]];
constant bool BLEND_MODE_HARD_PHOENIX_tmp = is_function_constant_defined(BLEND_MODE_HARD_PHOENIX) ? BLEND_MODE_HARD_PHOENIX : false;
constant bool BLEND_MODE_HARD_REFLECT [[function_constant(15)]];
constant bool BLEND_MODE_HARD_REFLECT_tmp = is_function_constant_defined(BLEND_MODE_HARD_REFLECT) ? BLEND_MODE_HARD_REFLECT : false;
constant bool BLEND_MODE_HUE [[function_constant(16)]];
constant bool BLEND_MODE_HUE_tmp = is_function_constant_defined(BLEND_MODE_HUE) ? BLEND_MODE_HUE : false;
constant bool BLEND_MODE_INTENSE [[function_constant(17)]];
constant bool BLEND_MODE_INTENSE_tmp = is_function_constant_defined(BLEND_MODE_INTENSE) ? BLEND_MODE_INTENSE : false;
constant bool BLEND_MODE_LIGHTEN [[function_constant(18)]];
constant bool BLEND_MODE_LIGHTEN_tmp = is_function_constant_defined(BLEND_MODE_LIGHTEN) ? BLEND_MODE_LIGHTEN : false;
constant bool BLEND_MODE_LINEAR_LIGHT [[function_constant(19)]];
constant bool BLEND_MODE_LINEAR_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_LINEAR_LIGHT) ? BLEND_MODE_LINEAR_LIGHT : false;
constant bool BLEND_MODE_LUMINOSITY [[function_constant(20)]];
constant bool BLEND_MODE_LUMINOSITY_tmp = is_function_constant_defined(BLEND_MODE_LUMINOSITY) ? BLEND_MODE_LUMINOSITY : false;
constant bool BLEND_MODE_NEGATION [[function_constant(21)]];
constant bool BLEND_MODE_NEGATION_tmp = is_function_constant_defined(BLEND_MODE_NEGATION) ? BLEND_MODE_NEGATION : false;
constant bool BLEND_MODE_NOTBRIGHT [[function_constant(22)]];
constant bool BLEND_MODE_NOTBRIGHT_tmp = is_function_constant_defined(BLEND_MODE_NOTBRIGHT) ? BLEND_MODE_NOTBRIGHT : false;
constant bool BLEND_MODE_OVERLAY [[function_constant(23)]];
constant bool BLEND_MODE_OVERLAY_tmp = is_function_constant_defined(BLEND_MODE_OVERLAY) ? BLEND_MODE_OVERLAY : false;
constant bool BLEND_MODE_PIN_LIGHT [[function_constant(24)]];
constant bool BLEND_MODE_PIN_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_PIN_LIGHT) ? BLEND_MODE_PIN_LIGHT : false;
constant bool BLEND_MODE_REALISTIC [[function_constant(25)]];
constant bool BLEND_MODE_REALISTIC_tmp = is_function_constant_defined(BLEND_MODE_REALISTIC) ? BLEND_MODE_REALISTIC : false;
constant bool BLEND_MODE_SATURATION [[function_constant(26)]];
constant bool BLEND_MODE_SATURATION_tmp = is_function_constant_defined(BLEND_MODE_SATURATION) ? BLEND_MODE_SATURATION : false;
constant bool BLEND_MODE_SOFT_LIGHT [[function_constant(27)]];
constant bool BLEND_MODE_SOFT_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_SOFT_LIGHT) ? BLEND_MODE_SOFT_LIGHT : false;
constant bool BLEND_MODE_SUBTRACT [[function_constant(28)]];
constant bool BLEND_MODE_SUBTRACT_tmp = is_function_constant_defined(BLEND_MODE_SUBTRACT) ? BLEND_MODE_SUBTRACT : false;
constant bool BLEND_MODE_VIVID_LIGHT [[function_constant(29)]];
constant bool BLEND_MODE_VIVID_LIGHT_tmp = is_function_constant_defined(BLEND_MODE_VIVID_LIGHT) ? BLEND_MODE_VIVID_LIGHT : false;
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture [[function_constant(30)]];
constant bool SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp = is_function_constant_defined(SC_USE_CLAMP_TO_BORDER_intensityTexture) ? SC_USE_CLAMP_TO_BORDER_intensityTexture : false;
constant bool SC_USE_UV_MIN_MAX_intensityTexture [[function_constant(31)]];
constant bool SC_USE_UV_MIN_MAX_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_MIN_MAX_intensityTexture) ? SC_USE_UV_MIN_MAX_intensityTexture : false;
constant bool SC_USE_UV_TRANSFORM_intensityTexture [[function_constant(32)]];
constant bool SC_USE_UV_TRANSFORM_intensityTexture_tmp = is_function_constant_defined(SC_USE_UV_TRANSFORM_intensityTexture) ? SC_USE_UV_TRANSFORM_intensityTexture : false;
constant bool intensityTextureHasSwappedViews [[function_constant(33)]];
constant bool intensityTextureHasSwappedViews_tmp = is_function_constant_defined(intensityTextureHasSwappedViews) ? intensityTextureHasSwappedViews : false;
constant bool renderTarget0HasSwappedViews [[function_constant(34)]];
constant bool renderTarget0HasSwappedViews_tmp = is_function_constant_defined(renderTarget0HasSwappedViews) ? renderTarget0HasSwappedViews : false;
constant bool renderTarget1HasSwappedViews [[function_constant(35)]];
constant bool renderTarget1HasSwappedViews_tmp = is_function_constant_defined(renderTarget1HasSwappedViews) ? renderTarget1HasSwappedViews : false;
constant bool renderTarget2HasSwappedViews [[function_constant(36)]];
constant bool renderTarget2HasSwappedViews_tmp = is_function_constant_defined(renderTarget2HasSwappedViews) ? renderTarget2HasSwappedViews : false;
constant bool renderTarget3HasSwappedViews [[function_constant(37)]];
constant bool renderTarget3HasSwappedViews_tmp = is_function_constant_defined(renderTarget3HasSwappedViews) ? renderTarget3HasSwappedViews : false;
constant bool sc_BlendMode_Custom [[function_constant(38)]];
constant bool sc_BlendMode_Custom_tmp = is_function_constant_defined(sc_BlendMode_Custom) ? sc_BlendMode_Custom : false;
constant bool sc_BlendMode_MultiplyOriginal [[function_constant(39)]];
constant bool sc_BlendMode_MultiplyOriginal_tmp = is_function_constant_defined(sc_BlendMode_MultiplyOriginal) ? sc_BlendMode_MultiplyOriginal : false;
constant bool sc_BlendMode_PremultipliedAlphaAuto [[function_constant(40)]];
constant bool sc_BlendMode_PremultipliedAlphaAuto_tmp = is_function_constant_defined(sc_BlendMode_PremultipliedAlphaAuto) ? sc_BlendMode_PremultipliedAlphaAuto : false;
constant bool sc_BlendMode_Screen [[function_constant(41)]];
constant bool sc_BlendMode_Screen_tmp = is_function_constant_defined(sc_BlendMode_Screen) ? sc_BlendMode_Screen : false;
constant bool sc_FramebufferFetch [[function_constant(42)]];
constant bool sc_FramebufferFetch_tmp = is_function_constant_defined(sc_FramebufferFetch) ? sc_FramebufferFetch : false;
constant bool sc_RenderAlphaToColor [[function_constant(43)]];
constant bool sc_RenderAlphaToColor_tmp = is_function_constant_defined(sc_RenderAlphaToColor) ? sc_RenderAlphaToColor : false;
constant bool sc_ScreenTextureHasSwappedViews [[function_constant(44)]];
constant bool sc_ScreenTextureHasSwappedViews_tmp = is_function_constant_defined(sc_ScreenTextureHasSwappedViews) ? sc_ScreenTextureHasSwappedViews : false;
constant bool sc_ShaderComplexityAnalyzer [[function_constant(45)]];
constant bool sc_ShaderComplexityAnalyzer_tmp = is_function_constant_defined(sc_ShaderComplexityAnalyzer) ? sc_ShaderComplexityAnalyzer : false;
constant bool sc_UseFramebufferFetchMarker [[function_constant(46)]];
constant bool sc_UseFramebufferFetchMarker_tmp = is_function_constant_defined(sc_UseFramebufferFetchMarker) ? sc_UseFramebufferFetchMarker : false;
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture [[function_constant(47)]];
constant int SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_U_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_U_intensityTexture : -1;
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture [[function_constant(48)]];
constant int SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp = is_function_constant_defined(SC_SOFTWARE_WRAP_MODE_V_intensityTexture) ? SC_SOFTWARE_WRAP_MODE_V_intensityTexture : -1;
constant int intensityTextureLayout [[function_constant(49)]];
constant int intensityTextureLayout_tmp = is_function_constant_defined(intensityTextureLayout) ? intensityTextureLayout : 0;
constant int renderTarget0Layout [[function_constant(50)]];
constant int renderTarget0Layout_tmp = is_function_constant_defined(renderTarget0Layout) ? renderTarget0Layout : 0;
constant int renderTarget1Layout [[function_constant(51)]];
constant int renderTarget1Layout_tmp = is_function_constant_defined(renderTarget1Layout) ? renderTarget1Layout : 0;
constant int renderTarget2Layout [[function_constant(52)]];
constant int renderTarget2Layout_tmp = is_function_constant_defined(renderTarget2Layout) ? renderTarget2Layout : 0;
constant int renderTarget3Layout [[function_constant(53)]];
constant int renderTarget3Layout_tmp = is_function_constant_defined(renderTarget3Layout) ? renderTarget3Layout : 0;
constant int sc_DepthBufferMode [[function_constant(54)]];
constant int sc_DepthBufferMode_tmp = is_function_constant_defined(sc_DepthBufferMode) ? sc_DepthBufferMode : 0;
constant int sc_ScreenTextureLayout [[function_constant(55)]];
constant int sc_ScreenTextureLayout_tmp = is_function_constant_defined(sc_ScreenTextureLayout) ? sc_ScreenTextureLayout : 0;
constant int sc_ShaderCacheConstant [[function_constant(56)]];
constant int sc_ShaderCacheConstant_tmp = is_function_constant_defined(sc_ShaderCacheConstant) ? sc_ShaderCacheConstant : 0;
constant int sc_StereoRenderingMode [[function_constant(57)]];
constant int sc_StereoRenderingMode_tmp = is_function_constant_defined(sc_StereoRenderingMode) ? sc_StereoRenderingMode : 0;
constant int sc_StereoRendering_IsClipDistanceEnabled [[function_constant(58)]];
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
float4 Port_Value1_N132;
float4 Port_Value2_N132;
float Port_AlphaTestThreshold_N039;
float3 Port_Normal_N002;
float Port_Exponent_N002;
float Port_Intensity_N002;
float Port_Input1_N063;
float Port_Input1_N017;
float Port_RangeMinA_N018;
float Port_RangeMaxA_N018;
float Port_RangeMinB_N018;
float Port_RangeMaxB_N018;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Input1_N066;
float4 Port_Value0_N068;
float Port_Position1_N068;
float4 Port_Value1_N068;
float Port_Position2_N068;
float4 Port_Value2_N068;
float4 Port_Value3_N068;
float Port_Input1_N067;
float4 Port_Value0_N178;
float Port_Position1_N178;
float4 Port_Value1_N178;
float4 Port_Value2_N178;
};
struct sc_Set0
{
texture2d<float> intensityTexture [[id(0)]];
texture2d<float> renderTarget0 [[id(1)]];
texture2d<float> renderTarget1 [[id(2)]];
texture2d<float> renderTarget2 [[id(3)]];
texture2d<float> renderTarget3 [[id(4)]];
texture2d<float> sc_ScreenTexture [[id(16)]];
sampler intensityTextureSmpSC [[id(19)]];
sampler renderTarget0SmpSC [[id(20)]];
sampler renderTarget1SmpSC [[id(21)]];
sampler renderTarget2SmpSC [[id(22)]];
sampler renderTarget3SmpSC [[id(23)]];
sampler sc_ScreenTextureSmpSC [[id(28)]];
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
float gParticlesDebug [[user(locn24)]];
float2 ParticleUV [[user(locn25)]];
float4 gl_Position [[position]];
};
struct main_vert_in
{
float4 position [[attribute(0)]];
float3 normal [[attribute(1)]];
float4 tangent [[attribute(2)]];
float2 texture0 [[attribute(3)]];
float2 texture1 [[attribute(4)]];
float4 color [[attribute(5)]];
};
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
vertex main_vert_out main_vert(main_vert_in in [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],uint gl_InstanceIndex [[instance_id]])
{
main_vert_out out={};
sc_Vertex_t l9_0;
l9_0.position=in.position;
l9_0.normal=in.normal;
l9_0.tangent=in.tangent.xyz;
l9_0.texture0=in.texture0;
l9_0.texture1=in.texture1;
sc_Vertex_t l9_1=l9_0;
sc_Vertex_t v=l9_1;
out.varColor=in.color;
int l9_2=gl_InstanceIndex;
int InstanceID=l9_2;
int l9_3=InstanceID;
bool l9_4=l9_3>=(40*((*sc_set0.UserUniforms).vfxNumCopies+1));
ssParticle gParticle;
bool l9_5;
if (!l9_4)
{
int l9_6=gl_InstanceIndex;
l9_5=((*sc_set0.UserUniforms).vfxBatchEnable[l9_6/40]!=0)==false;
}
else
{
l9_5=l9_4;
}
if (l9_5)
{
float4 param=float4(4334.0,4334.0,4334.0,0.0);
if (sc_ShaderCacheConstant_tmp!=0)
{
param.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_7=param;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_8=dot(l9_7,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_9=l9_8;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_9;
}
}
float4 l9_10=float4(param.x,-param.y,(param.z*0.5)+(param.w*0.5),param.w);
out.gl_Position=l9_10;
return out;
}
int param_1=InstanceID;
bool l9_12=ssDecodeParticle(param_1,gl_InstanceIndex,(*sc_set0.UserUniforms),sc_set0.renderTarget0,sc_set0.renderTarget0SmpSC,sc_set0.renderTarget1,sc_set0.renderTarget1SmpSC,sc_set0.renderTarget2,sc_set0.renderTarget2SmpSC,sc_set0.renderTarget3,sc_set0.renderTarget3SmpSC,gParticle);
if (!l9_12)
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
float4 l9_13=param_2;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_14=dot(l9_13,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_15=l9_14;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_15;
}
}
float4 l9_16=float4(param_2.x,-param_2.y,(param_2.z*0.5)+(param_2.w*0.5),param_2.w);
out.gl_Position=l9_16;
return out;
}
float l9_17=gParticle.Size;
bool l9_18=l9_17<9.9999997e-06;
bool l9_19;
if (!l9_18)
{
l9_19=gParticle.Age>=gParticle.Life;
}
else
{
l9_19=l9_18;
}
if (l9_19)
{
float4 param_3=float4(4334.0,4334.0,4334.0,0.0);
if (sc_ShaderCacheConstant_tmp!=0)
{
param_3.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_20=param_3;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_21=dot(l9_20,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_22=l9_21;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_22;
}
}
float4 l9_23=float4(param_3.x,-param_3.y,(param_3.z*0.5)+(param_3.w*0.5),param_3.w);
out.gl_Position=l9_23;
return out;
}
float4 param_4=gParticle.Quaternion;
param_4=normalize(param_4.yzwx);
float l9_24=param_4.x*param_4.x;
float l9_25=param_4.y*param_4.y;
float l9_26=param_4.z*param_4.z;
float l9_27=param_4.x*param_4.z;
float l9_28=param_4.x*param_4.y;
float l9_29=param_4.y*param_4.z;
float l9_30=param_4.w*param_4.x;
float l9_31=param_4.w*param_4.y;
float l9_32=param_4.w*param_4.z;
float3x3 l9_33=float3x3(float3(1.0-(2.0*(l9_25+l9_26)),2.0*(l9_28+l9_32),2.0*(l9_27-l9_31)),float3(2.0*(l9_28-l9_32),1.0-(2.0*(l9_24+l9_26)),2.0*(l9_29+l9_30)),float3(2.0*(l9_27+l9_31),2.0*(l9_29-l9_30),1.0-(2.0*(l9_24+l9_25))));
gParticle.Matrix=l9_33;
out.varPos=gParticle.Position+((gParticle.Matrix*v.position.xyz)*gParticle.Size);
out.varNormal=gParticle.Matrix*v.normal;
float3 l9_34=gParticle.Matrix*v.tangent;
out.varTangent=float4(l9_34.x,l9_34.y,l9_34.z,out.varTangent.w);
out.varTangent.w=in.tangent.w;
out.varPackedTex=float4(v.texture0,v.texture1);
int l9_35=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_35=0;
}
else
{
l9_35=gl_InstanceIndex%2;
}
int l9_36=l9_35;
float4 clipPosition=(*sc_set0.UserUniforms).sc_ViewProjectionMatrixArray[l9_36]*float4(out.varPos,1.0);
float4 param_5=clipPosition;
if (sc_DepthBufferMode_tmp==1)
{
int l9_37=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_37=0;
}
else
{
l9_37=gl_InstanceIndex%2;
}
int l9_38=l9_37;
if ((*sc_set0.UserUniforms).sc_ProjectionMatrixArray[l9_38][2].w!=0.0)
{
float l9_39=2.0/log2((*sc_set0.UserUniforms).sc_Camera.clipPlanes.y+1.0);
param_5.z=((log2(fast::max((*sc_set0.UserUniforms).sc_Camera.clipPlanes.x,1.0+param_5.w))*l9_39)-1.0)*param_5.w;
}
}
float4 l9_40=param_5;
clipPosition=l9_40;
float4 param_6=clipPosition;
if (sc_ShaderCacheConstant_tmp!=0)
{
param_6.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
if (sc_StereoRenderingMode_tmp>0)
{
out.varStereoViewID=gl_InstanceIndex%2;
}
float4 l9_41=param_6;
if (sc_StereoRenderingMode_tmp==1)
{
float l9_42=dot(l9_41,(*sc_set0.UserUniforms).sc_StereoClipPlanes[gl_InstanceIndex%2]);
float l9_43=l9_42;
if (sc_StereoRendering_IsClipDistanceEnabled_tmp==1)
{
}
else
{
out.varClipDistance=l9_43;
}
}
float4 l9_44=float4(param_6.x,-param_6.y,(param_6.z*0.5)+(param_6.w*0.5),param_6.w);
out.gl_Position=l9_44;
int l9_45=gl_InstanceIndex;
out.Interp_Particle_Index=l9_45;
out.Interp_Particle_Force=gParticle.Force;
out.Interp_Particle_Position=gParticle.Position;
out.Interp_Particle_Velocity=gParticle.Velocity;
out.Interp_Particle_Life=gParticle.Life;
out.Interp_Particle_Age=gParticle.Age;
out.Interp_Particle_Size=gParticle.Size;
out.Interp_Particle_Color=gParticle.Color;
out.Interp_Particle_Quaternion=gParticle.Quaternion;
out.Interp_Particle_collisionCount_N119=gParticle.collisionCount_N119;
out.Interp_Particle_Mass=gParticle.Mass;
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
struct ssGlobals
{
float gTimeElapsed;
float gTimeDelta;
float gTimeElapsedShifted;
float3 VertexTangent_WorldSpace;
float3 VertexNormal_WorldSpace;
float3 VertexBinormal_WorldSpace;
float3 ViewDirWS;
float3 SurfacePosition_WorldSpace;
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
float4 Port_Value1_N132;
float4 Port_Value2_N132;
float Port_AlphaTestThreshold_N039;
float3 Port_Normal_N002;
float Port_Exponent_N002;
float Port_Intensity_N002;
float Port_Input1_N063;
float Port_Input1_N017;
float Port_RangeMinA_N018;
float Port_RangeMaxA_N018;
float Port_RangeMinB_N018;
float Port_RangeMaxB_N018;
float Port_Input1_N065;
float Port_Input2_N065;
float4 Port_Input1_N066;
float4 Port_Value0_N068;
float Port_Position1_N068;
float4 Port_Value1_N068;
float Port_Position2_N068;
float4 Port_Value2_N068;
float4 Port_Value3_N068;
float Port_Input1_N067;
float4 Port_Value0_N178;
float Port_Position1_N178;
float4 Port_Value1_N178;
float4 Port_Value2_N178;
};
struct sc_Set0
{
texture2d<float> intensityTexture [[id(0)]];
texture2d<float> renderTarget0 [[id(1)]];
texture2d<float> renderTarget1 [[id(2)]];
texture2d<float> renderTarget2 [[id(3)]];
texture2d<float> renderTarget3 [[id(4)]];
texture2d<float> sc_ScreenTexture [[id(16)]];
sampler intensityTextureSmpSC [[id(19)]];
sampler renderTarget0SmpSC [[id(20)]];
sampler renderTarget1SmpSC [[id(21)]];
sampler renderTarget2SmpSC [[id(22)]];
sampler renderTarget3SmpSC [[id(23)]];
sampler sc_ScreenTextureSmpSC [[id(28)]];
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
float gParticlesDebug [[user(locn24)]];
float2 ParticleUV [[user(locn25)]];
};
float transformSingleColor(thread const float& original,thread const float& intMap,thread const float& target)
{
if (((int(BLEND_MODE_REALISTIC_tmp)!=0)||(int(BLEND_MODE_FORGRAY_tmp)!=0))||(int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
return original/pow(1.0-target,intMap);
}
else
{
if ((int(BLEND_MODE_DIVISION_tmp)!=0))
{
return original/(1.0-target);
}
else
{
if ((int(BLEND_MODE_BRIGHT_tmp)!=0))
{
return original/pow(1.0-target,2.0-(2.0*original));
}
}
}
return 0.0;
}
float3 transformColor(thread const float& yValue,thread const float3& original,thread const float3& target,thread const float& weight,thread const float& intMap)
{
if ((int(BLEND_MODE_INTENSE_tmp)!=0))
{
float3 param=original;
float3 l9_0=param;
float4 l9_1;
if (l9_0.y<l9_0.z)
{
l9_1=float4(l9_0.zy,-1.0,0.66666669);
}
else
{
l9_1=float4(l9_0.yz,0.0,-0.33333334);
}
float4 l9_2=l9_1;
float4 l9_3;
if (l9_0.x<l9_2.x)
{
l9_3=float4(l9_2.xyw,l9_0.x);
}
else
{
l9_3=float4(l9_0.x,l9_2.yzx);
}
float4 l9_4=l9_3;
float l9_5=l9_4.x-fast::min(l9_4.w,l9_4.y);
float l9_6=abs(((l9_4.w-l9_4.y)/((6.0*l9_5)+1e-07))+l9_4.z);
float l9_7=l9_4.x;
float3 l9_8=float3(l9_6,l9_5,l9_7);
float3 l9_9=l9_8;
float l9_10=l9_9.z-(l9_9.y*0.5);
float l9_11=l9_9.y/((1.0-abs((2.0*l9_10)-1.0))+1e-07);
float3 l9_12=float3(l9_9.x,l9_11,l9_10);
float3 hslOrig=l9_12;
float3 res=float3(0.0);
res.x=target.x;
res.y=target.y;
res.z=hslOrig.z;
float3 param_1=res;
float l9_13=param_1.x;
float l9_14=abs((6.0*l9_13)-3.0)-1.0;
float l9_15=2.0-abs((6.0*l9_13)-2.0);
float l9_16=2.0-abs((6.0*l9_13)-4.0);
float3 l9_17=fast::clamp(float3(l9_14,l9_15,l9_16),float3(0.0),float3(1.0));
float3 l9_18=l9_17;
float l9_19=(1.0-abs((2.0*param_1.z)-1.0))*param_1.y;
l9_18=((l9_18-float3(0.5))*l9_19)+float3(param_1.z);
float3 l9_20=l9_18;
res=l9_20;
float3 resColor=mix(original,res,float3(weight));
return resColor;
}
else
{
float3 tmpColor=float3(0.0);
float param_2=yValue;
float param_3=intMap;
float param_4=target.x;
tmpColor.x=transformSingleColor(param_2,param_3,param_4);
float param_5=yValue;
float param_6=intMap;
float param_7=target.y;
tmpColor.y=transformSingleColor(param_5,param_6,param_7);
float param_8=yValue;
float param_9=intMap;
float param_10=target.z;
tmpColor.z=transformSingleColor(param_8,param_9,param_10);
tmpColor=fast::clamp(tmpColor,float3(0.0),float3(1.0));
float3 resColor_1=mix(original,tmpColor,float3(weight));
return resColor_1;
}
}
float3 definedBlend(thread const float3& a,thread const float3& b,thread int& varStereoViewID,constant userUniformsObj& UserUniforms,thread texture2d<float> intensityTexture,thread sampler intensityTextureSmpSC)
{
if ((int(BLEND_MODE_LIGHTEN_tmp)!=0))
{
return fast::max(a,b);
}
else
{
if ((int(BLEND_MODE_DARKEN_tmp)!=0))
{
return fast::min(a,b);
}
else
{
if ((int(BLEND_MODE_DIVIDE_tmp)!=0))
{
return b/a;
}
else
{
if ((int(BLEND_MODE_AVERAGE_tmp)!=0))
{
return (a+b)*0.5;
}
else
{
if ((int(BLEND_MODE_SUBTRACT_tmp)!=0))
{
return fast::max((a+b)-float3(1.0),float3(0.0));
}
else
{
if ((int(BLEND_MODE_DIFFERENCE_tmp)!=0))
{
return abs(a-b);
}
else
{
if ((int(BLEND_MODE_NEGATION_tmp)!=0))
{
return float3(1.0)-abs((float3(1.0)-a)-b);
}
else
{
if ((int(BLEND_MODE_EXCLUSION_tmp)!=0))
{
return (a+b)-((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_OVERLAY_tmp)!=0))
{
float l9_0;
if (a.x<0.5)
{
l9_0=(2.0*a.x)*b.x;
}
else
{
l9_0=1.0-((2.0*(1.0-a.x))*(1.0-b.x));
}
float l9_1=l9_0;
float l9_2;
if (a.y<0.5)
{
l9_2=(2.0*a.y)*b.y;
}
else
{
l9_2=1.0-((2.0*(1.0-a.y))*(1.0-b.y));
}
float l9_3=l9_2;
float l9_4;
if (a.z<0.5)
{
l9_4=(2.0*a.z)*b.z;
}
else
{
l9_4=1.0-((2.0*(1.0-a.z))*(1.0-b.z));
}
return float3(l9_1,l9_3,l9_4);
}
else
{
if ((int(BLEND_MODE_SOFT_LIGHT_tmp)!=0))
{
return (((float3(1.0)-(b*2.0))*a)*a)+((a*2.0)*b);
}
else
{
if ((int(BLEND_MODE_HARD_LIGHT_tmp)!=0))
{
float l9_5;
if (b.x<0.5)
{
l9_5=(2.0*b.x)*a.x;
}
else
{
l9_5=1.0-((2.0*(1.0-b.x))*(1.0-a.x));
}
float l9_6=l9_5;
float l9_7;
if (b.y<0.5)
{
l9_7=(2.0*b.y)*a.y;
}
else
{
l9_7=1.0-((2.0*(1.0-b.y))*(1.0-a.y));
}
float l9_8=l9_7;
float l9_9;
if (b.z<0.5)
{
l9_9=(2.0*b.z)*a.z;
}
else
{
l9_9=1.0-((2.0*(1.0-b.z))*(1.0-a.z));
}
return float3(l9_6,l9_8,l9_9);
}
else
{
if ((int(BLEND_MODE_COLOR_DODGE_tmp)!=0))
{
float l9_10;
if (b.x==1.0)
{
l9_10=b.x;
}
else
{
l9_10=fast::min(a.x/(1.0-b.x),1.0);
}
float l9_11=l9_10;
float l9_12;
if (b.y==1.0)
{
l9_12=b.y;
}
else
{
l9_12=fast::min(a.y/(1.0-b.y),1.0);
}
float l9_13=l9_12;
float l9_14;
if (b.z==1.0)
{
l9_14=b.z;
}
else
{
l9_14=fast::min(a.z/(1.0-b.z),1.0);
}
return float3(l9_11,l9_13,l9_14);
}
else
{
if ((int(BLEND_MODE_COLOR_BURN_tmp)!=0))
{
float l9_15;
if (b.x==0.0)
{
l9_15=b.x;
}
else
{
l9_15=fast::max(1.0-((1.0-a.x)/b.x),0.0);
}
float l9_16=l9_15;
float l9_17;
if (b.y==0.0)
{
l9_17=b.y;
}
else
{
l9_17=fast::max(1.0-((1.0-a.y)/b.y),0.0);
}
float l9_18=l9_17;
float l9_19;
if (b.z==0.0)
{
l9_19=b.z;
}
else
{
l9_19=fast::max(1.0-((1.0-a.z)/b.z),0.0);
}
return float3(l9_16,l9_18,l9_19);
}
else
{
if ((int(BLEND_MODE_LINEAR_LIGHT_tmp)!=0))
{
float l9_20;
if (b.x<0.5)
{
l9_20=fast::max((a.x+(2.0*b.x))-1.0,0.0);
}
else
{
l9_20=fast::min(a.x+(2.0*(b.x-0.5)),1.0);
}
float l9_21=l9_20;
float l9_22;
if (b.y<0.5)
{
l9_22=fast::max((a.y+(2.0*b.y))-1.0,0.0);
}
else
{
l9_22=fast::min(a.y+(2.0*(b.y-0.5)),1.0);
}
float l9_23=l9_22;
float l9_24;
if (b.z<0.5)
{
l9_24=fast::max((a.z+(2.0*b.z))-1.0,0.0);
}
else
{
l9_24=fast::min(a.z+(2.0*(b.z-0.5)),1.0);
}
return float3(l9_21,l9_23,l9_24);
}
else
{
if ((int(BLEND_MODE_VIVID_LIGHT_tmp)!=0))
{
float l9_25;
if (b.x<0.5)
{
float l9_26;
if ((2.0*b.x)==0.0)
{
l9_26=2.0*b.x;
}
else
{
l9_26=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_25=l9_26;
}
else
{
float l9_27;
if ((2.0*(b.x-0.5))==1.0)
{
l9_27=2.0*(b.x-0.5);
}
else
{
l9_27=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_25=l9_27;
}
float l9_28=l9_25;
float l9_29;
if (b.y<0.5)
{
float l9_30;
if ((2.0*b.y)==0.0)
{
l9_30=2.0*b.y;
}
else
{
l9_30=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_29=l9_30;
}
else
{
float l9_31;
if ((2.0*(b.y-0.5))==1.0)
{
l9_31=2.0*(b.y-0.5);
}
else
{
l9_31=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_29=l9_31;
}
float l9_32=l9_29;
float l9_33;
if (b.z<0.5)
{
float l9_34;
if ((2.0*b.z)==0.0)
{
l9_34=2.0*b.z;
}
else
{
l9_34=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_33=l9_34;
}
else
{
float l9_35;
if ((2.0*(b.z-0.5))==1.0)
{
l9_35=2.0*(b.z-0.5);
}
else
{
l9_35=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_33=l9_35;
}
return float3(l9_28,l9_32,l9_33);
}
else
{
if ((int(BLEND_MODE_PIN_LIGHT_tmp)!=0))
{
float l9_36;
if (b.x<0.5)
{
l9_36=fast::min(a.x,2.0*b.x);
}
else
{
l9_36=fast::max(a.x,2.0*(b.x-0.5));
}
float l9_37=l9_36;
float l9_38;
if (b.y<0.5)
{
l9_38=fast::min(a.y,2.0*b.y);
}
else
{
l9_38=fast::max(a.y,2.0*(b.y-0.5));
}
float l9_39=l9_38;
float l9_40;
if (b.z<0.5)
{
l9_40=fast::min(a.z,2.0*b.z);
}
else
{
l9_40=fast::max(a.z,2.0*(b.z-0.5));
}
return float3(l9_37,l9_39,l9_40);
}
else
{
if ((int(BLEND_MODE_HARD_MIX_tmp)!=0))
{
float l9_41;
if (b.x<0.5)
{
float l9_42;
if ((2.0*b.x)==0.0)
{
l9_42=2.0*b.x;
}
else
{
l9_42=fast::max(1.0-((1.0-a.x)/(2.0*b.x)),0.0);
}
l9_41=l9_42;
}
else
{
float l9_43;
if ((2.0*(b.x-0.5))==1.0)
{
l9_43=2.0*(b.x-0.5);
}
else
{
l9_43=fast::min(a.x/(1.0-(2.0*(b.x-0.5))),1.0);
}
l9_41=l9_43;
}
float l9_44=l9_41;
float l9_45;
if (b.y<0.5)
{
float l9_46;
if ((2.0*b.y)==0.0)
{
l9_46=2.0*b.y;
}
else
{
l9_46=fast::max(1.0-((1.0-a.y)/(2.0*b.y)),0.0);
}
l9_45=l9_46;
}
else
{
float l9_47;
if ((2.0*(b.y-0.5))==1.0)
{
l9_47=2.0*(b.y-0.5);
}
else
{
l9_47=fast::min(a.y/(1.0-(2.0*(b.y-0.5))),1.0);
}
l9_45=l9_47;
}
float l9_48=l9_45;
float l9_49;
if (b.z<0.5)
{
float l9_50;
if ((2.0*b.z)==0.0)
{
l9_50=2.0*b.z;
}
else
{
l9_50=fast::max(1.0-((1.0-a.z)/(2.0*b.z)),0.0);
}
l9_49=l9_50;
}
else
{
float l9_51;
if ((2.0*(b.z-0.5))==1.0)
{
l9_51=2.0*(b.z-0.5);
}
else
{
l9_51=fast::min(a.z/(1.0-(2.0*(b.z-0.5))),1.0);
}
l9_49=l9_51;
}
return float3((l9_44<0.5) ? 0.0 : 1.0,(l9_48<0.5) ? 0.0 : 1.0,(l9_49<0.5) ? 0.0 : 1.0);
}
else
{
if ((int(BLEND_MODE_HARD_REFLECT_tmp)!=0))
{
float l9_52;
if (b.x==1.0)
{
l9_52=b.x;
}
else
{
l9_52=fast::min((a.x*a.x)/(1.0-b.x),1.0);
}
float l9_53=l9_52;
float l9_54;
if (b.y==1.0)
{
l9_54=b.y;
}
else
{
l9_54=fast::min((a.y*a.y)/(1.0-b.y),1.0);
}
float l9_55=l9_54;
float l9_56;
if (b.z==1.0)
{
l9_56=b.z;
}
else
{
l9_56=fast::min((a.z*a.z)/(1.0-b.z),1.0);
}
return float3(l9_53,l9_55,l9_56);
}
else
{
if ((int(BLEND_MODE_HARD_GLOW_tmp)!=0))
{
float l9_57;
if (a.x==1.0)
{
l9_57=a.x;
}
else
{
l9_57=fast::min((b.x*b.x)/(1.0-a.x),1.0);
}
float l9_58=l9_57;
float l9_59;
if (a.y==1.0)
{
l9_59=a.y;
}
else
{
l9_59=fast::min((b.y*b.y)/(1.0-a.y),1.0);
}
float l9_60=l9_59;
float l9_61;
if (a.z==1.0)
{
l9_61=a.z;
}
else
{
l9_61=fast::min((b.z*b.z)/(1.0-a.z),1.0);
}
return float3(l9_58,l9_60,l9_61);
}
else
{
if ((int(BLEND_MODE_HARD_PHOENIX_tmp)!=0))
{
return (fast::min(a,b)-fast::max(a,b))+float3(1.0);
}
else
{
if ((int(BLEND_MODE_HUE_tmp)!=0))
{
float3 param=a;
float3 param_1=b;
float3 l9_62=param;
float3 l9_63=l9_62;
float4 l9_64;
if (l9_63.y<l9_63.z)
{
l9_64=float4(l9_63.zy,-1.0,0.66666669);
}
else
{
l9_64=float4(l9_63.yz,0.0,-0.33333334);
}
float4 l9_65=l9_64;
float4 l9_66;
if (l9_63.x<l9_65.x)
{
l9_66=float4(l9_65.xyw,l9_63.x);
}
else
{
l9_66=float4(l9_63.x,l9_65.yzx);
}
float4 l9_67=l9_66;
float l9_68=l9_67.x-fast::min(l9_67.w,l9_67.y);
float l9_69=abs(((l9_67.w-l9_67.y)/((6.0*l9_68)+1e-07))+l9_67.z);
float l9_70=l9_67.x;
float3 l9_71=float3(l9_69,l9_68,l9_70);
float3 l9_72=l9_71;
float l9_73=l9_72.z-(l9_72.y*0.5);
float l9_74=l9_72.y/((1.0-abs((2.0*l9_73)-1.0))+1e-07);
float3 l9_75=float3(l9_72.x,l9_74,l9_73);
float3 l9_76=l9_75;
float3 l9_77=param_1;
float3 l9_78=l9_77;
float4 l9_79;
if (l9_78.y<l9_78.z)
{
l9_79=float4(l9_78.zy,-1.0,0.66666669);
}
else
{
l9_79=float4(l9_78.yz,0.0,-0.33333334);
}
float4 l9_80=l9_79;
float4 l9_81;
if (l9_78.x<l9_80.x)
{
l9_81=float4(l9_80.xyw,l9_78.x);
}
else
{
l9_81=float4(l9_78.x,l9_80.yzx);
}
float4 l9_82=l9_81;
float l9_83=l9_82.x-fast::min(l9_82.w,l9_82.y);
float l9_84=abs(((l9_82.w-l9_82.y)/((6.0*l9_83)+1e-07))+l9_82.z);
float l9_85=l9_82.x;
float3 l9_86=float3(l9_84,l9_83,l9_85);
float3 l9_87=l9_86;
float l9_88=l9_87.z-(l9_87.y*0.5);
float l9_89=l9_87.y/((1.0-abs((2.0*l9_88)-1.0))+1e-07);
float3 l9_90=float3(l9_87.x,l9_89,l9_88);
float3 l9_91=float3(l9_90.x,l9_76.y,l9_76.z);
float l9_92=l9_91.x;
float l9_93=abs((6.0*l9_92)-3.0)-1.0;
float l9_94=2.0-abs((6.0*l9_92)-2.0);
float l9_95=2.0-abs((6.0*l9_92)-4.0);
float3 l9_96=fast::clamp(float3(l9_93,l9_94,l9_95),float3(0.0),float3(1.0));
float3 l9_97=l9_96;
float l9_98=(1.0-abs((2.0*l9_91.z)-1.0))*l9_91.y;
l9_97=((l9_97-float3(0.5))*l9_98)+float3(l9_91.z);
float3 l9_99=l9_97;
float3 l9_100=l9_99;
return l9_100;
}
else
{
if ((int(BLEND_MODE_SATURATION_tmp)!=0))
{
float3 param_2=a;
float3 param_3=b;
float3 l9_101=param_2;
float3 l9_102=l9_101;
float4 l9_103;
if (l9_102.y<l9_102.z)
{
l9_103=float4(l9_102.zy,-1.0,0.66666669);
}
else
{
l9_103=float4(l9_102.yz,0.0,-0.33333334);
}
float4 l9_104=l9_103;
float4 l9_105;
if (l9_102.x<l9_104.x)
{
l9_105=float4(l9_104.xyw,l9_102.x);
}
else
{
l9_105=float4(l9_102.x,l9_104.yzx);
}
float4 l9_106=l9_105;
float l9_107=l9_106.x-fast::min(l9_106.w,l9_106.y);
float l9_108=abs(((l9_106.w-l9_106.y)/((6.0*l9_107)+1e-07))+l9_106.z);
float l9_109=l9_106.x;
float3 l9_110=float3(l9_108,l9_107,l9_109);
float3 l9_111=l9_110;
float l9_112=l9_111.z-(l9_111.y*0.5);
float l9_113=l9_111.y/((1.0-abs((2.0*l9_112)-1.0))+1e-07);
float3 l9_114=float3(l9_111.x,l9_113,l9_112);
float3 l9_115=l9_114;
float l9_116=l9_115.x;
float3 l9_117=param_3;
float3 l9_118=l9_117;
float4 l9_119;
if (l9_118.y<l9_118.z)
{
l9_119=float4(l9_118.zy,-1.0,0.66666669);
}
else
{
l9_119=float4(l9_118.yz,0.0,-0.33333334);
}
float4 l9_120=l9_119;
float4 l9_121;
if (l9_118.x<l9_120.x)
{
l9_121=float4(l9_120.xyw,l9_118.x);
}
else
{
l9_121=float4(l9_118.x,l9_120.yzx);
}
float4 l9_122=l9_121;
float l9_123=l9_122.x-fast::min(l9_122.w,l9_122.y);
float l9_124=abs(((l9_122.w-l9_122.y)/((6.0*l9_123)+1e-07))+l9_122.z);
float l9_125=l9_122.x;
float3 l9_126=float3(l9_124,l9_123,l9_125);
float3 l9_127=l9_126;
float l9_128=l9_127.z-(l9_127.y*0.5);
float l9_129=l9_127.y/((1.0-abs((2.0*l9_128)-1.0))+1e-07);
float3 l9_130=float3(l9_127.x,l9_129,l9_128);
float3 l9_131=float3(l9_116,l9_130.y,l9_115.z);
float l9_132=l9_131.x;
float l9_133=abs((6.0*l9_132)-3.0)-1.0;
float l9_134=2.0-abs((6.0*l9_132)-2.0);
float l9_135=2.0-abs((6.0*l9_132)-4.0);
float3 l9_136=fast::clamp(float3(l9_133,l9_134,l9_135),float3(0.0),float3(1.0));
float3 l9_137=l9_136;
float l9_138=(1.0-abs((2.0*l9_131.z)-1.0))*l9_131.y;
l9_137=((l9_137-float3(0.5))*l9_138)+float3(l9_131.z);
float3 l9_139=l9_137;
float3 l9_140=l9_139;
return l9_140;
}
else
{
if ((int(BLEND_MODE_COLOR_tmp)!=0))
{
float3 param_4=a;
float3 param_5=b;
float3 l9_141=param_5;
float3 l9_142=l9_141;
float4 l9_143;
if (l9_142.y<l9_142.z)
{
l9_143=float4(l9_142.zy,-1.0,0.66666669);
}
else
{
l9_143=float4(l9_142.yz,0.0,-0.33333334);
}
float4 l9_144=l9_143;
float4 l9_145;
if (l9_142.x<l9_144.x)
{
l9_145=float4(l9_144.xyw,l9_142.x);
}
else
{
l9_145=float4(l9_142.x,l9_144.yzx);
}
float4 l9_146=l9_145;
float l9_147=l9_146.x-fast::min(l9_146.w,l9_146.y);
float l9_148=abs(((l9_146.w-l9_146.y)/((6.0*l9_147)+1e-07))+l9_146.z);
float l9_149=l9_146.x;
float3 l9_150=float3(l9_148,l9_147,l9_149);
float3 l9_151=l9_150;
float l9_152=l9_151.z-(l9_151.y*0.5);
float l9_153=l9_151.y/((1.0-abs((2.0*l9_152)-1.0))+1e-07);
float3 l9_154=float3(l9_151.x,l9_153,l9_152);
float3 l9_155=l9_154;
float l9_156=l9_155.x;
float l9_157=l9_155.y;
float3 l9_158=param_4;
float3 l9_159=l9_158;
float4 l9_160;
if (l9_159.y<l9_159.z)
{
l9_160=float4(l9_159.zy,-1.0,0.66666669);
}
else
{
l9_160=float4(l9_159.yz,0.0,-0.33333334);
}
float4 l9_161=l9_160;
float4 l9_162;
if (l9_159.x<l9_161.x)
{
l9_162=float4(l9_161.xyw,l9_159.x);
}
else
{
l9_162=float4(l9_159.x,l9_161.yzx);
}
float4 l9_163=l9_162;
float l9_164=l9_163.x-fast::min(l9_163.w,l9_163.y);
float l9_165=abs(((l9_163.w-l9_163.y)/((6.0*l9_164)+1e-07))+l9_163.z);
float l9_166=l9_163.x;
float3 l9_167=float3(l9_165,l9_164,l9_166);
float3 l9_168=l9_167;
float l9_169=l9_168.z-(l9_168.y*0.5);
float l9_170=l9_168.y/((1.0-abs((2.0*l9_169)-1.0))+1e-07);
float3 l9_171=float3(l9_168.x,l9_170,l9_169);
float3 l9_172=float3(l9_156,l9_157,l9_171.z);
float l9_173=l9_172.x;
float l9_174=abs((6.0*l9_173)-3.0)-1.0;
float l9_175=2.0-abs((6.0*l9_173)-2.0);
float l9_176=2.0-abs((6.0*l9_173)-4.0);
float3 l9_177=fast::clamp(float3(l9_174,l9_175,l9_176),float3(0.0),float3(1.0));
float3 l9_178=l9_177;
float l9_179=(1.0-abs((2.0*l9_172.z)-1.0))*l9_172.y;
l9_178=((l9_178-float3(0.5))*l9_179)+float3(l9_172.z);
float3 l9_180=l9_178;
float3 l9_181=l9_180;
return l9_181;
}
else
{
if ((int(BLEND_MODE_LUMINOSITY_tmp)!=0))
{
float3 param_6=a;
float3 param_7=b;
float3 l9_182=param_6;
float3 l9_183=l9_182;
float4 l9_184;
if (l9_183.y<l9_183.z)
{
l9_184=float4(l9_183.zy,-1.0,0.66666669);
}
else
{
l9_184=float4(l9_183.yz,0.0,-0.33333334);
}
float4 l9_185=l9_184;
float4 l9_186;
if (l9_183.x<l9_185.x)
{
l9_186=float4(l9_185.xyw,l9_183.x);
}
else
{
l9_186=float4(l9_183.x,l9_185.yzx);
}
float4 l9_187=l9_186;
float l9_188=l9_187.x-fast::min(l9_187.w,l9_187.y);
float l9_189=abs(((l9_187.w-l9_187.y)/((6.0*l9_188)+1e-07))+l9_187.z);
float l9_190=l9_187.x;
float3 l9_191=float3(l9_189,l9_188,l9_190);
float3 l9_192=l9_191;
float l9_193=l9_192.z-(l9_192.y*0.5);
float l9_194=l9_192.y/((1.0-abs((2.0*l9_193)-1.0))+1e-07);
float3 l9_195=float3(l9_192.x,l9_194,l9_193);
float3 l9_196=l9_195;
float l9_197=l9_196.x;
float l9_198=l9_196.y;
float3 l9_199=param_7;
float3 l9_200=l9_199;
float4 l9_201;
if (l9_200.y<l9_200.z)
{
l9_201=float4(l9_200.zy,-1.0,0.66666669);
}
else
{
l9_201=float4(l9_200.yz,0.0,-0.33333334);
}
float4 l9_202=l9_201;
float4 l9_203;
if (l9_200.x<l9_202.x)
{
l9_203=float4(l9_202.xyw,l9_200.x);
}
else
{
l9_203=float4(l9_200.x,l9_202.yzx);
}
float4 l9_204=l9_203;
float l9_205=l9_204.x-fast::min(l9_204.w,l9_204.y);
float l9_206=abs(((l9_204.w-l9_204.y)/((6.0*l9_205)+1e-07))+l9_204.z);
float l9_207=l9_204.x;
float3 l9_208=float3(l9_206,l9_205,l9_207);
float3 l9_209=l9_208;
float l9_210=l9_209.z-(l9_209.y*0.5);
float l9_211=l9_209.y/((1.0-abs((2.0*l9_210)-1.0))+1e-07);
float3 l9_212=float3(l9_209.x,l9_211,l9_210);
float3 l9_213=float3(l9_197,l9_198,l9_212.z);
float l9_214=l9_213.x;
float l9_215=abs((6.0*l9_214)-3.0)-1.0;
float l9_216=2.0-abs((6.0*l9_214)-2.0);
float l9_217=2.0-abs((6.0*l9_214)-4.0);
float3 l9_218=fast::clamp(float3(l9_215,l9_216,l9_217),float3(0.0),float3(1.0));
float3 l9_219=l9_218;
float l9_220=(1.0-abs((2.0*l9_213.z)-1.0))*l9_213.y;
l9_219=((l9_219-float3(0.5))*l9_220)+float3(l9_213.z);
float3 l9_221=l9_219;
float3 l9_222=l9_221;
return l9_222;
}
else
{
float3 param_8=a;
float3 param_9=b;
float3 l9_223=param_8;
float l9_224=((0.29899999*l9_223.x)+(0.58700001*l9_223.y))+(0.114*l9_223.z);
float l9_225=l9_224;
float l9_226=1.0;
float l9_227=pow(l9_225,1.0/UserUniforms.correctedIntensity);
int l9_228=0;
if ((int(intensityTextureHasSwappedViews_tmp)!=0))
{
int l9_229=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_229=0;
}
else
{
l9_229=varStereoViewID;
}
int l9_230=l9_229;
l9_228=1-l9_230;
}
else
{
int l9_231=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_231=0;
}
else
{
l9_231=varStereoViewID;
}
int l9_232=l9_231;
l9_228=l9_232;
}
int l9_233=l9_228;
int l9_234=intensityTextureLayout_tmp;
int l9_235=l9_233;
float2 l9_236=float2(l9_227,0.5);
bool l9_237=(int(SC_USE_UV_TRANSFORM_intensityTexture_tmp)!=0);
float3x3 l9_238=UserUniforms.intensityTextureTransform;
int2 l9_239=int2(SC_SOFTWARE_WRAP_MODE_U_intensityTexture_tmp,SC_SOFTWARE_WRAP_MODE_V_intensityTexture_tmp);
bool l9_240=(int(SC_USE_UV_MIN_MAX_intensityTexture_tmp)!=0);
float4 l9_241=UserUniforms.intensityTextureUvMinMax;
bool l9_242=(int(SC_USE_CLAMP_TO_BORDER_intensityTexture_tmp)!=0);
float4 l9_243=UserUniforms.intensityTextureBorderColor;
float l9_244=0.0;
bool l9_245=l9_242&&(!l9_240);
float l9_246=1.0;
float l9_247=l9_236.x;
int l9_248=l9_239.x;
if (l9_248==1)
{
l9_247=fract(l9_247);
}
else
{
if (l9_248==2)
{
float l9_249=fract(l9_247);
float l9_250=l9_247-l9_249;
float l9_251=step(0.25,fract(l9_250*0.5));
l9_247=mix(l9_249,1.0-l9_249,fast::clamp(l9_251,0.0,1.0));
}
}
l9_236.x=l9_247;
float l9_252=l9_236.y;
int l9_253=l9_239.y;
if (l9_253==1)
{
l9_252=fract(l9_252);
}
else
{
if (l9_253==2)
{
float l9_254=fract(l9_252);
float l9_255=l9_252-l9_254;
float l9_256=step(0.25,fract(l9_255*0.5));
l9_252=mix(l9_254,1.0-l9_254,fast::clamp(l9_256,0.0,1.0));
}
}
l9_236.y=l9_252;
if (l9_240)
{
bool l9_257=l9_242;
bool l9_258;
if (l9_257)
{
l9_258=l9_239.x==3;
}
else
{
l9_258=l9_257;
}
float l9_259=l9_236.x;
float l9_260=l9_241.x;
float l9_261=l9_241.z;
bool l9_262=l9_258;
float l9_263=l9_246;
float l9_264=fast::clamp(l9_259,l9_260,l9_261);
float l9_265=step(abs(l9_259-l9_264),9.9999997e-06);
l9_263*=(l9_265+((1.0-float(l9_262))*(1.0-l9_265)));
l9_259=l9_264;
l9_236.x=l9_259;
l9_246=l9_263;
bool l9_266=l9_242;
bool l9_267;
if (l9_266)
{
l9_267=l9_239.y==3;
}
else
{
l9_267=l9_266;
}
float l9_268=l9_236.y;
float l9_269=l9_241.y;
float l9_270=l9_241.w;
bool l9_271=l9_267;
float l9_272=l9_246;
float l9_273=fast::clamp(l9_268,l9_269,l9_270);
float l9_274=step(abs(l9_268-l9_273),9.9999997e-06);
l9_272*=(l9_274+((1.0-float(l9_271))*(1.0-l9_274)));
l9_268=l9_273;
l9_236.y=l9_268;
l9_246=l9_272;
}
float2 l9_275=l9_236;
bool l9_276=l9_237;
float3x3 l9_277=l9_238;
if (l9_276)
{
l9_275=float2((l9_277*float3(l9_275,1.0)).xy);
}
float2 l9_278=l9_275;
float2 l9_279=l9_278;
float2 l9_280=l9_279;
l9_236=l9_280;
float l9_281=l9_236.x;
int l9_282=l9_239.x;
bool l9_283=l9_245;
float l9_284=l9_246;
if ((l9_282==0)||(l9_282==3))
{
float l9_285=l9_281;
float l9_286=0.0;
float l9_287=1.0;
bool l9_288=l9_283;
float l9_289=l9_284;
float l9_290=fast::clamp(l9_285,l9_286,l9_287);
float l9_291=step(abs(l9_285-l9_290),9.9999997e-06);
l9_289*=(l9_291+((1.0-float(l9_288))*(1.0-l9_291)));
l9_285=l9_290;
l9_281=l9_285;
l9_284=l9_289;
}
l9_236.x=l9_281;
l9_246=l9_284;
float l9_292=l9_236.y;
int l9_293=l9_239.y;
bool l9_294=l9_245;
float l9_295=l9_246;
if ((l9_293==0)||(l9_293==3))
{
float l9_296=l9_292;
float l9_297=0.0;
float l9_298=1.0;
bool l9_299=l9_294;
float l9_300=l9_295;
float l9_301=fast::clamp(l9_296,l9_297,l9_298);
float l9_302=step(abs(l9_296-l9_301),9.9999997e-06);
l9_300*=(l9_302+((1.0-float(l9_299))*(1.0-l9_302)));
l9_296=l9_301;
l9_292=l9_296;
l9_295=l9_300;
}
l9_236.y=l9_292;
l9_246=l9_295;
float2 l9_303=l9_236;
int l9_304=l9_234;
int l9_305=l9_235;
float l9_306=l9_244;
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
float4 l9_315=intensityTexture.sample(intensityTextureSmpSC,l9_313,bias(l9_314));
float4 l9_316=l9_315;
float4 l9_317=l9_316;
if (l9_242)
{
l9_317=mix(l9_243,l9_317,float4(l9_246));
}
float4 l9_318=l9_317;
float3 l9_319=l9_318.xyz;
float3 l9_320=l9_319;
float l9_321=16.0;
float l9_322=((((l9_320.x*256.0)+l9_320.y)+(l9_320.z/256.0))/257.00391)*l9_321;
float l9_323=l9_322;
if ((int(BLEND_MODE_FORGRAY_tmp)!=0))
{
l9_323=fast::max(l9_323,1.0);
}
if ((int(BLEND_MODE_NOTBRIGHT_tmp)!=0))
{
l9_323=fast::min(l9_323,1.0);
}
float l9_324=l9_225;
float3 l9_325=param_8;
float3 l9_326=param_9;
float l9_327=l9_226;
float l9_328=l9_323;
float3 l9_329=transformColor(l9_324,l9_325,l9_326,l9_327,l9_328);
return l9_329;
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
}
fragment main_frag_out main_frag(main_frag_in in [[stage_in]],constant sc_Set0& sc_set0 [[buffer(0)]],float4 gl_FragCoord [[position]])
{
main_frag_out out={};
float4 Output_Color0=float4(0.0);
float3 ngsTempNormal=float3(0.0);
float4 ngsTempTangent=float4(0.0);
if ((sc_StereoRenderingMode_tmp==1)&&(sc_StereoRendering_IsClipDistanceEnabled_tmp==0))
{
if (in.varClipDistance<0.0)
{
discard_fragment();
}
}
ngsTempNormal=in.varNormal;
ngsTempTangent=float4(in.varTangent.xyz.x,in.varTangent.xyz.y,in.varTangent.xyz.z,ngsTempTangent.w);
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
float l9_0;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_0=(*sc_set0.UserUniforms).overrideTimeElapsed;
}
else
{
l9_0=(*sc_set0.UserUniforms).sc_Time.x;
}
ssGlobals Globals;
Globals.gTimeElapsed=l9_0;
float l9_1;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_1=(*sc_set0.UserUniforms).overrideTimeDelta;
}
else
{
l9_1=fast::max((*sc_set0.UserUniforms).sc_Time.y,0.0);
}
Globals.gTimeDelta=l9_1;
Globals.gTimeElapsedShifted=(Globals.gTimeElapsed-(gParticle.TimeShift*Globals.gTimeDelta))-0.0;
Globals.VertexTangent_WorldSpace=normalize(ngsTempTangent.xyz);
Globals.VertexNormal_WorldSpace=normalize(ngsTempNormal);
Globals.VertexBinormal_WorldSpace=cross(Globals.VertexNormal_WorldSpace,Globals.VertexTangent_WorldSpace);
Globals.SurfacePosition_WorldSpace=in.varPos;
Globals.ViewDirWS=normalize((*sc_set0.UserUniforms).sc_Camera.position-Globals.SurfacePosition_WorldSpace);
int param=in.Interp_Particle_Index;
ssParticle param_1=gParticle;
param_1.Spawned=false;
param_1.Dead=false;
param_1.Force=float3(0.0);
param_1.Index1D=param;
param_1.Index1DPerCopy=param%40;
param_1.Index1DPerCopyF=float(param_1.Index1DPerCopy);
param_1.StateID=(40*((param/40)+1))-1;
int l9_2=param_1.Index1D;
int2 l9_3=int2(l9_2%40,l9_2/40);
param_1.Index2D=l9_3;
int l9_4=param_1.Index1D;
float l9_5=(float(l9_4)+0.5)/40.0;
param_1.Coord1D=l9_5;
int2 l9_6=param_1.Index2D;
float2 l9_7=(float2(l9_6)+float2(0.5))/float2(40.0,1.0);
param_1.Coord2D=l9_7;
int l9_8=param_1.Index1D;
float l9_9=float(l9_8)/39.0;
param_1.Ratio1D=l9_9;
int l9_10=param_1.Index1DPerCopy;
float l9_11=float(l9_10)/39.0;
param_1.Ratio1DPerCopy=l9_11;
int2 l9_12=param_1.Index2D;
float2 l9_13=float2(l9_12)/float2(39.0,1.0);
param_1.Ratio2D=l9_13;
param_1.Seed=0.0;
int l9_14=param_1.Index1D;
int l9_15=l9_14;
int l9_16=((l9_15*((l9_15*1471343)+101146501))+1559861749)&2147483647;
int l9_17=l9_16;
float l9_18=float(l9_17)*4.6566129e-10;
float l9_19=l9_18;
param_1.TimeShift=l9_19;
param_1.SpawnOffset=param_1.Ratio1D*0.2;
ssParticle l9_20=param_1;
float l9_21;
if ((*sc_set0.UserUniforms).overrideTimeEnabled==1)
{
l9_21=(*sc_set0.UserUniforms).overrideTimeElapsed;
}
else
{
l9_21=(*sc_set0.UserUniforms).sc_Time.x;
}
float l9_22=l9_21;
l9_20.Seed=(l9_20.Ratio1D*0.97637898)+0.151235;
l9_20.Seed+=(floor(((((l9_22-l9_20.SpawnOffset)-0.0)+0.0)+0.40000001)/0.2)*4.32723);
l9_20.Seed=fract(abs(l9_20.Seed));
int2 l9_23=int2(l9_20.Index1D%400,l9_20.Index1D/400);
l9_20.Seed2000=(float2(l9_23)+float2(1.0))/float2(399.0);
param_1=l9_20;
gParticle=param_1;
Globals.gTimeElapsedShifted=(Globals.gTimeElapsed-(gParticle.TimeShift*Globals.gTimeDelta))-0.0;
Output_Color0=gParticle.Color;
float Rim_N2=0.0;
float3 param_2=(*sc_set0.UserUniforms).Port_Normal_N002;
float param_3=(*sc_set0.UserUniforms).Port_Exponent_N002;
float param_4=(*sc_set0.UserUniforms).Port_Intensity_N002;
ssGlobals param_6=Globals;
param_2=float3x3(float3(param_6.VertexTangent_WorldSpace),float3(param_6.VertexBinormal_WorldSpace),float3(param_6.VertexNormal_WorldSpace))*param_2;
float l9_24=abs(dot(-param_6.ViewDirWS,param_2));
float param_5=pow(1.0-l9_24,param_3);
param_5=fast::max(param_5,0.0);
param_5*=param_4;
Rim_N2=param_5;
float3 Position_N3=float3(0.0);
Position_N3=Globals.SurfacePosition_WorldSpace;
float3 Camera_Position_N4=float3(0.0);
Camera_Position_N4=(*sc_set0.UserUniforms).sc_Camera.position;
float Output_N5=0.0;
Output_N5=distance(Position_N3,Camera_Position_N4);
float Output_N17=0.0;
Output_N17=Output_N5*(*sc_set0.UserUniforms).Port_Input1_N017;
float ValueOut_N18=0.0;
float param_7=Output_N17;
float param_9=(*sc_set0.UserUniforms).Port_RangeMinA_N018;
float param_10=(*sc_set0.UserUniforms).Port_RangeMaxA_N018;
float param_11=(*sc_set0.UserUniforms).Port_RangeMinB_N018;
float param_12=(*sc_set0.UserUniforms).Port_RangeMaxB_N018;
float param_8=(((param_7-param_9)/(param_10-param_9))*(param_12-param_11))+param_11;
float l9_25;
if (param_12>param_11)
{
l9_25=fast::clamp(param_8,param_11,param_12);
}
else
{
l9_25=fast::clamp(param_8,param_12,param_11);
}
param_8=l9_25;
ValueOut_N18=param_8;
float Output_N63=0.0;
Output_N63=(Rim_N2*(*sc_set0.UserUniforms).Port_Input1_N063)+ValueOut_N18;
float Output_N64=0.0;
Output_N64=1.0-Output_N63;
float Output_N65=0.0;
Output_N65=fast::clamp(Output_N64+0.001,(*sc_set0.UserUniforms).Port_Input1_N065+0.001,(*sc_set0.UserUniforms).Port_Input2_N065+0.001)-0.001;
float Value_N201=0.0;
Value_N201=fast::clamp(gParticle.Age/gParticle.Life,0.0,1.0);
float4 Output_N66=float4(0.0);
Output_N66=mix(float4(Output_N65),(*sc_set0.UserUniforms).Port_Input1_N066,float4(Value_N201));
float4 Value_N68=float4(0.0);
float param_13=Value_N201;
float4 param_14=(*sc_set0.UserUniforms).Port_Value0_N068;
float param_15=(*sc_set0.UserUniforms).Port_Position1_N068;
float4 param_16=(*sc_set0.UserUniforms).Port_Value1_N068;
float param_17=(*sc_set0.UserUniforms).Port_Position2_N068;
float4 param_18=(*sc_set0.UserUniforms).Port_Value2_N068;
float4 param_19=(*sc_set0.UserUniforms).Port_Value3_N068;
param_13=fast::clamp(param_13,0.0,1.0);
float4 param_20;
if (param_13<param_15)
{
param_20=mix(param_14,param_16,float4(fast::clamp(param_13/param_15,0.0,1.0)));
}
else
{
if (param_13<param_17)
{
param_20=mix(param_16,param_18,float4(fast::clamp((param_13-param_15)/(param_17-param_15),0.0,1.0)));
}
else
{
param_20=mix(param_18,param_19,float4(fast::clamp((param_13-param_17)/(1.0-param_17),0.0,1.0)));
}
}
Value_N68=param_20;
float4 Output_N79=float4(0.0);
Output_N79=Output_N66*Value_N68;
float Output_N67=0.0;
float l9_26;
if (Value_N201<=0.0)
{
l9_26=0.0;
}
else
{
l9_26=pow(Value_N201,(*sc_set0.UserUniforms).Port_Input1_N067);
}
Output_N67=l9_26;
float4 Value_N178=float4(0.0);
float param_21=Output_N67;
float4 param_22=(*sc_set0.UserUniforms).Port_Value0_N178;
float param_23=(*sc_set0.UserUniforms).Port_Position1_N178;
float4 param_24=(*sc_set0.UserUniforms).Port_Value1_N178;
float4 param_25=(*sc_set0.UserUniforms).Port_Value2_N178;
param_21=fast::clamp(param_21,0.0,1.0);
float4 param_26;
if (param_21<param_23)
{
param_26=mix(param_22,param_24,float4(fast::clamp(param_21/param_23,0.0,1.0)));
}
else
{
param_26=mix(param_24,param_25,float4(fast::clamp((param_21-param_23)/(1.0-param_23),0.0,1.0)));
}
Value_N178=param_26;
float4 Value_N98=float4(0.0);
Value_N98=float4(Output_N79.xyz.x,Output_N79.xyz.y,Output_N79.xyz.z,Value_N98.w);
Value_N98.w=Value_N178.x;
float4 param_27=Value_N98;
Output_Color0=param_27;
float4 param_28=Output_Color0;
if ((int(sc_RenderAlphaToColor_tmp)!=0))
{
param_28=float4(param_28.w);
}
else
{
if ((int(sc_BlendMode_Custom_tmp)!=0))
{
float4 l9_27=param_28;
float4 l9_28=float4(0.0);
float4 l9_29=float4(0.0);
if ((int(sc_FramebufferFetch_tmp)!=0))
{
float4 l9_30=out.FragColor0;
float4 l9_31=l9_30;
if ((int(sc_UseFramebufferFetchMarker_tmp)!=0))
{
l9_31.x+=(*sc_set0.UserUniforms)._sc_framebufferFetchMarker;
}
float4 l9_32=l9_31;
l9_29=l9_32;
}
else
{
float4 l9_33=gl_FragCoord;
float2 l9_34=l9_33.xy*(*sc_set0.UserUniforms).sc_CurrentRenderTargetDims.zw;
float2 l9_35=l9_34;
float2 l9_36=float2(0.0);
if (sc_StereoRenderingMode_tmp==1)
{
int l9_37=1;
int l9_38=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_38=0;
}
else
{
l9_38=in.varStereoViewID;
}
int l9_39=l9_38;
int l9_40=l9_39;
float3 l9_41=float3(l9_35,0.0);
int l9_42=l9_37;
int l9_43=l9_40;
if (l9_42==1)
{
l9_41.y=((2.0*l9_41.y)+float(l9_43))-1.0;
}
float2 l9_44=l9_41.xy;
l9_36=l9_44;
}
else
{
l9_36=l9_35;
}
float2 l9_45=l9_36;
float2 l9_46=l9_45;
float2 l9_47=l9_46;
int l9_48=0;
if ((int(sc_ScreenTextureHasSwappedViews_tmp)!=0))
{
int l9_49=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_49=0;
}
else
{
l9_49=in.varStereoViewID;
}
int l9_50=l9_49;
l9_48=1-l9_50;
}
else
{
int l9_51=0;
if (sc_StereoRenderingMode_tmp==0)
{
l9_51=0;
}
else
{
l9_51=in.varStereoViewID;
}
int l9_52=l9_51;
l9_48=l9_52;
}
int l9_53=l9_48;
float2 l9_54=l9_47;
int l9_55=l9_53;
float2 l9_56=l9_54;
int l9_57=l9_55;
float l9_58=0.0;
float4 l9_59=float4(0.0);
float2 l9_60=l9_56;
int l9_61=sc_ScreenTextureLayout_tmp;
int l9_62=l9_57;
float l9_63=l9_58;
float2 l9_64=l9_60;
int l9_65=l9_61;
int l9_66=l9_62;
float3 l9_67=float3(0.0);
if (l9_65==0)
{
l9_67=float3(l9_64,0.0);
}
else
{
if (l9_65==1)
{
l9_67=float3(l9_64.x,(l9_64.y*0.5)+(0.5-(float(l9_66)*0.5)),0.0);
}
else
{
l9_67=float3(l9_64,float(l9_66));
}
}
float3 l9_68=l9_67;
float3 l9_69=l9_68;
float2 l9_70=l9_69.xy;
float l9_71=l9_63;
float4 l9_72=sc_set0.sc_ScreenTexture.sample(sc_set0.sc_ScreenTextureSmpSC,l9_70,bias(l9_71));
float4 l9_73=l9_72;
l9_59=l9_73;
float4 l9_74=l9_59;
float4 l9_75=l9_74;
float4 l9_76=l9_75;
l9_29=l9_76;
}
float4 l9_77=l9_29;
float4 l9_78=l9_77;
float3 l9_79=l9_78.xyz;
float3 l9_80=l9_79;
float3 l9_81=l9_27.xyz;
float3 l9_82=definedBlend(l9_80,l9_81,in.varStereoViewID,(*sc_set0.UserUniforms),sc_set0.intensityTexture,sc_set0.intensityTextureSmpSC);
l9_28=float4(l9_82.x,l9_82.y,l9_82.z,l9_28.w);
float3 l9_83=mix(l9_79,l9_28.xyz,float3(l9_27.w));
l9_28=float4(l9_83.x,l9_83.y,l9_83.z,l9_28.w);
l9_28.w=1.0;
float4 l9_84=l9_28;
param_28=l9_84;
}
else
{
float4 l9_85=param_28;
float4 l9_86=float4(0.0);
if ((int(sc_BlendMode_MultiplyOriginal_tmp)!=0))
{
l9_86=float4(mix(float3(1.0),l9_85.xyz,float3(l9_85.w)),l9_85.w);
}
else
{
if ((int(sc_BlendMode_Screen_tmp)!=0)||(int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
float l9_87=l9_85.w;
if ((int(sc_BlendMode_PremultipliedAlphaAuto_tmp)!=0))
{
l9_87=fast::clamp(l9_87,0.0,1.0);
}
l9_86=float4(l9_85.xyz*l9_87,l9_87);
}
else
{
l9_86=l9_85;
}
}
float4 l9_88=l9_86;
param_28=l9_88;
}
}
float4 l9_89=param_28;
Output_Color0=l9_89;
float4 l9_90=float4(0.0);
if ((int(sc_ShaderComplexityAnalyzer_tmp)!=0))
{
l9_90=float4((*sc_set0.UserUniforms).shaderComplexityValue/255.0,0.0,0.0,1.0);
}
else
{
l9_90=float4(0.0);
}
float4 l9_91=l9_90;
float4 Cost=l9_91;
if (Cost.w>0.0)
{
Output_Color0=Cost;
}
float4 param_29=Output_Color0;
if (sc_ShaderCacheConstant_tmp!=0)
{
param_29.x+=((*sc_set0.UserUniforms).sc_UniformConstants.x*float(sc_ShaderCacheConstant_tmp));
}
out.FragColor0=param_29;
return out;
}
} // FRAGMENT SHADER
