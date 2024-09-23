class_name Door
extends Area2D

const WORLD_COLLISION_LAYER_NAME = 1
const PLAYER_COLLISION_LAYER_NAME = 2

enum DIRECTION {RIGHT, UP, LEFT, DOWN}

var direction_map = {
	DIRECTION.RIGHT : Vector2.RIGHT,
	DIRECTION.UP : Vector2.UP,
	DIRECTION.LEFT : Vector2.LEFT,
	DIRECTION.DOWN : Vector2.DOWN,
}

@export var exit_direction: DIRECTION
@export var exit_distance: = 16
@export var connection: Resource
@export_file("*.tscn") var next_level_path


func _ready() -> void:
	set_collision_mask_value(PLAYER_COLLISION_LAYER_NAME, true)
	set_collision_mask_value(WORLD_COLLISION_LAYER_NAME, false)
	add_to_group("doors")
	body_entered.connect(func(body: Node2D):
		if body is not Hero: return
		Events.door_entered.emit(self)
	)

func get_exit_point() -> Vector2:
	return global_position + get_exit_offset()

func get_exit_offset() -> Vector2:
	return direction_map[exit_direction] * exit_distance

func get_offset(target: Node2D) -> Vector2:
	var offset: = global_position - target.global_position
	match exit_direction:
		DIRECTION.RIGHT, DIRECTION.LEFT:
			offset.x = 0.0
		DIRECTION.UP, DIRECTION.DOWN:
			offset.y = 0.0
	return offset
