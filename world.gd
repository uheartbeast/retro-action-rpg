class_name World
extends Node2D

@export var current_level: Level

@onready var hero: Hero = $Hero

func _ready() -> void:
	y_sort_enabled = true
	RenderingServer.set_default_clear_color(Color("#14182e"))
	Events.door_entered.connect(change_levels, CONNECT_DEFERRED)

func set_level(level_scene_path: String) -> void:
	current_level.queue_free()
	var new_level: = load(level_scene_path).instantiate() as Level
	current_level = new_level
	add_child(new_level)

func change_levels(entered_door: Door) -> void:
	if hero is not Hero: return
	set_level(entered_door.next_level_path)
	var doors: = get_tree().get_nodes_in_group("doors")
	doors.erase(entered_door)
	for door: Door in doors:
		if door.connection != entered_door.connection: continue
		var offset = entered_door.get_offset(hero)
		hero.global_position = door.get_exit_point() - offset
