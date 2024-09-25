extends Node2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	Utils.instantiate_scene_on_level(load("res://effects/explosion_effect.tscn"), global_position)
	Utils.instantiate_scene_on_level(load("res://effects/smoke_effect.tscn"), global_position)
	timer.timeout.connect(queue_free)
