extends Node

var hero_stats: Stats = load("res://hero/hero_stats.tres")
var inventory: Inventory = (
	Inventory.new()
	.set_size(16)
	.add_item(load("res://items/apple_item.tres"), 5)
	.add_item(load("res://items/apple_item.tres"), 5)
	.add_item(load("res://items/sword_item.tres"))
	.add_item(load("res://items/roll_ring_item.tres"), 3)
	.remove_item(load("res://items/apple_item.tres"), 15)
)
