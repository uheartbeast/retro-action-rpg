class_name VampireBoss
extends Enemy


@onready var fsm: FSM = FSM.new()

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)
