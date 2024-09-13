class_name Hero
extends CharacterBody2D

const CUSTOM_RED: = Color("e64539")
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
@onready var sprite_2d: Sprite2D = $FlipAnchor/Sprite2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var flasher: Flasher = Flasher.new().set_target(sprite_2d).set_color(CUSTOM_RED)
@onready var blinker: Blinker = Blinker.new().set_target(sprite_2d)
@onready var hitbox: Hitbox = $FlipAnchor/Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox

@onready var move_state: = HeroMoveState.new().set_actor(self) as HeroMoveState
@onready var roll_state: = HeroRollState.new().set_actor(self)
@onready var weapon_state: = HeroWeaponState.new().set_actor(self)
@onready var fsm: = FSM.new().set_state(move_state)

func _enter_tree() -> void:
	MainInstances.hero = self

func _exit_tree() -> void:
	MainInstances.hero = null

func _ready() -> void:
	Events.request_camera_target.emit.call_deferred(remote_transform_2d)
	hurtbox.hurt.connect(take_hit)
	move_state.request_roll.connect(fsm.change_state.bind(roll_state))
	move_state.request_weapon.connect(fsm.change_state.bind(weapon_state))
	roll_state.finished.connect(fsm.change_state.bind(move_state))
	weapon_state.finished.connect(fsm.change_state.bind(move_state))
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)

func take_hit(other_hitbox: Hitbox) -> void:
	hurtbox.is_invincible = true
	Events.request_camera_screenshake.emit(4, 0.3)
	Events.hero_hurt.emit()
	await flasher.flash(0.2)
	await blinker.blink()
	hurtbox.is_invincible = false

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
