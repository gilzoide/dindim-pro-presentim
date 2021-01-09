shader_type canvas_item;

uniform float width = 1;
uniform vec4 outline_color : hint_color = vec4(1);

bool maybe_outline(sampler2D tex, vec2 uv, vec2 texture_pixel_size) {
    vec2 unit = texture_pixel_size * width;
    bool is_outline = false;
    float ceil_width = ceil(width);
	for (float x = -ceil_width; !is_outline && x <= ceil_width; x++) {
		for (float y = -ceil_width; !is_outline && y <= ceil_width; y++) {
			is_outline = texture(tex, uv + vec2(x*unit.x, y*unit.y)).a > 0.0;
		}
	}
    return is_outline;
}

void fragment() {
    vec4 texel = texture(TEXTURE, UV);
    bool is_outline = (texel.a < 1.0) && maybe_outline(TEXTURE, UV, TEXTURE_PIXEL_SIZE);
    vec4 color = vec4(outline_color.rgb, float(is_outline) * outline_color.a);
    COLOR = mix(color, texel, texel.a);
}
