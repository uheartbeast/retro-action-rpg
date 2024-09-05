class_name Hero
extends CharacterBody2D

const SIDE_BIAS: = 0.1

@export var movement_stats: MovementStats
@export var roll_movement_stats: MovementStats

var direction: = Vector2.DOWN :
	set(value):
		if value == Vector2.ZERO: return
		value = value.normalized()
		direction = value
		
var facing_direction: = Vector2.DOWN :
	set(value):
		if value == Vector2.ZERO: return
		value = value.normalized()
		if abs(value.x) >= abs(value.y) - SIDE_BIAS:
			value = Vector2(sign(value.x), 0)
		else:
			value = Vector2(0, sign(value.y))
		facing_direction = value

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var flip_anchor: Node2D = $FlipAnchor

@onready var move_state: = HeroMoveState.new().set_actor(self) as HeroMoveState
@onready var roll_state: = HeroRollState.new().set_actor(self)
@onready var fsm: = FSM.new().set_state(move_state)

func _ready() -> void:
	move_state.request_roll.connect(fsm.change_state.bind(roll_state))
	roll_state.finished.connect(fsm.change_state.bind(move_state))
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)

func play_animation(animation: String) -> void:
	var animation_name: = animation + "_" + get_direction_string()
	animation_player.play(animation_name)

func get_direction_string() -> String:
	var direction_string: = ""
	if facing_direction.x == 0.0:
		if facing_direction.y < 0.0:
			direction_string = "up"
		else:
			direction_string = "down"
	else:
		direction_string = "side"
	return direction_string
