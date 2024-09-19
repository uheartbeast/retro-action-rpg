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

func get_item_index(item: Item) -> int:
	return _find_item_box_index_with_item(item)

func add_item(item: Item, amount: int = 1) -> Inventory:
	var item_box_index: = _find_item_box_index_with_item(item)
	if item_box_index != -1:
		_change_item_amount(item_box_index, amount)
	else:
		_append_item(item, amount)
	return self

func remove_item(item: Item, amount: = 1) -> Inventory:
	var item_box_index: = _find_item_box_index_with_item(item)
	if item_box_index != 1:
		_change_item_amount(item_box_index, -amount)
	return self

func find_item(search_item: Item) -> Item:
	var item_box: = _find_item_box_with_item(search_item)
	if item_box is not ItemBox:
		return null
	else:
		return item_box.item

func has_item(search_item: Item) -> bool:
	var item: = find_item(search_item)
	return (item is Item)

func _find_item_box_index_with_item(search_item: Item) -> int:
	var item_box: = _find_item_box_with_item(search_item)
	return _item_boxes.find(item_box)

func _find_item_box_with_item(search_item: Item) -> ItemBox:
	var found_item_boxes: = _item_boxes.filter(_item_box_has_item.bind(search_item))
	if found_item_boxes.is_empty(): return null
	
	# We're only concerned with the first box that contains the item we are looking for
	var first_item_box: ItemBox = found_item_boxes.front()
	return first_item_box

func _item_box_has_item(item_box: ItemBox, item: Item) -> bool:
	return (item_box.item == item)

func _set_item_box_item(index: int, item: Item, amount: = 1) -> void:
	var item_box: = _item_boxes[index]
	item_box.set_item_and_amount(item, amount)
	item_box_changed.emit(item_box, index)

func _append_item(new_item: Item, amount: = 1) -> void:
	var empty_item_box_index: = _find_item_box_index_with_item(null)
	_set_item_box_item(empty_item_box_index, new_item, amount)

func _change_item_amount(index: int, change_amount: int) -> void:
	var item_box: = _item_boxes[index]
	_set_item_box_item(index, item_box.item, item_box.amount + change_amount)
