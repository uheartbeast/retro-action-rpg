extends ColorRect

@onready var continue_button: Button = %ContinueButton
@onready var new_game_button: Button = %NewGameButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	if SaveManager.has_save_file():
		continue_button.show()
		continue_button.grab_focus()
	else:
		continue_button.hide()
		new_game_button.grab_focus()
	
	continue_button.pressed.connect(SaveManager.load_game)
	new_game_button.pressed.connect(get_tree().change_scene_to_file.bind("res://world.tscn"))
	quit_button.pressed.connect(get_tree().quit)
