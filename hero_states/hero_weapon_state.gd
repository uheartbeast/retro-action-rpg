class_name HeroWeaponState
extends State

func enter() -> void:
	var hero: = actor as Hero
	hero.play_animation("sword")
	await hero.animation_player.animation_finished
	finished.emit()

func physics_process(delta: float) -> void:
	var hero: = actor as Hero
	CharacterMover.decelerate(hero, hero.movement_stats, delta)
	CharacterMover.move(hero)
