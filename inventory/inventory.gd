class_name Inventory
extends RefCounted

var _item_boxes: Array[ItemBox] = []

signal item_box_changed(item_box, item_box_index)

func set_size(size: int = 16) -> Inventory:
	_item_boxes.clear()
	_item_boxes.resize(size)
	
	for i in _item_boxes.size():
		_item_boxes[i] = ItemBox.new()
	return self

func get_item_boxes() -> Array:
	return _item_boxes

func get_item(index: int) -> Item:
	if index < 0 or index >= _item_boxes.size(): return null
	var item_box: = _item_boxes[index]
	return item_box.item
