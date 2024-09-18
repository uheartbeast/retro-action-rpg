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
	var item: = item_box.item
	if item is Item:
		icon = item.icon
	else:
		icon = load("res://ui/empty_inventory_slot.png")
	update_label_amount()

func update_label_amount() -> void:
	if item_box is not ItemBox: return
	if amount_label is not Label: return
	if item_box.item is not Item:
		amount_label.hide()
	else:
		amount_label.visible = (not item_box.item.is_equipment)
		amount_label.text = str(item_box.amount)
