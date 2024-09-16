class_name EnemyKnockbackState
extends State

const EXPLOSION_EFFECT_SCENE: = preload("res://effects/explosion_effect.tscn")

var knockback: = Vector2.ZERO : set = set_knockback

func set_knockback(value: Vector2) -> EnemyKnockbackState:
	knockback = value
	return self

func enter() -> void:
	var enemy: = actor as Enemy
	enemy.set_enemy_collision(false)
	CharacterMover.apply_knockback(enemy, knockback)
	enemy.flasher.flash()

func physics_process(delta: float) -> void:
	var enemy: = actor as Enemy
	CharacterMover.decelerate(enemy, enemy.movement_stats, delta)
	CharacterMover.move_and_bounce(enemy, delta)
	if enemy.velocity.is_equal_approx(Vector2.ZERO):
		finished.emit()

func exit() -> void:
	var enemy: = actor as Enemy
	enemy.set_enemy_collision(true)
	if enemy.stats.is_health_gone():
		enemy.queue_free()
		Utils.instantiate_scene_on_level(EXPLOSION_EFFECT_SCENE, enemy.global_position)
