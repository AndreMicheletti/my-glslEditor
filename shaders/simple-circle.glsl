// Author: AndreMicheletti
// Title: Simple Circle

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// signed distance field Circle
float sdfCircle(vec2 st) {
    return distance(st, vec2(.5));
}

void main() {
    // #region PARAMETERS
    vec3 circleColor = vec3(1.000,0.257,0.005);
    float radius = 0.2;
    // #endregion
    
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;

    vec3 circle = vec3(sdfCircle(st));
    vec3 color = step(radius, circle).r == 0.0 ? circleColor : vec3(0.0);
    
    gl_FragColor = vec4(color,1.0);
}
