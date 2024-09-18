class_name ActionSlotUI
extends TextureRect

var inventory: = ReferenceStash.inventory as Inventory

var action_item_index: = -1 : set = set_action_item_index

@onready var amount_label: Label = $AmountLabel

func set_action_item_index(value: int) -> void:
	disconnect_from_item_box()
	action_item_index = value
	connect_to_item_box()
	update_item()

func _ready() -> void:
	update_item()

func get_item_box() -> ItemBox:
	var item_box: ItemBox = inventory.get_item_boxes()[action_item_index]
	assert(item_box is ItemBox, "No itme box found at index " + str(action_item_index))
	return item_box

func connect_to_item_box() -> void:
	var item_box: = get_item_box()
	item_box.item_changed.connect(update_item)
	item_box.amount_changed.connect(update_label_amount)

func disconnect_from_item_box() -> void:
	var item_box: = get_item_box()
	if item_box.item_changed.is_connected(update_item):
		item_box.item_changed.disconnect(update_item)
	if item_box.amount_changed.is_connected(update_label_amount):
		item_box.amount_changed.disconnect(update_label_amount)

func update_item() -> void:
	ItemSlotManager.update_slot_icon(get_item_box(), self, "texture")
	update_label_amount()

func update_label_amount() -> void:
	ItemSlotManager.update_slot_amount(get_item_box(), amount_label)
