class_name Projectile
extends Node2D

@export var impact_effect_scene: PackedScene

var direction: = Vector2.ZERO : set = set_direction
var speed: = 100.0 : set = set_speed

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func set_direction(value: Vector2) -> Projectile:
	direction = value
	rotation = direction.angle()
	return self

func set_speed(value: float) -> Projectile:
	speed = value
	return self

func _ready() -> void:
	hitbox.hit_hurtbox.connect(impact.unbind(1))
	hitbox.body_entered.connect(impact.unbind(1))
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)

func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)

func impact() -> void:
	queue_free()
	var impact_effect: = Utils.instantiate_scene_on_level(impact_effect_scene, global_position) as Node2D
	impact_effect.rotation = rotation
	
