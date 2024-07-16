#version 330 compatibility
//Sun rays
uniform sampler2D gtexture;
uniform vec3 sunPosition;

in vec2 texcoord;
in vec4 glcolor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;

void main() {
	vec4 sunPos = vec4(sunPosition, 1.0);
	vec4 cSunPos = gl_ProjectionMatrix * sunPos;
	color = texture(gtexture, texcoord) * glcolor;
	if (color.a < 0.1) {
		discard;
	}
}