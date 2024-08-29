extends CharacterBody2D

func _ready() -> void:
	motion_mode = MOTION_MODE_FLOATING

func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * 100
	move_and_slide()
