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
	print(slot_index)
	print(inventory_slot_ui.item_box.item.name)
