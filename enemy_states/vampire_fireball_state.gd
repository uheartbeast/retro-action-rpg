class_name VampireFireballState
extends State

const FIREBALL_PROJECTILE_SCENE: = preload("res://projectiles/fireball_projectile.tscn")

func enter() -> void:
	var vampire: = actor as VampireBoss
	vampire.animation_player.play("open_cloak")
	await vampire.animation_player.animation_finished
	var marker_position: = vampire.fireball_marker_2d.global_position
	var starting_fireball_angle: = Vector2(-1, 1).normalized()
	for i in 8:
		var fireball: = Utils.instantiate_scene_on_level(FIREBALL_PROJECTILE_SCENE, marker_position) as Projectile
		fireball.set_direction(starting_fireball_angle.rotated(-i * PI/4)).set_speed(100)
	await vampire.get_tree().create_timer(0.5).timeout
	finished.emit()
		
