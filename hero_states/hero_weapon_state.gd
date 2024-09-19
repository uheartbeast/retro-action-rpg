class_name HeroWeaponState
extends ItemState

const KNOCKBACK_AMOUNT: = 175

func enter() -> void:
	assert(item is WeaponItem, "The item in the weapon state is not a weapon item.")
	item = item as WeaponItem
	var hero: = actor as Hero
	hero.hitbox.knockback = hero.facing_direction * item.knockback
	hero.hitbox.damage = item.damage
	hero.play_animation(item.animation)
	await hero.animation_player.animation_finished
	finished.emit()

func physics_process(delta: float) -> void:
	var hero: = actor as Hero
	CharacterMover.decelerate(hero, hero.movement_stats, delta)
	CharacterMover.move(hero)

func exit() -> void:
	var hero: = actor as Hero
	hero.hitbox.clear_stored_targets()
