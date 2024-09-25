class_name HeroMoveState
extends State

var input_vector: = Vector2.ZERO

signal request_roll()
signal request_weapon()
signal request_misc()

func physics_process(delta: float) -> void:
	var hero: = actor as Hero
	
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	hero.facing_direction = input_vector
	hero.direction = input_vector
	
	if hero.facing_direction.x != 0.0:
		hero.flip_anchor.scale.x = hero.facing_direction.x
	
	if input_vector != Vector2.ZERO:
		hero.play_animation("run")
		CharacterMover.accelerate_in_direction(hero, input_vector, hero.movement_stats, delta)
	else:
		hero.play_animation("idle")
		CharacterMover.decelerate(hero, hero.movement_stats, delta)
	CharacterMover.move(hero)


func unhandled_input(event: InputEvent) -> void:
	var hero: = actor as Hero
	if event.is_action_pressed("roll") or event.is_action_pressed("weapon"):
		if hero.interaction_detector.can_interact() and input_vector == Vector2.ZERO:
			hero.interaction_detector.trigger_interaction()
			return
	
	if event.is_action_pressed("roll"):
		request_roll.emit()
	if event.is_action_pressed("weapon"):
		request_weapon.emit()
	if event.is_action_pressed("misc"):
		request_misc.emit()
