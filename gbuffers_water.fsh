#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	color.r = 0;
	color.b = color.b /6;
	color.g = color.g /6;
	if (color.a < 0.1) {
		discard;
	}
}