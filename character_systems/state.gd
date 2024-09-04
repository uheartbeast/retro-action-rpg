class_name State
extends RefCounted

var actor: Node2D : set = set_actor

signal finished()

func set_actor(value: Node2D) -> State:
	actor = value
	return self

func enter() -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func exit() -> void:
	pass
