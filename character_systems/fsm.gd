class_name FSM
extends RefCounted

var state: State : set = set_state

func set_state(value: State) -> FSM:
	state = value
	state.enter()
	return self

func change_state(new_state: State) -> void:
	state.exit()
	set_state(new_state)
