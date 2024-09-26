class_name Projectile
extends Node2D

var direction: = Vector2.ZERO : set = set_direction
var speed: = 100.0 : set = set_speed

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hitbox: Hitbox = $Hitbox

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

func _physcis_process(delta: float) -> void:
	translate(direction * speed * delta)

func impact() -> void:
	queue_free()
