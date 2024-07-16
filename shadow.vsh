#version 330 compatibility

in vec2 mc_Entity;
out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;

#include "distort.glsl"

void main()
{
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor = gl_Color;
    if (mc_Entity.x == 1 || mc_Entity == 2)
    {
        gl_Position = vec4(10.0);
    }
    else
    {
        gl_Position = ftransform();
        gl_Position.xyz = distort(gl_Position.xyz);
    }
}