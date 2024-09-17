class_name HealthUI
extends HBoxContainer

var stats: = ReferenceStash.hero_stats as Stats

@onready var hearts: HBoxContainer = $Hearts

func _ready() -> void:
	stats.max_health_changed.connect(update_max_hearts)
	stats.health_changed.connect(update_hearts)
	update_max_hearts(stats.max_health)
	update_hearts(stats.health)

func update_max_hearts(max_health_amount: int) -> void:
	for i in hearts.get_child_count():
		var heart_ui: = hearts.get_child(i)
		heart_ui.visible = (i < max_health_amount)

func update_hearts(health_amount: float) -> void:
	for i in hearts.get_child_count():
		var heart_ui: = hearts.get_child(i) as HeartUI
		if not heart_ui.visible: break
		
		var leftover_health: = health_amount - i
		heart_ui.update_quarter_hearts(leftover_health)
