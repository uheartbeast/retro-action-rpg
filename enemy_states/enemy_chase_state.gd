class_name EnemyChaseState
extends State

func physics_process(delta: float) -> void:
	var enemy: = actor as Enemy
	var hero: = MainInstances.hero as Hero
	if hero is not Hero: return
	var movement_stats: = MovementStats.new()
	var direction: = enemy.global_position.direction_to(hero.global_position)
	CharacterMover.accelerate_in_direction(enemy, direction, movement_stats, delta)
	CharacterMover.move(enemy)
