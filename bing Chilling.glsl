
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

    return a + b*cos(2.28318*(c*t+d));
}

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution.xy) / u_resolution.y;
    vec2 uv0 = uv;

    // Distance to TopRight
    vec2 topRight = vec2(1.0) - uv0;

    vec3 finalColor = vec3(0.0);

    float time = u_time * .5;

    vec2 d = vec2(length(topRight));
    d = normalize(d);

    float r = length(d);

    // Angle to TopRight
    float a = atan(topRight.y, topRight.x);

    // Only show pixels every 45 degrees
    float threshold = 0.1;
    float angle = mod(a, threshold);
    a = abs(angle - threshold * 0.5);
    a = smoothstep(0.0, threshold, a);
     
    finalColor += pallete((d.x * d.y) * a * u_time*3.0 + 2.0) * 2.0;
 
    gl_FragColor = vec4(finalColor,1.0);
}