#version 330 compatibility

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;


uniform sampler2D gtexture;

layout(location = 0) out vec4 color;

void main(){
	vec4 color = texture(gtexture, texcoord) * glcolor;
}