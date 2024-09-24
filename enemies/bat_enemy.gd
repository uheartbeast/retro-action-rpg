class_name BatEnemy
extends Enemy

@onready var navigation_agent_2d: NavigationAgent2D = %NavigationAgent2D
@onready var chase_state: EnemyChaseState = (
	EnemyChaseState.new()
	.set_actor(self)
	.set_navigation_agent(navigation_agent_2d)
)
@onready var knockback_state: = EnemyKnockbackState.new().set_actor(self)
@onready var fsm: = FSM.new().set_state(chase_state)

@onready var stasher: = Stasher.new().set_target(self)

func _ready() -> void:
	super()
	if stasher.retrieve_property("freed"): queue_free()
	hurtbox.hurt.connect(func(other_hitbox: Hitbox):
		fsm.change_state(knockback_state.set_knockback(other_hitbox.knockback))
		create_hit_particles(other_hitbox, load("res://effects/hit_particles.tscn"))
		stats.health -= other_hitbox.damage
	)
	knockback_state.finished.connect(fsm.change_state.bind(chase_state))
	tree_exiting.connect(func():
		stasher.stash_property("freed", true)
	)

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)
