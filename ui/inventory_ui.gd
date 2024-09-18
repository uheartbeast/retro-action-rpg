class_name InventoryUI
extends GridContainer

const INVENTORY_SLOT_UI = preload("res://ui/inventory_slot_ui.tscn")

var inventory_slot_index: = 0

signal inventory_slot_selected(inventory_ui, slot, event)

var inventory: Inventory = null :
	set(value):
		inventory = value
		if inventory is not Inventory: return
		update_inventory_grid.call_deferred()

func _ready() -> void:
	inventory = ReferenceStash.inventory

func grab_inventory_slot_focus() -> void:
	get_child(inventory_slot_index).grab_focus()

func update_inventory_grid() -> void:
	clear_inventory_slots()
	fill_inventory_slots()

func clear_inventory_slots() -> void:
	for child in get_children():
		child.queue_free()

func fill_inventory_slots() -> void:
	for item_box: ItemBox in inventory.get_item_boxes():
		var inventory_slot_ui: = INVENTORY_SLOT_UI.instantiate()
		add_child(inventory_slot_ui)
		inventory_slot_ui.selected.connect(func(inventory_slot_ui: InventorySlotUI, event: InputEvent):
			inventory_slot_selected.emit(self, inventory_slot_ui, event)
		)
		inventory_slot_ui.focus_entered.connect(func():
			inventory_slot_index = inventory_slot_ui.get_index()
		)
		inventory_slot_ui.item_box = item_box
