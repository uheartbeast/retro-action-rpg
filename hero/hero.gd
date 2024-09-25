class_name Hero
extends CharacterBody2D

const CUSTOM_RED: = Color("e64539")
const SIDE_BIAS: = 0.1

var stats: = ReferenceStash.hero_stats as Stats
var inventory: = ReferenceStash.inventory as Inventory

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
		if interaction_detector is Area2D:
			interaction_detector.rotation = facing_direction.angle()

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var flip_anchor: Node2D = $FlipAnchor
@onready var sprite_2d: Sprite2D = $FlipAnchor/Sprite2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D
@onready var flasher: Flasher = Flasher.new().set_target(sprite_2d).set_color(CUSTOM_RED)
@onready var blinker: Blinker = Blinker.new().set_target(sprite_2d)
@onready var hitbox: Hitbox = $FlipAnchor/Hitbox
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var interaction_detector: Area2D = $InteractionDetector

@onready var move_state: = HeroMoveState.new().set_actor(self) as HeroMoveState
@onready var roll_state: HeroRollState = HeroRollState.new().set_actor(self).set_item(load("res://items/roll_ring_item.tres"))
@onready var weapon_state: HeroWeaponState = HeroWeaponState.new().set_actor(self).set_item(load("res://items/sword_item.tres"))
@onready var heal_state: = HeroHealState.new().set_actor(self)
@onready var place_state: = HeroPlaceState.new().set_actor(self)
@onready var fsm: = FSM.new().set_state(move_state)

@onready var item_state_lookup: = {
	RollItem : roll_state,
	WeaponItem : weapon_state,
	HealingItem : heal_state,
	PlaceableItem : place_state,
}

func _enter_tree() -> void:
	MainInstances.hero = self

func _exit_tree() -> void:
	MainInstances.hero = null

func _ready() -> void:
	facing_direction = Vector2.DOWN
	Events.request_camera_target.emit.call_deferred(remote_transform_2d)
	hurtbox.hurt.connect(take_hit)
	stats.no_health.connect(queue_free)
	motion_mode = MOTION_MODE_FLOATING
	Events.action_changed.connect(func(action_index: int, item_index: int):
		var state: ItemState
		var item: = inventory.get_item(item_index)
		var state_signal: Signal
		if item is Item:
			state = item_state_lookup[item.get_script()]
			state.item = item
		match action_index:
			0: state_signal = move_state.request_roll
			1: state_signal = move_state.request_weapon
			2: state_signal = move_state.request_misc
		connect_action(state_signal, state)
	)
	set_action_from_item(load("res://items/roll_ring_item.tres"), 0)

func _physics_process(delta: float) -> void:
	fsm.state.physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
	fsm.state.unhandled_input(event)

func set_action_from_item(item: Item, action_index: int) -> void:
	var item_index = inventory.get_item_index(item)
	Events.request_new_action.emit(action_index, item_index)

func connect_action(action_signal: Signal, state: State) -> void:
	if action_signal.is_connected(fsm.change_state):
		action_signal.disconnect(fsm.change_state)
	if state is not State: return
	action_signal.connect(fsm.change_state.bind(state))
	if not state.finished.is_connected(fsm.change_state):
		state.finished.connect(fsm.change_state.bind(move_state))
	state.set_actor(self)

func take_hit(other_hitbox: Hitbox) -> void:
	hurtbox.is_invincible = true
	stats.health -= other_hitbox.damage
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

func serialize() -> Dictionary:
	var data: = {}
	data.global_position = var_to_str(global_position)
	data.direction = var_to_str(direction)
	data.facing_direction = var_to_str(facing_direction)
	return data

func update_from_serialized_data(data: Dictionary) -> void:
	global_position = str_to_var(data.global_position)
	direction = str_to_var(data.direction)
	facing_direction = str_to_var(data.facing_direction)
	play_animation("idle")
	Events.request_camera_target.emit(remote_transform_2d)
