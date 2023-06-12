// Author: AndreMicheletti
// Title: Glow Effect

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
    float glow_size = 0.5;
    vec3 glow_colour = vec3(1.0);
    float glow_intensity = 1.0;
    float glow_threshold = 0.5;
    // #endregion

    vec2 st = gl_FragCoord.xy / u_resolution;
    vec4 color = texture2D(u_tex0, v_texcoord);
    if (color.a <= glow_threshold) {
        vec2 size = st;
        float uv_x = v_texcoord.x;
        float uv_y = v_texcoord.y;

        float sum = 0.0;
        for (float n = 0.0; n < 9.0; ++n) {
            float offset = 0.05 * glow_size;
            float y = uv_y - ((n - 4.5) * offset);
            float h_sum = 0.0;
            h_sum += texture2D(u_tex0, vec2(uv_x - (4.0 * offset), y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x - (3.0 * offset), y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x - (2.0 * offset), y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x - offset, y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x, y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x + offset, y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x + (2.0 * offset), y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x + (3.0 * offset), y)).a;
            h_sum += texture2D(u_tex0, vec2(uv_x + (4.0 * offset), y)).a;
            sum += h_sum / 9.0;
        }

        color = vec4(glow_colour, (sum / 9.0) * glow_intensity);
    }

    gl_FragColor = color;
}
