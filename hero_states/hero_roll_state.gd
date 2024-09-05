class_name HeroRollState
extends State

func enter() -> void:
	var hero: = actor as Hero
	hero.play_animation("roll")
	hero.animation_player.animation_finished.connect(func(_animation_name: String):
		finished.emit()
	, CONNECT_ONE_SHOT)

func physics_process(delta: float) -> void:
	var hero: = actor as Hero
	CharacterMover.accelerate_in_direction(hero, hero.direction, hero.roll_movement_stats, delta)
	CharacterMover.move(hero)
