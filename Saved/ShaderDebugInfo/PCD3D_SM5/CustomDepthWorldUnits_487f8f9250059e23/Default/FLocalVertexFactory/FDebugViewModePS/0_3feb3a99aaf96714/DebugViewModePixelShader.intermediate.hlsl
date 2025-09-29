#pragma warning(disable : 3571) // pow() intrinsic suggested to be used with abs()
cbuffer View
{
    float4 View_View_InvDeviceZToWorldZTransform : packoffset(c78);
};

cbuffer InstancedView
{
    row_major float4x4 InstancedView_InstancedView_SVPositionToTranslatedWorld[2] : packoffset(c88);
    row_major float4x4 InstancedView_InstancedView_ScreenToRelativeWorld[2] : packoffset(c96);
    float3 InstancedView_InstancedView_ViewOriginHigh : packoffset(c144);
    float4 InstancedView_InstancedView_ViewRectMin[2] : packoffset(c292);
    float4 InstancedView_InstancedView_ViewSizeAndInvSize : packoffset(c294);
};

cbuffer DebugViewModePass
{
    float4 DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[5] : packoffset(c7);
    float4 DebugViewModePass_DebugViewModePass_DebugViewMode_LODColors[8] : packoffset(c12);
};

cbuffer Material
{
    float4 Material_Material_PreshaderBuffer[1] : packoffset(c0);
};

float4 CPUTexelFactor;
float4 NormalizedComplexity;
int2 AnalysisParams;
float PrimitiveAlpha;
int TexCoordAnalysisIndex;
float CPULogDistance;
uint bShowQuadOverdraw;
uint bOutputQuadOverdraw;
int LODIndex;
float3 SkinCacheDebugColor;
int VisualizeMode;

RWTexture2D<uint> DebugViewModePass_QuadOverdraw;

static uint gl_PrimitiveID;
static float4 gl_FragCoord;
static float4 in_var_TEXCOORD0;
static float4 in_var_TEXCOORD1;
static float4 in_var_TEXCOORD2;
static float3 in_var_TEXCOORD3;
static float3 in_var_TEXCOORD4;
static float3 in_var_TEXCOORD5;
static uint in_var_EYE_INDEX;
static float4 out_var_SV_Target0;

struct SPIRV_Cross_Input
{
    float4 in_var_TEXCOORD0 : TEXCOORD0;
    float4 in_var_TEXCOORD1 : TEXCOORD1;
    float4 in_var_TEXCOORD2 : TEXCOORD2;
    float3 in_var_TEXCOORD3 : TEXCOORD3;
    float3 in_var_TEXCOORD4 : TEXCOORD4;
    float3 in_var_TEXCOORD5 : TEXCOORD5;
    nointerpolation uint in_var_EYE_INDEX : EYE_INDEX;
    uint gl_PrimitiveID : SV_PrimitiveID;
    float4 gl_FragCoord : SV_Position;
};

struct SPIRV_Cross_Output
{
    float4 out_var_SV_Target0 : SV_Target0;
};

