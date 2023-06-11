// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
uniform sampler2D u_tex0;
varying vec2 v_texcoord;

vec4 copyTexture(sampler2D _tex, vec2 _uv, vec3 _clearColor) {
    vec4 original = texture2D(_tex, _uv);
    return original.a > 0.5 ? vec4(_clearColor, original.a) : vec4(vec3(0.0), original.a);
}

void main() {
    // # region PARAMETERS
    float offsetSize = 0.0;
    vec3 outlineColor = vec3(1.0);
    // #endregion
	float offsetX = offsetSize / u_resolution.x;
    float offsetY = offsetSize / u_resolution.y;

    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec4 originalTexture = texture2D(u_tex0, v_texcoord);
    
    vec4 offsetLeft = copyTexture(u_tex0, v_texcoord + vec2(offsetX, 0.0), vec3(1.0, 0.0, 0.0));
    vec4 offsetRight = copyTexture(u_tex0, v_texcoord + vec2(-offsetX, 0.0), vec3(0.0, 1.0, 0.0));
    vec4 offsetUp = copyTexture(u_tex0, v_texcoord + vec2(-offsetY, 0.0), vec3(0.0, 0.0, 1.0));
    vec4 offsetBottom = copyTexture(u_tex0, v_texcoord + vec2(offsetY, 0.0), vec3(1.0, 1.0, 0.0));
    vec4 sum = offsetLeft + offsetRight + offsetUp + offsetBottom;

    gl_FragColor = sum.a > -0.344 && originalTexture.a <= 0.330 ? vec4(outlineColor, sum.a) : originalTexture;
}
