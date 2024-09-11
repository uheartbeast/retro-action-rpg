class_name BatEnemy
extends Enemy

@onready var navigation_agent_2d: NavigationAgent2D = %NavigationAgent2D
@onready var chase_state: EnemyChaseState = (
	EnemyChaseState.new()
	.set_actor(self)
	.set_navigation_agent(navigation_agent_2d)
)
@onready var fsm: = FSM.new().set_state(chase_state)

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)
