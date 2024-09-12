class_name EnemyKnockbackState
extends State

var knockback: = Vector2.ZERO : set = set_knockback

func set_knockback(value: Vector2) -> EnemyKnockbackState:
	knockback = value
	return self

func enter() -> void:
	var enemy: = actor as Enemy
	CharacterMover.apply_knockback(enemy, knockback)

func physics_process(delta: float) -> void:
	var enemy: = actor as Enemy
	CharacterMover.decelerate(enemy, enemy.movement_stats, delta)
	CharacterMover.move_and_bounce(enemy, delta)
	if enemy.velocity.is_equal_approx(Vector2.ZERO):
		finished.emit()
