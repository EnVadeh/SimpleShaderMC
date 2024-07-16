#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;
uniform int heldItemId;
uniform vec3 cameraPosition;
uniform vec3 eyePosition;
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform int worldTime;
vec3 EyeCameraPos = cameraPosition + gbufferModelViewInverse[3].xyz;


in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec4 shadowPos;
in vec4 terrainVertex;


#include "distort.glsl"

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;



void main() {

	color = texture(gtexture, texcoord) * glcolor;
	vec2 lm = lmcoord;
	if(shadowPos.w > 0.0)
		if(texture(shadowtex0, shadowPos.xy).r < shadowPos.z)
			lm.y*= 0.75;
	else
		lm.y = mix(31.0/32.0 * 0.75, 31.0/32.0, sqrt(shadowPos.w));
	color *= texture(lightmap, lm);
	vec3 torch_color = vec3(0.2, 0.1, 0.1);
	vec3 torch_held_color = vec3(0.2, 0.15, 0.15);
	vec3 redstone_torch_held = vec3(0.22, 0.1, 0.1);
	vec3 sky_color = vec3(-0.05, -0.05, -0.2);

	vec4 ViewCoords = gl_ModelViewMatrix * terrainVertex;
    vec4 EyePlayerCoords = gbufferModelViewInverse * ViewCoords;
	vec3 WorldCoords = EyePlayerCoords.xyz + EyeCameraPos;
	vec3 ApproxHandCoords = vec3(cameraPosition.x, cameraPosition.y, cameraPosition.z);
	float dist = distance(WorldCoords, ApproxHandCoords);
	//light map, x = sky or torch, vvice versa for y
	color = color + vec4(torch_color, 0)*lm.x;
	color = color + vec4(sky_color, 0)*lm.y;
	if(heldItemId == 1)
	{
		if(dist < 5)
		color += vec4(torch_held_color/(dist*1.4), 0.0);
		if(dist > 5 && dist < 10)
		color += vec4(torch_held_color/(dist*1.5), 0.0);
	}
		if(heldItemId == 2)
	{
		if(dist < 5)
		color += vec4(redstone_torch_held/(dist*1.4), 0.0);
		if(dist > 5 && dist < 10)
		color += vec4(redstone_torch_held/(dist*1.5), 0.0);
	}
	if (color.a < 0.1) 
		discard;
}