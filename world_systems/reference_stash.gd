extends Node

var hero_stats: Stats = load("res://hero/hero_stats.tres")
var inventory: Inventory = (
	Inventory.new()
	.set_size(16)
)
