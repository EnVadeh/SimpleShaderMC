#version 330 compatibility

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
uniform vec3 shadowLightPosition;

#include "distort.glsl"

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 shadowPos;

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
    vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
    vec4 playerPos = gbufferModelViewInverse * viewPos;
    shadowPos = (shadowProjection * (shadowModelView * playerPos)).xyz;
    float bias = computeBias(shadowPos);
    shadowPos = distort(shadowPos); //apply shadow distortion.
    shadowPos = shadowPos * 0.5 + 0.5; //convert from shadow ndc space to shadow screen space.
    shadowPos.z -= bias; //apply shadow bias.
	
    gl_Position = gl_ProjectionMatrix * viewPos;
}