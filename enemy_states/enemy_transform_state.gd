class_name EnemyTransformState
extends State

const SMOKE_EFFECT_SCENE: = preload("res://effects/smoke_effect.tscn")

var transform_animation = "" : set = set_transform_animation

func set_transform_animation(value: String) -> EnemyTransformState:
	transform_animation = value
	return self

func enter() -> void:
	var enemy: = actor as Enemy
	Utils.instantiate_scene_on_level(SMOKE_EFFECT_SCENE, enemy.global_position)
	var tween: = enemy.create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(enemy.sprite_2d, "scale", Vector2(0.6, 0.6), 0.25).from_current()
	await tween.finished
	enemy.animation_player.play(transform_animation)
	tween = enemy.create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(enemy.sprite_2d, "scale", Vector2.ONE, 0.25).from_current()
	await tween.finished
	finished.emit()
