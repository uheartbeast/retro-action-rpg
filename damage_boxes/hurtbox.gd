class_name Hurtbox
extends Area2D

var is_invincible: = false :
	set(value):
		is_invincible = value
		set_deferred("monitoring", not is_invincible)

signal hurt(hitbox: Hitbox)
