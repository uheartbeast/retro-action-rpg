extends ColorRect

@onready var yes_button: Button = %YesButton
@onready var no_button: Button = %NoButton

func _ready() -> void:
	yes_button.grab_focus()
	
	yes_button.pressed.connect(func():
		if SaveManager.has_save_file():
			SaveManager.load_game()
		else:
			get_tree().change_scene_to_file("res://world.tscn")
	)
	no_button.pressed.connect(get_tree().quit)
