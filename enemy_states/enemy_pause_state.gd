class_name EnemyPauseState
extends State

var pause_time: = 2.0 : set = set_pause_time

func set_pause_time(value: float) -> EnemyPauseState:
	pause_time = value
	return self

func enter() -> void:
	var enemy: = actor as Enemy
	await enemy.get_tree().create_timer(pause_time).timeout
	finished.emit()
