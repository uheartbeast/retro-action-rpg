class_name HeartUI
extends CenterContainer

const FINAL_FRAME: = 4 # NOTE: This is used for calculating quarter hearts

@onready var sprite_2d: Sprite2D = %Sprite2D

func update_quarter_hearts(leftover_health: float) -> void:
	var quarter_heart_frame: = leftover_health * FINAL_FRAME
	var clamped_quarter_heart_frame: int = clamp(quarter_heart_frame, 0, FINAL_FRAME)
	sprite_2d.frame = clamped_quarter_heart_frame
