class_name ItemState
extends State

var item: Item : set = set_item

func set_item(value: Item) -> ItemState:
	item = value
	return self
