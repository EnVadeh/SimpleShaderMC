#version 330 compatibility

in vec2 mc_Entity;
in vec4 at_midBlock;
out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec4 terrainVertex;
out vec4 shadowPos;

uniform float frameTimeCounter;
uniform mat4 gbufferModelViewInverse;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelView;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
uniform vec3 shadowLightPosition;

#include "distort.glsl"


float getOffsetValue(float x, float frequency, float amplitude, float offset)
{
    return amplitude * sin(x * frequency - offset * frequency);
}


void main() {
    
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor = gl_Color;
    float lightDot = dot(normalize(shadowLightPosition), normalize(gl_NormalMatrix * gl_Normal));
    if (mc_Entity.x == 1) 
        lightDot == 1.0;
    vec4 ViewCoords = gl_ModelViewMatrix * gl_Vertex;
    
    if (lightDot > 0)
    {
        vec4 playerPos = gbufferModelViewInverse * ViewCoords;
        shadowPos = shadowProjection * (shadowModelView * playerPos);
        float bias = computeBias(shadowPos.xyz);
        shadowPos.xyz = distort(shadowPos.xyz);
        shadowPos.xyz = shadowPos.xyz * 0.5 + 0.5;
        vec4 normal = shadowProjection * vec4(mat3(shadowModelView) * (mat3(gbufferModelViewInverse) * (gl_NormalMatrix * gl_Normal)), 1.0);
        shadowPos.xyz += normal.xyz / normal.w * bias;
    }
        else
    {
        lmcoord.y *= 0.75;
        shadowPos = vec4(0.0);
    }
    shadowPos.w = lightDot;
    if (mc_Entity.x == 1 && at_midBlock.y < 1)
    {
        float frequency = 0.7;
        float amplitude = 0.04;
        float amplitudeY = 0.014;
        vec4 EyePlayerCoords = gbufferModelViewInverse * ViewCoords;
        vec3 EyeCameraPos = cameraPosition + gbufferModelViewInverse[3].xyz;
        vec3 WorldCoords = EyePlayerCoords.xyz + EyeCameraPos;
        float offsetY = getOffsetValue(WorldCoords.x, frequency, amplitudeY, frameTimeCounter);
        float offsetX = getOffsetValue(WorldCoords.y, frequency, amplitude, frameTimeCounter);
        float offsetZ = getOffsetValue(WorldCoords.x, frequency, amplitude, frameTimeCounter);
        WorldCoords[1] += offsetY;
        WorldCoords[0] += offsetX;
        WorldCoords[2] += offsetZ;
        EyePlayerCoords = vec4(WorldCoords, 1.0) - vec4(EyeCameraPos, 0.0);
        ViewCoords = gbufferModelView * EyePlayerCoords;
        vec4 ClipCoords = gl_ProjectionMatrix * ViewCoords;
        gl_Position = ClipCoords;

    }
    else if (mc_Entity.x == 2 && at_midBlock.y < 0)
    {
        float frequency = 0.85;
        float amplitudeXZ = 0.04;
        vec4 EyePlayerCoords = gbufferModelViewInverse * ViewCoords;
        vec3 EyeCameraPos = cameraPosition + gbufferModelViewInverse[3].xyz;
        vec3 WorldCoords = EyePlayerCoords.xyz + EyeCameraPos;
        float offsetX = getOffsetValue(WorldCoords.y, frequency, amplitudeXZ, frameTimeCounter);
        float offsetZ = getOffsetValue(WorldCoords.x, frequency, amplitudeXZ, frameTimeCounter);
        WorldCoords[0] += (offsetX + offsetX * WorldCoords[1] * 0.03 * (0 - at_midBlock.y/64));
        WorldCoords[2] += (offsetZ + offsetZ * WorldCoords[1] * 0.03 * (0 - at_midBlock.y/64));
        EyePlayerCoords = vec4(WorldCoords, 1.0) - vec4(EyeCameraPos, 0.0);
        ViewCoords = gbufferModelView * EyePlayerCoords;
        vec4 ClipCoords = gl_ProjectionMatrix * ViewCoords;
        gl_Position = ClipCoords;

    }
    else if (mc_Entity.x == 3)
    {
        float frequency = 0.85;
        float amplitudeXZ = 0.018;
        vec4 EyePlayerCoords = gbufferModelViewInverse * ViewCoords;
        vec3 EyeCameraPos = cameraPosition + gbufferModelViewInverse[3].xyz;
        vec3 WorldCoords = EyePlayerCoords.xyz + EyeCameraPos;
        float offsetX = getOffsetValue(WorldCoords.y, frequency, amplitudeXZ, frameTimeCounter);
        float offsetZ = getOffsetValue(WorldCoords.x, frequency, amplitudeXZ, frameTimeCounter);
        WorldCoords[0] += offsetX;
        WorldCoords[2] += offsetZ;
        EyePlayerCoords = vec4(WorldCoords, 1.0) - vec4(EyeCameraPos, 0.0);
        ViewCoords = gbufferModelView * EyePlayerCoords;
        vec4 ClipCoords = gl_ProjectionMatrix * ViewCoords;
        gl_Position = ClipCoords;
    }
    
	else
	gl_Position = ftransform();
    terrainVertex = gl_Vertex;
}