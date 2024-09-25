class_name Dialogbox
extends PanelContainer

const CHARACTER_DISPLAY_DURATION: = 0.08

var typer: Tween
var is_typing: bool = false

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func _ready() -> void:
	rich_text_label.bbcode_enabled = true
	Events.request_show_dialog.connect(type_dialog)

func _input(event: InputEvent) -> void:
	if not visible: return
	if not (
		event.is_action_pressed("roll")
		or event.is_action_pressed("weapon")
		or event.is_action_pressed("left_mouse")
		or event.is_action_pressed("right_mouse")
	): return
	
	if is_typing:
		is_typing = false
		if typer is Tween: typer.kill()
		rich_text_label.visible_ratio = 1.0
	else:
		hide()
		get_tree().paused = false
		get_viewport().set_input_as_handled()
		Events.dialog_finished.emit()

func type_dialog(bbcode: String) -> void:
	is_typing = true
	get_tree().paused = true
	show()
	rich_text_label.text = bbcode
	var total_characters: int = rich_text_label.text.length()
	var duration: float = total_characters * CHARACTER_DISPLAY_DURATION
	typer = create_tween()
	typer.tween_method(set_visible_characters, 0, total_characters, duration)
	await typer.finished
	is_typing = false

func set_visible_characters(index: int) -> void:
	rich_text_label.visible_characters = index
