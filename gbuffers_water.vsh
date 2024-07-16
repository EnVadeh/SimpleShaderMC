#version 330 compatibility

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;

uniform float frameTimeCounter;

uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;


float getYValue(float x, float frequency, float amplitude, float offset)
{
    return amplitude * sin(x * frequency - offset * frequency);
}


void main() {

    float frequency = 0.9;
    float amplitudeY = 0.107;
    float amplitudeX = 0.05;
	
   // vec4 ModelCoords = vec4(gl_Vertex.x, gl_Vertex.y, gl_Vertex.z, 1.0);
    vec4 ViewCoords = gl_ModelViewMatrix * gl_Vertex;
    vec4 EyePlayerCoords = gbufferModelViewInverse * ViewCoords;
    vec3 EyeCameraPos = cameraPosition + gbufferModelViewInverse[3].xyz;
    vec3 WorldCoords = EyePlayerCoords.xyz + EyeCameraPos;
    float offsetY = getYValue(WorldCoords.x, frequency, amplitudeY, frameTimeCounter);
    //float offsetX = getYValue(WorldCoords.x, frequency, amplitudeX, frameTimeCounter);
    WorldCoords[1] += offsetY;
    //WorldCoords[0] += offsetX;
    EyePlayerCoords = vec4(WorldCoords, 1.0) - vec4(EyeCameraPos, 0.0);
    ViewCoords = gbufferModelView * EyePlayerCoords;
    vec4 ClipCoords = gl_ProjectionMatrix * ViewCoords;
    gl_Position = ClipCoords;
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}