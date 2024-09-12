class_name Effector
extends RefCounted

var target: CanvasItem : set = set_target

func set_target(value: CanvasItem) -> Effector:
	target = value
	return self
