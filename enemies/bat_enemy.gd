class_name BatEnemy
extends Enemy

@onready var chase_state: = EnemyChaseState.new().set_actor(self)
@onready var fsm: = FSM.new().set_state(chase_state)

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)
