class_name Stats
extends Resource

@export var max_health: = 1.0 :
	set(value):
		var change: = value - max_health
		max_health = value
		health = max_health
		if change != 0: max_health_changed.emit(max_health)

var health: = max_health :
	set(value):
		var change: = value - health
		health = clamp(value, 0, max_health)
		if change != 0: health_changed.emit(health)
		if is_health_gone(): no_health.emit()

signal max_health_changed(new_max_health)
signal health_changed(new_health)
signal no_health()

func is_health_gone() -> bool:
	return (health <= 0)
