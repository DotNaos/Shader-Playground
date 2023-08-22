
#extension GL_OES_standard_derivatives : enable

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;
uniform vec2 u_mouse;

vec3 pallete (float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b*cos(6.28318*(c*t+d));
}

vec3 pallete(float t) 
{
    vec3 a = vec3(0.5);
    vec3 b = vec3(0.5);
    vec3 c = vec3(1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b*cos(6.28318*(c*t+d));
}

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;

    vec3 finalColor = vec3(0.0);

    float time = u_time * 0.1 + 0.25;
    // Show flowing lava
    uv0.y -= time * 0.1;

    // Create a grid of points
    vec2 grid = fract(uv0 * 5.0);

    // Draw a circle
    float circle = length(grid - 0.5) * 2.0;

    // Draw a square
    float square = max(abs(grid.x - 0.5), abs(grid.y - 0.5)) * 2.0;

    // Add to color
    finalColor += pallete(circle - square);

    gl_FragColor = vec4(finalColor,1.0);
}