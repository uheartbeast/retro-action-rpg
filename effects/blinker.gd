class_name Blinker
extends Effector

func blink(duration: float = 1.0, blinks: int = 8) -> void:
	assert(target is CanvasItem, "The target on your blinker isn't set.")
	
	var blink_duration = duration / blinks
	for i in blinks:
		if not is_instance_valid(target): return
		target.visible = not target.visible
		await target.get_tree().create_timer(blink_duration).timeout
	if not is_instance_valid(target): return
	target.visible = true
