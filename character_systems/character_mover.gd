class_name CharacterMover
extends RefCounted

static func accelerate_in_direction(character: CharacterBody2D, direction: Vector2, movement_stats: MovementStats, delta: float) -> void:
	character.velocity = character.velocity.move_toward(direction * movement_stats.max_speed, movement_stats.acceleration * delta)

static func decelerate(character: CharacterBody2D, movement_stats: MovementStats, delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO, movement_stats.friction * delta)

static func move(character: CharacterBody2D) -> void:
	character.move_and_slide()

static func move_and_bounce(character: CharacterBody2D, delta: float) -> void:
	var collision: = character.move_and_collide(character.velocity * delta)
	if collision:
		character.velocity = character.velocity.bounce(collision.get_normal())

static func apply_knockback(character: CharacterBody2D, knockback: Vector2) -> void:
	character.velocity = knockback
