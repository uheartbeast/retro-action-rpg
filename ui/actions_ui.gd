class_name ActionsUI
extends VBoxContainer

var _action_item_indexes = [-1, -1, -1]

signal item_index_changed(action_index)

@onready var action_slot_ui_1: ActionSlotUI = %ActionSlotUI1
@onready var action_slot_ui_2: ActionSlotUI = %ActionSlotUI2
@onready var action_slot_ui_3: ActionSlotUI = %ActionSlotUI3

func _ready() -> void:
	Events.request_new_action.connect(set_action)
	item_index_changed.connect(update_action_slot_ui_item_index)

func _set_action_item_index(action_index: int, new_item_index: int) -> void:
	_action_item_indexes[action_index] = new_item_index
	item_index_changed.emit(action_index)

func _swap_action_item_indexes(previous_action_index: int, new_action_index: int) -> void:
	var temp_item_index: int = _action_item_indexes[previous_action_index]
	_set_action_item_index(previous_action_index, _action_item_indexes[new_action_index])
	_set_action_item_index(new_action_index, temp_item_index)

func set_action(action_index: int, new_item_index: int) -> void:
	var found_action_index = _action_item_indexes.find(new_item_index)
	if found_action_index != -1:
		_swap_action_item_indexes(found_action_index, action_index)
	else:
		_set_action_item_index(action_index, new_item_index)

func update_action_slot_ui_item_index(action_index: int) -> void:
	var item_index: int = _action_item_indexes[action_index]
	var action_slot_ui: = get_child(action_index) as ActionSlotUI
	action_slot_ui.action_item_index = item_index
