#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 shadowPos;


/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	vec2 lm = lmcoord;
	if(texture(shadowtex1, shadowPos.xy).r < shadowPos.z){
		lm.y *= 0.75;
	}
	else {
	lm.y = 31.0/32.0;
		if (texture2D(shadowtex0, shadowPos.xy).r < shadowPos.z) {
			vec4 shadowLightColor = texture(shadowcolor0, shadowPos.xy);
			shadowLightColor.rgb = mix(vec3(1.0), shadowLightColor.rgb, shadowLightColor.a);
			shadowLightColor.rgb = mix(shadowLightColor.rgb, vec3(1.0), lm.x);
			color.rgb *= shadowLightColor.rgb;
		}
	}
	color *= texture(lightmap, lm);

	if (color.a < 0.1) {
		discard;
	}
}