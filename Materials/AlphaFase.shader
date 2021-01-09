shader_type canvas_item;

uniform float alpha_fase_speed = 1;

void fragment() {
    float alpha_fase = abs(sin(TIME * alpha_fase_speed));
    COLOR.a *= alpha_fase;
}
