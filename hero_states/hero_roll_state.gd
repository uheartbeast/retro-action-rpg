class_name HeroRollState
extends ItemState

func enter() -> void:
	assert(item is RollItem, "The item in your roll state is not a roll item.")
	item = item as RollItem
	var hero: = actor as Hero
	hero.hurtbox.is_invincible = true
	hero.play_animation(item.animation)
	await hero.animation_player.animation_finished
	finished.emit()

func physics_process(delta: float) -> void:
	var hero: = actor as Hero
	CharacterMover.accelerate_in_direction(hero, hero.direction, hero.roll_movement_stats, delta)
	CharacterMover.move(hero)

func exit() -> void:
	var hero: = actor as Hero
	hero.hurtbox.is_invincible = false
