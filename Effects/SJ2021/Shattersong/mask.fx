#define DECLARE_TEXTURE(Name, index) \
    texture2D Name: register(t##index); \
    sampler Name##Sampler: register(s##index)

#define SAMPLE_TEXTURE(Name, texCoord) tex2D(Name##Sampler, texCoord)

uniform float BlurStrength = 1.;
uniform float MaskStrength = 0.;

DECLARE_TEXTURE(blur, 0);
DECLARE_TEXTURE(mask, 1);

float4 PS_Mask(float2 uv : TEXCOORD0) : COLOR0{
    float4 mask = SAMPLE_TEXTURE(mask, uv);
    float4 blur = SAMPLE_TEXTURE(blur, uv);

    return (mask > 0) ? (blur * BlurStrength) + (mask * MaskStrength) : mask;
}

technique TestEffect {
	pass pass0 {
		PixelShader = compile ps_2_0 PS_Mask();
	}
}