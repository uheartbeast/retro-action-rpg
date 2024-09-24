extends StaticBody2D

@onready var interaction: Interaction = $Interaction
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var stasher: = Stasher.new().set_target(self)

func _ready() -> void:
	if stasher.retrieve_property("collected"):
		set_collected()
	interaction.interacted.connect(collect_sword)

func collect_sword() -> void:
	var sword: = load("res://items/sword_item.tres")
	var inventory: = ReferenceStash.inventory as Inventory
	inventory.add_item(sword)
	var sword_index: = inventory.get_item_index(sword)
	if sword_index == -1: return
	stasher.stash_property("collected", true)
	set_collected()

func set_collected() -> void:
	sprite_2d.frame = 0
	interaction.queue_free()
