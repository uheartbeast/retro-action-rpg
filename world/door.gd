@tool
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

@export var exit_direction: DIRECTION :
	set(value):
		exit_direction = value
		queue_redraw()

@export var exit_distance: = 16 :
	set(value):
		exit_distance = value
		queue_redraw()

@export var connection: Resource
@export_file("*.tscn") var next_level_path

func _ready() -> void:
	queue_redraw()
	if Engine.is_editor_hint(): return
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

func _draw() -> void:
	if not Engine.is_editor_hint(): return
	draw_circle(Vector2.ZERO, 1, Color.WHITE)
	draw_line(Vector2.ZERO, get_exit_offset(), Color.WHITE, 1, false)
	draw_circle(get_exit_offset(), 2, Color.WHITE)
