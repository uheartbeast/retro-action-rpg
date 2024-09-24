extends Node

const TEST_PATH: = "res://arpg_save.save"
const PRODUCTION_PATH: = "user://arpg_save.save"

var save_path: = TEST_PATH
var save_data: = {}

func save_game() -> void:
	print("save game")

func load_game() -> void:
	print("load game")
