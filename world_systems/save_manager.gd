extends Node

const TEST_PATH: = "res://arpg_save.txt"
const PRODUCTION_PATH: = "user://arpg_save.save"

var save_path: = TEST_PATH
var save_data: = {}

func save_game() -> void:
	var hero: = MainInstances.hero as Hero
	var inventory: = ReferenceStash.inventory as Inventory
	var world: = get_tree().current_scene as World
	var actions_ui: = MainInstances.actions_ui as ActionsUI
	var hero_stats: = ReferenceStash.hero_stats as Stats
	
	assert(hero is Hero, "There is no hero to save.")
	assert(world is World, "There is no world to save.")
	assert(actions_ui is ActionsUI, "There is no actions UI to save.")
	
	save_data.hero = hero.serialize()
	save_data.hero_stats = hero_stats.serialize()
	save_data.inventory = inventory.serialize()
	save_data.actions_ui = actions_ui.serialize()
	save_data.level_path = world.current_level.scene_file_path
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	var data_string: = JSON.stringify(save_data)
	save_file.store_string(data_string)
	save_file.close()

func load_game() -> void:
	print("load game")