void frag_main()
{
    float4x4 _123 = InstancedView_InstancedView_ScreenToRelativeWorld[in_var_EYE_INDEX];
    float4 _705 = 0.0f.xxxx;
    [branch]
    if (((((VisualizeMode == 1) || (VisualizeMode == 2)) || (VisualizeMode == 3)) || (VisualizeMode == 4)) || (VisualizeMode == 13))
    {
        float3 _700 = 0.0f.xxx;
        if (bOutputQuadOverdraw != 0u)
        {
            float3 _614 = NormalizedComplexity.xyz;
            float3 _699 = 0.0f.xxx;
            [branch]
            if ((bShowQuadOverdraw != 0u) && (NormalizedComplexity.x > 0.0f))
            {
                uint2 _626 = uint2(gl_FragCoord.xy) / uint2(2u, 2u);
                uint _628 = 0u;
                int _631 = 0;
                _628 = 3u;
                _631 = 0;
                uint _629 = 0u;
                int _632 = 0;
                [loop]
                for (int _633 = 0; _633 < 24; _628 = _629, _631 = _632, _633++)
                {
                    uint _654 = 0u;
                    int _655 = 0;
                    [branch]
                    if (true && (_631 == 1))
                    {
                        uint4 _643 = DebugViewModePass_QuadOverdraw[_626].xxxx;
                        uint _644 = _643.x;
                        bool _647 = ((_644 >> 2u) - 1u) != uint(gl_PrimitiveID);
                        uint _652 = 0u;
                        [flatten]
                        if (_647)
                        {
                            _652 = _628;
                        }
                        else
                        {
                            _652 = _644 & 3u;
                        }
                        _654 = _652;
                        _655 = _647 ? (-1) : _631;
                    }
                    else
                    {
                        _654 = _628;
                        _655 = _631;
                    }
                    int _670 = 0;
                    [branch]
                    if (_655 == 2)
                    {
                        uint4 _660 = DebugViewModePass_QuadOverdraw[_626].xxxx;
                        uint _662 = _660.x & 3u;
                        uint _668 = 0u;
                        int _669 = 0;
                        [branch]
                        if (_662 == _654)
                        {
                            DebugViewModePass_QuadOverdraw[_626] = 0u;
                            _668 = _654;
                            _669 = -1;
                        }
                        else
                        {
                            _668 = _662;
                            _669 = _655;
                        }
                        _629 = _668;
                        _670 = _669;
                    }
                    else
                    {
                        _629 = _654;
                        _670 = _655;
                    }
                    [branch]
                    if (_670 == 0)
                    {
                        uint _677;
                        InterlockedCompareExchange(DebugViewModePass_QuadOverdraw[_626], 0u, (uint(gl_PrimitiveID) + 1u) << 2u, _677);
                        int _686 = 0;
                        [branch]
                        if (((_677 >> 2u) - 1u) == uint(gl_PrimitiveID))
                        {
                            uint _685;
                            InterlockedAdd(DebugViewModePass_QuadOverdraw[_626], 1u, _685);
                            _686 = 1;
                        }
                        else
                        {
                            _686 = (_677 == 0u) ? 2 : _670;
                        }
                        _632 = _686;
                    }
                    else
                    {
                        _632 = _670;
                    }
                }
                [branch]
                if (_631 == 2)
                {
                    DebugViewModePass_QuadOverdraw[_626] = 0u;
                }
                float3 _698 = _614;
                _698.x = NormalizedComplexity.x * (4.0f / float((_631 != (-2)) ? (1u + _628) : 0u));
                _699 = _698;
            }
            else
            {
                _699 = _614;
            }
            _700 = _699;
        }
        else
        {
            _700 = NormalizedComplexity.xyz;
        }
        _705 = float4(_700, 1.0f);
    }
    else
    {
        float4 _602 = 0.0f.xxxx;
        if (VisualizeMode == 5)
        {
            float3 _595 = 0.0f.xxx;
            if (CPULogDistance >= 0.0f)
            {
                float4 _572 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                float _581 = clamp(log2(max(1.0f, length(_572.xyz / _572.w.xxx))) - CPULogDistance, -1.9900000095367431640625f, 1.9900000095367431640625f);
                int _584 = int(floor(_581) + 2.0f);
                _595 = lerp(DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_584].xyz, DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_584 + 1].xyz, frac(_581).xxx);
            }
            else
            {
                _595 = 0.014999999664723873138427734375f.xxx;
            }
            _602 = float4(_595, PrimitiveAlpha);
        }
        else
        {
            float4 _562 = 0.0f.xxxx;
            if (VisualizeMode == 6)
            {
                float3 _555 = 0.0f.xxx;
                if (TexCoordAnalysisIndex >= 0)
                {
                    bool _475 = false;
                    float _492 = 0.0f;
                    do
                    {
                        _475 = TexCoordAnalysisIndex == 0;
                        [flatten]
                        if (_475)
                        {
                            _492 = CPUTexelFactor.x;
                            break;
                        }
                        [flatten]
                        if (TexCoordAnalysisIndex == 1)
                        {
                            _492 = CPUTexelFactor.y;
                            break;
                        }
                        [flatten]
                        if (TexCoordAnalysisIndex == 2)
                        {
                            _492 = CPUTexelFactor.z;
                            break;
                        }
                        _492 = CPUTexelFactor.w;
                        break;
                    } while(false);
                    float3 _554 = 0.0f.xxx;
                    if (_492 > 0.0f)
                    {
                        float4 _500 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _504 = _500.xyz / _500.w.xxx;
                        float2 _519 = 0.0f.xx;
                        do
                        {
                            [flatten]
                            if (_475)
                            {
                                _519 = in_var_TEXCOORD1.xy;
                                break;
                            }
                            [flatten]
                            if (TexCoordAnalysisIndex == 1)
                            {
                                _519 = in_var_TEXCOORD1.zw;
                                break;
                            }
                            [flatten]
                            if (TexCoordAnalysisIndex == 2)
                            {
                                _519 = in_var_TEXCOORD2.xy;
                                break;
                            }
                            _519 = in_var_TEXCOORD2.zw;
                            break;
                        } while(false);
                        float2 _520 = ddx_fine(_519);
                        float2 _521 = ddy_fine(_519);
                        float _540 = clamp(log2(_492) - log2(sqrt(length(cross(ddx_fine(_504), ddy_fine(_504))) / max(abs(mad(_520.x, _521.y, -(_520.y * _521.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        int _543 = int(floor(_540) + 2.0f);
                        _554 = lerp(DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_543].xyz, DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_543 + 1].xyz, frac(_540).xxx);
                    }
                    else
                    {
                        _554 = 0.014999999664723873138427734375f.xxx;
                    }
                    _555 = _554;
                }
                else
                {
                    float _325 = 0.0f;
                    float _326 = 0.0f;
                    if (CPUTexelFactor.x > 0.0f)
                    {
                        float4 _296 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _300 = _296.xyz / _296.w.xxx;
                        float2 _302 = ddx_fine(in_var_TEXCOORD1.xy);
                        float2 _303 = ddy_fine(in_var_TEXCOORD1.xy);
                        float _322 = clamp(log2(CPUTexelFactor.x) - log2(sqrt(length(cross(ddx_fine(_300), ddy_fine(_300))) / max(abs(mad(_302.x, _303.y, -(_302.y * _303.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _325 = max(_322, -1024.0f);
                        _326 = min(_322, 1024.0f);
                    }
                    else
                    {
                        _325 = -1024.0f;
                        _326 = 1024.0f;
                    }
                    float _365 = 0.0f;
                    float _366 = 0.0f;
                    if (CPUTexelFactor.y > 0.0f)
                    {
                        float4 _336 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _340 = _336.xyz / _336.w.xxx;
                        float2 _342 = ddx_fine(in_var_TEXCOORD1.zw);
                        float2 _343 = ddy_fine(in_var_TEXCOORD1.zw);
                        float _362 = clamp(log2(CPUTexelFactor.y) - log2(sqrt(length(cross(ddx_fine(_340), ddy_fine(_340))) / max(abs(mad(_342.x, _343.y, -(_342.y * _343.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _365 = max(_362, _325);
                        _366 = min(_362, _326);
                    }
                    else
                    {
                        _365 = _325;
                        _366 = _326;
                    }
                    float _405 = 0.0f;
                    float _406 = 0.0f;
                    if (CPUTexelFactor.z > 0.0f)
                    {
                        float4 _376 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _380 = _376.xyz / _376.w.xxx;
                        float2 _382 = ddx_fine(in_var_TEXCOORD2.xy);
                        float2 _383 = ddy_fine(in_var_TEXCOORD2.xy);
                        float _402 = clamp(log2(CPUTexelFactor.z) - log2(sqrt(length(cross(ddx_fine(_380), ddy_fine(_380))) / max(abs(mad(_382.x, _383.y, -(_382.y * _383.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _405 = max(_402, _365);
                        _406 = min(_402, _366);
                    }
                    else
                    {
                        _405 = _365;
                        _406 = _366;
                    }
                    float _445 = 0.0f;
                    float _446 = 0.0f;
                    if (CPUTexelFactor.w > 0.0f)
                    {
                        float4 _416 = mul(float4(gl_FragCoord.xyz, 1.0f), InstancedView_InstancedView_SVPositionToTranslatedWorld[in_var_EYE_INDEX]);
                        float3 _420 = _416.xyz / _416.w.xxx;
                        float2 _422 = ddx_fine(in_var_TEXCOORD2.zw);
                        float2 _423 = ddy_fine(in_var_TEXCOORD2.zw);
                        float _442 = clamp(log2(CPUTexelFactor.w) - log2(sqrt(length(cross(ddx_fine(_420), ddy_fine(_420))) / max(abs(mad(_422.x, _423.y, -(_422.y * _423.x))), 1.0000000133514319600180897396058e-10f))), -1.9900000095367431640625f, 1.9900000095367431640625f);
                        _445 = max(_442, _405);
                        _446 = min(_442, _406);
                    }
                    else
                    {
                        _445 = _405;
                        _446 = _406;
                    }
                    int2 _448 = int2(gl_FragCoord.xy);
                    float _454 = ((_448.x & 8) == (_448.y & 8)) ? _446 : _445;
                    float3 _472 = 0.0f.xxx;
                    if (abs(_454) != 1024.0f)
                    {
                        int _461 = int(floor(_454) + 2.0f);
                        _472 = lerp(DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_461].xyz, DebugViewModePass_DebugViewModePass_DebugViewMode_AccuracyColors[_461 + 1].xyz, frac(_454).xxx);
                    }
                    else
                    {
                        _472 = 0.014999999664723873138427734375f.xxx;
                    }
                    _555 = _472;
                }
                _562 = float4(_555, PrimitiveAlpha);
            }
            else
            {
                float4 _280 = 0.0f.xxxx;
                if ((VisualizeMode == 7) || (VisualizeMode == 8))
                {
                    float4 _279 = 0.0f.xxxx;
                    if (AnalysisParams.y != 0)
                    {
                        _279 = 256.0f.xxxx;
                    }
                    else
                    {
                        _279 = float4(0.0f, 0.0f, 0.0f, PrimitiveAlpha);
                    }
                    _280 = _279;
                }
                else
                {
                    float4 _269 = 0.0f.xxxx;
                    if ((VisualizeMode == 9) || (VisualizeMode == 10))
                    {
                        _269 = float4(0.0f, 0.0f, 0.0f, PrimitiveAlpha);
                    }
                    else
                    {
                        float4 _265 = 0.0f.xxxx;
                        if (VisualizeMode == 11)
                        {
                            float3 _239 = _123[3].xyz + InstancedView_InstancedView_ViewOriginHigh;
                            float4x4 _241 = _123;
                            _241[3] = float4(_239.x, _239.y, _239.z, _123[3].w);
                            _265 = float4(DebugViewModePass_DebugViewModePass_DebugViewMode_LODColors[LODIndex].xyz * mad(0.949999988079071044921875f, dot(max(lerp((length(-((View_View_InvDeviceZToWorldZTransform.y + ((-1.0f) / View_View_InvDeviceZToWorldZTransform.w)).xxx * mul(float4(mad((gl_FragCoord.xy - InstancedView_InstancedView_ViewRectMin[in_var_EYE_INDEX].xy) * InstancedView_InstancedView_ViewSizeAndInvSize.zw, 2.0f.xx, (-1.0f).xx), 1.0f, 0.0f), _241).xyz)) * 0.00999999977648258209228515625f).xxx, Material_Material_PreshaderBuffer[0].yzw, Material_Material_PreshaderBuffer[0].x.xxx), 0.0f.xxx), float3(0.2126390039920806884765625f, 0.715168654918670654296875f, 0.072192318737506866455078125f)), 0.0500000007450580596923828125f), 1.0f);
                        }
                        else
                        {
                            float4 _216 = 0.0f.xxxx;
                            if (VisualizeMode == 12)
                            {
                                float3 _190 = _123[3].xyz + InstancedView_InstancedView_ViewOriginHigh;
                                float4x4 _192 = _123;
                                _192[3] = float4(_190.x, _190.y, _190.z, _123[3].w);
                                _216 = float4(SkinCacheDebugColor * mad(0.949999988079071044921875f, dot(max(lerp((length(-((View_View_InvDeviceZToWorldZTransform.y + ((-1.0f) / View_View_InvDeviceZToWorldZTransform.w)).xxx * mul(float4(mad((gl_FragCoord.xy - InstancedView_InstancedView_ViewRectMin[in_var_EYE_INDEX].xy) * InstancedView_InstancedView_ViewSizeAndInvSize.zw, 2.0f.xx, (-1.0f).xx), 1.0f, 0.0f), _192).xyz)) * 0.00999999977648258209228515625f).xxx, Material_Material_PreshaderBuffer[0].yzw, Material_Material_PreshaderBuffer[0].x.xxx), 0.0f.xxx), float3(0.2126390039920806884765625f, 0.715168654918670654296875f, 0.072192318737506866455078125f)), 0.0500000007450580596923828125f), 1.0f);
                            }
                            else
                            {
                                _216 = float4(1.0f, 0.0f, 1.0f, 1.0f);
                            }
                            _265 = _216;
                        }
                        _269 = _265;
                    }
                    _280 = _269;
                }
                _562 = _280;
            }
            _602 = _562;
        }
        _705 = _602;
    }
    out_var_SV_Target0 = _705;
}

[earlydepthstencil]
SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
{
    gl_PrimitiveID = stage_input.gl_PrimitiveID;
    gl_FragCoord = stage_input.gl_FragCoord;
    gl_FragCoord.w = 1.0 / gl_FragCoord.w;
    in_var_TEXCOORD0 = stage_input.in_var_TEXCOORD0;
    in_var_TEXCOORD1 = stage_input.in_var_TEXCOORD1;
    in_var_TEXCOORD2 = stage_input.in_var_TEXCOORD2;
    in_var_TEXCOORD3 = stage_input.in_var_TEXCOORD3;
    in_var_TEXCOORD4 = stage_input.in_var_TEXCOORD4;
    in_var_TEXCOORD5 = stage_input.in_var_TEXCOORD5;
    in_var_EYE_INDEX = stage_input.in_var_EYE_INDEX;
    frag_main();
    SPIRV_Cross_Output stage_output;
    stage_output.out_var_SV_Target0 = out_var_SV_Target0;
    return stage_output;
}
