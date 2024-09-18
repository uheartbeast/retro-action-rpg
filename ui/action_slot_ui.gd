class_name ActionSlot
extends TextureRect

var inventory: = ReferenceStash.inventory as Inventory

var action_item_index: = -1 : set = set_action_item_index

@onready var amount_label: Label = $AmountLabel

func set_action_item_index(value: int) -> void:
	action_item_index = value

func _ready() -> void:
	pass # Replace with function body.
