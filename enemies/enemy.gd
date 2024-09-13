class_name Enemy
extends CharacterBody2D

@export var movement_stats: MovementStats
@export var stats: Stats :
	set(value):
		stats = value
		if stats is not Stats: return
		stats = stats.duplicate()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var hitbox: Hitbox = $Hitbox
@onready var flasher: = Flasher.new().set_target(sprite_2d)

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING
	assert(movement_stats is MovementStats, "ERROR: No movement stats set on enemy: " + str(name))

func create_hit_particles(other_hitbox: Hitbox, particle_scene: PackedScene, distance_from_hitbox: = 8) -> void:
	var particle_position = global_position.move_toward(other_hitbox.global_position, distance_from_hitbox)
	var hit_particles: = particle_scene.instantiate() as ParticleBurst
	add_sibling(hit_particles)
	hit_particles.global_position = particle_position
	hit_particles.rotation = global_position.direction_to(other_hitbox.global_position).angle()
