class_name InventorySlotUI
extends Button

@onready var amount_label: Label = $AmountLabel
@onready var item_box: = ItemBox.new() :
	set(value):
		item_box = value
		if item_box is not ItemBox: return
		item_box.item_changed.connect(update_item)
		item_box.amount_changed.connect(update_label_amount)
		update_item()

signal selected(inventory_slot_ui, event)

func _ready() -> void:
	update_item()
	focus_entered.connect(show_item_description)

func show_item_description() -> void:
	var title: = ""
	var description: = ""
	if item_box.item is Item:
		title = item_box.item.name
		description = item_box.item.description
	Events.request_description.emit(title, description)

func update_item() -> void:
	ItemSlotManager.update_slot_icon(item_box, self, "icon")
	update_label_amount()

func update_label_amount() -> void:
	ItemSlotManager.update_slot_amount(item_box, amount_label)
