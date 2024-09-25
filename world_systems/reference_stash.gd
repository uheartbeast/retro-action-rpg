extends Node

var hero_stats: Stats = load("res://hero/hero_stats.tres")
var inventory: Inventory = (
	Inventory.new()
	.set_size(16)
	.add_item(load("res://items/apple_item.tres"), 5)
	.add_item(load("res://items/apple_item.tres"), 5)
	.add_item(load("res://items/roll_ring_item.tres"), 3)
	.add_item(load("res://items/bomb_item.tres"), 9)
)
