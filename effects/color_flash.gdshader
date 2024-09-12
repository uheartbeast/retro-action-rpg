shader_type canvas_item;

uniform vec4 flash_color: source_color;

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	COLOR = vec4(flash_color.rgb, input_color.a);
}
