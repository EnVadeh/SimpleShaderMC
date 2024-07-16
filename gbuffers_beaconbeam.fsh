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
	vec3 fragPos = vec3(vPos[0], vPos[1], vPos[2]);
	float dist = distance(viewPos, fragPos);
	if(dist < 5)
	{color.r = color.r * 2;
	color.b = color.b / 2;
	color.g = color.g / 2;
	}if (color.a < 0.1) {
		discard;
	}
}