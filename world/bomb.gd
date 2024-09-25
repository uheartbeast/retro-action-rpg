extends Node2D

const CUSTOM_RED: = Color("e64539")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var timer: Timer = $Timer
@onready var flasher: Flasher = Flasher.new().set_target(sprite_2d).set_color(CUSTOM_RED)

func _ready() -> void:
	for i in 3:
		timer.start(0.33)
		await timer.timeout
		await flasher.flash(0.33)
	
	for i in 3:
		timer.start(0.16)
		await timer.timeout
		await flasher.flash(0.16)
	
	Utils.instantiate_scene_on_level(load("res://world/bomb_explosion.tscn"), global_position)
	queue_free()
