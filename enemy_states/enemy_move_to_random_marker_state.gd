class_name EnemyMoveToRandomMarkerState
extends State

const REACHED_TARGET_MARGIN: = 8

var markers: Array[Marker2D] : set = set_markers
var target_positions: Array[Vector2]
var target_position: Vector2

func set_markers(value: Array[Marker2D]) -> EnemyMoveToRandomMarkerState:
	markers = value
	return self

func enter() -> void:
	var enemy: = actor as Enemy
	if target_positions.is_empty():
		markers.shuffle()
		for marker in markers:
			target_positions.append(marker.global_position)
	if is_current_position_in_front():
		target_position = target_positions.pop_back()
	else:
		target_position = target_positions.pop_front()

func physics_process(delta: float) -> void:
	var enemy: = actor as Enemy
	var direction: Vector2 = enemy.global_position.direction_to(target_position)
	enemy.animation_player.play("move")
	if direction.x != 0:
		enemy.sprite_2d.scale.x = sign(direction.x)
	
	CharacterMover.accelerate_in_direction(enemy, direction, enemy.movement_stats, delta)
	CharacterMover.move(enemy)
	
	# WARNING: This code uses the margin to determine if the enemy has reached the target
	# This is also affect by the enemy's acceleration and friction
	var distance: = enemy.global_position.distance_to(target_position)
	if distance <= REACHED_TARGET_MARGIN:
		enemy.velocity = Vector2.ZERO
		finished.emit()

func is_current_position_in_front() -> bool:
	return (target_positions.front() == target_position)
