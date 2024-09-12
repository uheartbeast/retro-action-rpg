class_name Flasher
extends Effector

var FLASH_MATERIAL = load("res://effects/color_flash.tres")

var previous_material: Material

func flash(duration: float = 0.2) -> void:
	assert(target is CanvasItem, "The target on your flasher isn't set.")
	if target.material != FLASH_MATERIAL:
		previous_material = target.material
	target.material = FLASH_MATERIAL
	await target.get_tree().create_timer(duration).timeout
	if is_instance_valid(target):
		target.material = previous_material

func set_color(color: Color) -> Flasher:
	FLASH_MATERIAL = FLASH_MATERIAL.duplicate() as ShaderMaterial
	FLASH_MATERIAL.set_shader_parameter("flash_color", color)
	return self
