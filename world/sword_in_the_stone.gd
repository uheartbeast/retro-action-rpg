extends StaticBody2D

@onready var interaction: Interaction = $Interaction
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	interaction.interacted.connect(collect_sword)

func collect_sword() -> void:
	var sword: = load("res://items/sword_item.tres")
	var inventory: = ReferenceStash.inventory as Inventory
	inventory.add_item(sword)
	var sword_index: = inventory.get_item_index(sword)
	if sword_index == -1: return
	sprite_2d.frame = 0
	interaction.queue_free()
