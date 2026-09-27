shader_type canvas_item;
render_mode unshaded;

uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float thickness : hint_range(0.0, 20.0, 0.1) = 2.0;
uniform int sample_count : hint_range(4, 64, 4) = 16;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;


vec4 safe_tex(vec2 uv) {
    if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) {
        return vec4(0.0);
    }

    return textureLod(screen_texture, uv, 0.0);
}


void fragment() {

    // Get the combined image produced by the CanvasGroup
    vec4 sprite = textureLod(screen_texture, SCREEN_UV, 0.0);

    float outline = 0.0;

    float angle_step = 6.28318530718 / float(sample_count);

    for (int i = 0; i < sample_count; i++) {

        float angle = float(i) * angle_step;

        vec2 direction = vec2(
            cos(angle),
            sin(angle)
        );

        vec2 sample_uv =
            SCREEN_UV +
            direction * thickness * SCREEN_PIXEL_SIZE;

        float alpha =
            safe_tex(sample_uv).a;

        outline = max(outline, alpha);
    }

    // Only draw the outline outside the character
    float outline_alpha =
        outline * (1.0 - sprite.a);

    vec4 result = sprite;

    if (outline_alpha > 0.0) {
        result.rgb = mix(
            result.rgb,
            outline_color.rgb,
            outline_alpha
        );

        result.a = max(
            result.a,
            outline_alpha * outline_color.a
        );
    }

    COLOR = result;
}