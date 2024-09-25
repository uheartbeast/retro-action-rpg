extends StaticBody2D

@onready var interaction: Interaction = $Interaction

func _ready() -> void:
	interaction.interacted.connect(func():
		SaveManager.save_game()
		Events.request_show_dialog.emit("You recorded your progress in the journal.")
	)
