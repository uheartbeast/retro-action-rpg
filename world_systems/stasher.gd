class_name Stasher
extends RefCounted

var target: set = set_target
var starting_position: Vector2

func set_target(value: Node2D) -> Stasher:
	target = value
	if target is not Node2D: return self
	starting_position = target.global_position
	return self

func get_id() -> String:
	var world: = target.get_tree().current_scene as World
	assert(world is World, "You can't get the id for an object ouside of the world scene.")
	var id: String = (
		target.scene_file_path
		+ " at " + str(starting_position)
		+ " in " + world.current_level.scene_file_path
	)
	return id

func stash_property(property: String, value) -> void:
	var id: = get_id()
	if not SaveManager.save_data.has(id):
		SaveManager.save_data[id] = {}
	SaveManager.save_data[id][property] = value

func retrieve_property(property: String):
	var id: = get_id()
	if not SaveManager.save_data.has(id): return null
	if not SaveManager.save_data[id].has(property): return null
	return SaveManager.save_data[id][property]
