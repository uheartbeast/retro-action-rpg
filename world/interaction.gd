class_name Interaction
extends Area2D

const INTERACTION_LAYER_NUMBER: = 6

signal interacted

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	set_collision_layer_value(INTERACTION_LAYER_NUMBER, true)

func run() -> void:
	interacted.emit()
