class_name HeroWeaponState
extends State

const KNOCKBACK_AMOUNT: = 175

func enter() -> void:
	var hero: = actor as Hero
	hero.hitbox.knockback = hero.facing_direction * KNOCKBACK_AMOUNT
	hero.play_animation("sword")
	await hero.animation_player.animation_finished
	finished.emit()

func physics_process(delta: float) -> void:
	var hero: = actor as Hero
	CharacterMover.decelerate(hero, hero.movement_stats, delta)
	CharacterMover.move(hero)
