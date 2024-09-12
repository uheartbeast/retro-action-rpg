class_name Enemy
extends CharacterBody2D

@export var movement_stats: MovementStats

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hitbox: Hitbox = $Hitbox

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	assert(movement_stats is MovementStats, "ERROR: No movement stats set on enemy: " + str(name))
