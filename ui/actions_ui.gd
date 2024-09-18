class_name ActionsUI
extends VBoxContainer

@onready var action_slot_ui_1: ActionSlotUI = %ActionSlotUI1
@onready var action_slot_ui_2: ActionSlotUI = %ActionSlotUI2
@onready var action_slot_ui_3: ActionSlotUI = %ActionSlotUI3

func _ready() -> void:
	Events.request_new_action_one.connect(action_slot_ui_1.set_action_item_index)
	Events.request_new_action_two.connect(action_slot_ui_2.set_action_item_index)
	Events.request_new_action_three.connect(action_slot_ui_3.set_action_item_index)
