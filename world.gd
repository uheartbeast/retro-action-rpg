class_name World
extends Node2D

@export var current_level: Level

func _ready() -> void:
	y_sort_enabled = true
	RenderingServer.set_default_clear_color(Color("#14182e"))
