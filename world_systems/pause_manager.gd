class_name PauseManager
extends Node

signal paused()
signal unpaused()

var is_paused: = false :
	set(value):
		is_paused = value
		get_tree().paused = is_paused
		if is_paused: paused.emit()
		else: unpaused.emit()

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		is_paused = not is_paused
