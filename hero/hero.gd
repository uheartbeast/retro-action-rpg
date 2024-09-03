extends CharacterBody2D

const SIDE_BIAS: = 0.1

var facing_direction: = Vector2.DOWN :
	set(value):
		if value == Vector2.ZERO: return
		value = value.normalized()
		if abs(value.x) >= abs(value.y) - SIDE_BIAS:
			value = Vector2(sign(value.x), 0)
		else:
			value = Vector2(0, sign(value.y))
		facing_direction = value
		
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	facing_direction = input_vector
	if input_vector != Vector2.ZERO:
		play_animation("run")
	else:
		play_animation("idle")
	velocity = input_vector * 100
	move_and_slide()

func play_animation(animation: String) -> void:
	var animation_name: = animation + "_" + get_direction_string()
	animation_player.play(animation_name)

func get_direction_string() -> String:
	var direction_string: = ""
	if facing_direction.x == 0.0:
		if facing_direction.y < 0.0:
			direction_string = "up"
		else:
			direction_string = "down"
	else:
		direction_string = "side"
	return direction_string
