#version 330 compatibility

uniform sampler2D gtexture;
uniform vec3 cameraPosition;
uniform vec3 viewPos;

in vec2 texcoord;
in vec4 glcolor;
in vec4 vPos;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
if (color.a < 0.1) {
		discard;
	}
}