class_name Flasher
extends RefCounted

var FLASH_MATERIAL = load("res://effects/color_flash.tres")

var target: CanvasItem : set = set_target
var previous_material: Material

func set_target(value: CanvasItem) -> Flasher:
	target = value
	return self

func flash(duration: float = 0.2) -> void:
	assert(target is CanvasItem, "The target on your flasher isn't set.")
	if target.material != FLASH_MATERIAL:
		previous_material = target.material
	target.material = FLASH_MATERIAL
	await target.get_tree().create_timer(duration).timeout
	if is_instance_valid(target):
		target.material = previous_material
