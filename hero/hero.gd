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
		print(facing_direction)

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	facing_direction = input_vector
	velocity = input_vector * 100
	move_and_slide()
