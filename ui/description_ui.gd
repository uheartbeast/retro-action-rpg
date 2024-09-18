class_name DescriptionUI
extends PanelContainer

@onready var title_label: Label = %TitleLabel
@onready var description_label: RichTextLabel = %DescriptionLabel

func _ready() -> void:
	Events.request_description.connect(_update_description)

func _update_description(title: String, description: String) -> void:
	if title.is_empty() and description.is_empty():
		hide()
	else:
		show()
		title_label.text = title
		description_label.text = description
