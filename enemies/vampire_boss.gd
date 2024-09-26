class_name VampireBoss
extends Enemy

const EXPLOSION_EFFECT_SCENE: = preload("res://effects/explosion_effect.tscn")

@export var target_markers: Array[Marker2D]

@onready var pause_state: = EnemyPauseState.new().set_actor(self)
@onready var move_to_random_marker_state: = (
	EnemyMoveToRandomMarkerState.new()
	.set_markers(target_markers)
	.set_actor(self)
)
@onready var fsm: FSM = FSM.new().set_state(pause_state)

func _ready() -> void:
	pause_state.finished.connect(fsm.change_state.bind(move_to_random_marker_state))
	move_to_random_marker_state.finished.connect(fsm.change_state.bind(pause_state))
	
	hurtbox.hurt.connect(func(other_hitbox: Hitbox):
		var damage = other_hitbox.damage
		await flasher.flash()
		await get_tree().create_timer(0.1).timeout
		stats.health -= damage
		if stats.is_health_gone():
			Utils.instantiate_scene_on_level(EXPLOSION_EFFECT_SCENE, global_position)
			queue_free()
	)

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)
