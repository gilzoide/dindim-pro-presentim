shader_type canvas_item;

const int width = 1;

uniform vec4 outline_color : hint_color = vec4(1);
uniform float outline_neighbour_alpha_threshold = 0.1;

bool maybe_outline(sampler2D tex, vec2 uv, vec2 texture_pixel_size) {
    vec2 uv_offset = texture_pixel_size * float(width);
    bool is_outline = false;
	for (int x = -width; x <= width; x++) {
		for (int y = -width; y <= width; y++) {
			is_outline = is_outline || texture(tex, uv + vec2(float(x), float(y)) * uv_offset).a > outline_neighbour_alpha_threshold;
		}
	}
    return is_outline;
}

void fragment() {
    vec4 texel = texture(TEXTURE, UV);
    bool is_outline = (texel.a < 1.0) && maybe_outline(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
    vec4 color = outline_color;
    color.a *= float(is_outline);
    COLOR = mix(color, texel, texel.a);
}
