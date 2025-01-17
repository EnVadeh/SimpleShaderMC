#version 330 compatibility

out vec4 starData; //rgb = star color, a = flag for whether or not this pixel is a star.

void main() {
	gl_Position = ftransform();
    starData = vec4(gl_Color.rgb, float(gl_Color.r == gl_Color.g && gl_Color.g == gl_Color.b && gl_Color.r > 0.0));
}
