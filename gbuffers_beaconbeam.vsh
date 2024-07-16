#version 330 compatibility

out vec2 texcoord;
out vec4 glcolor;
out vec4 vPos;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	glcolor = gl_Color;
    vPos = gl_Position;

}