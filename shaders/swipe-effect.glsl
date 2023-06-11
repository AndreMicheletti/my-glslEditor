// Author: AndreMicheletti
// Title: Swipe Effect

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
    float shineSize = 0.2;
    float speedScale = 1.0;
    vec3 shineTint = vec3(1.0, 1.0, 1.0);
    float direction = 3.0;
    // 1 = horizontal
    // 2 = vertical
    // 3 = diagonal
    bool inverse = false;
    // #endregion

    vec4 originalTexture = texture2D(u_tex0, v_texcoord);
    float line = 0.0;

    float animation = inverse ? cos(u_time * speedScale) : sin(u_time * speedScale);
    vec2 offset = vec2(animation * u_resolution.x, animation * u_resolution.y);
    if (direction == 3.0) offset = vec2(animation * u_resolution.x, 0.0);
    vec2 coords = gl_FragCoord.xy + offset;
    vec2 st = coords / u_resolution.xy;

    float y = abs(st.x - 0.5);
    if (direction == 2.0) y = abs(0.5 - st.y);
    if (direction == 3.0) y = inverse ? abs(1.0 - st.y - st.x) : abs(st.y - st.x);
    line = smoothstep(shineSize, 0.0, y);
    
    originalTexture.r += shineTint.r * line;
    originalTexture.g += shineTint.g * line;
    originalTexture.b += shineTint.b * line;

    // gl_FragColor = vec4(vec3(line), 1.0);
    gl_FragColor = originalTexture;
}
