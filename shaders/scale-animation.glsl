// Author: AndreMicheletti
// Title: Scale Animation

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_tex0;
varying vec2 v_texcoord;

void main() {
    // # region PARAMETERS
    float scaleMin = 0.8;
    float scaleMax = 1.0;
    // #endregion
    
    float diff = scaleMax - scaleMin;
    float curr = scaleMin +  (0.5 + cos(u_time) / 2.0) * diff;
    float scale = 1.0 / curr;
    vec2 st = gl_FragCoord.xy / u_resolution.xy;
    vec2 offset = vec2(0.5 * (scale - 1.0));
    vec4 originalTexture = texture2D(u_tex0, v_texcoord * vec2(scale) - offset);

    gl_FragColor = originalTexture;
}
