class_name HeroInventoryManager
extends VBoxContainer

@onready var inventory_ui: InventoryUI = $InventoryUI

func _ready() -> void:
	inventory_ui.inventory = ReferenceStash.inventory
	inventory_ui.inventory_slot_selected.connect(_on_inventory_slot_selected)

func grab_inventory_ui_focus() -> void:
	inventory_ui.grab_inventory_slot_focus()

func _on_inventory_slot_selected(inventory_ui: InventoryUI, inventory_slot_ui: InventorySlotUI, event: InputEvent) -> void:
	var slot_index: int = inventory_slot_ui.get_index()
	if event.is_action("roll"):
		Events.request_new_action_one.emit(slot_index)
	if event.is_action("weapon"):
		Events.request_new_action_two.emit(slot_index)
	if event.is_action("misc"):
		Events.request_new_action_three.emit(slot_index)
