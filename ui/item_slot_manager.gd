class_name ItemSlotManager
extends RefCounted

const EMPTY_SLOT_TEXTURE: = preload("res://ui/empty_inventory_slot.png")

static func update_slot_icon(item_box: ItemBox, slot: Control, icon_property: String) -> void:
	var item: = item_box.item
	if item is Item:
		slot[icon_property] = item.icon
	else:
		slot[icon_property] = load("res://ui/empty_inventory_slot.png")

static func update_slot_amount(item_box: ItemBox, amount_label: Label) -> void:
	if item_box is not ItemBox: return
	if amount_label is not Label: return
	if item_box.item is not Item:
		amount_label.hide()
	else:
		amount_label.visible = (not item_box.item.is_equipment)
		amount_label.text = str(item_box.amount)
