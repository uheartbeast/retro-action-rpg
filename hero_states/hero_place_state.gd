class_name HeroPlaceState
extends ItemState

func enter() -> void:
	assert(item is PlaceableItem, "The item in your place state is not a placeable item.")
	item = item as PlaceableItem
	var hero: = actor as Hero
	var inventory = ReferenceStash.inventory as Inventory
	if inventory.has_item(item):
		inventory.remove_item(item)
		Utils.instantiate_scene_on_level(item.scene, hero.global_position)
	finished.emit()
