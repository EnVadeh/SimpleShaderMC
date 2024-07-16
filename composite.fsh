#version 330 compatibility

uniform float viewWidth;
uniform float viewHeight;
uniform sampler2D colortex0;
uniform sampler2D gcolor;

/*
uniform float frameTimeCounter;
uniform vec3 cameraPosition;
uniform int heldItemId;
uniform vec3 eyePosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform int worldTime;
vec3 EyeCameraPos = cameraPosition + gbufferModelViewInverse[3].xyz;
*/
in vec2 texcoord;


uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;

/* DRAWBUFFERS:0 */

layout(location = 0) out vec4 color;

void main() {

	//color = texture(colortex0, texcoord);
	color = texture(gcolor, texcoord);

    //really shitty lighting lmao
	/*    if (heldItemId == 1)
    {
        vec3 torch_held_color = vec3(0.15, 0.1, 0.1);
        vec3 TorchCoord = vec3(0.74, -0.57, 0.0);
        float ndcx = ((2 * gl_FragCoord.x) / viewWidth) - 1;
        float ndcy = ((2 * gl_FragCoord.y) / viewHeight) - 1;
        vec3 ndc = vec3(ndcx, ndcy, 0);
        float dist = distance(TorchCoord, ndc);
        if (dist < 2.5)
            color += vec4(torch_held_color / ((dist + 1) * 4), 0.0);
    }
    if (heldItemId == 2)
    {
        vec3 redstone_torch_held = vec3(0.22, 0.1, 0.1);
        float ndcx = ((2 * gl_FragCoord.x) / viewWidth) - 1;
        float ndcy = ((2 * gl_FragCoord.y) / viewHeight) - 1;
        vec3 ndc = vec3(ndcx, ndcy, 0);
        vec3 TorchCoord = vec3(0.74, -0.57, 0.0);
        float dist = distance(TorchCoord, ndc);
        if (dist < 2.5)
            color += vec4(redstone_torch_held / ((dist + 1) * 4), 0.0);
    }*/
}