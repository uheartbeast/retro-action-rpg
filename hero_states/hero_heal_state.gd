class_name HeroHealState
extends ItemState

func enter() -> void:
	assert(item is HealingItem, "The item in your heal state is not a healing item.")
	item = item as HealingItem
	var hero = actor as Hero
	var inventory = ReferenceStash.inventory as Inventory
	if inventory.has_item(item):
		inventory.remove_item(item)
		hero.stats.health += item.heal_amount
	finished.emit()
