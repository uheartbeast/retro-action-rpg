class_name Dialogbox
extends PanelContainer

@onready var rich_text_label: RichTextLabel = $MarginContainer/RichTextLabel

func _ready() -> void:
	rich_text_label.bbcode_enabled = true
	Events.request_show_dialog.connect(type_dialog)


func type_dialog(bbcode: String) -> void:
	pass
