class_name UI
extends CanvasLayer

@export var pause_manager: PauseManager

@onready var pause: ColorRect = %Pause
@onready var hero_inventory_manager: HeroInventoryManager = %HeroInventoryManager

func _ready() -> void:
	pause.hide()
	show()
	pause_manager.paused.connect(func():
		pause.show()
		hero_inventory_manager.grab_inventory_ui_focus()
	)
	pause_manager.unpaused.connect(func():
		pause.hide()
		hero_inventory_manager.release_focus()
	)
