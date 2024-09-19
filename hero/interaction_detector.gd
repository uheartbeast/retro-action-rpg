class_name InteractionDetector
extends Area2D

func trigger_interaction() -> void:
	var interactioins = get_overlapping_areas()
	for interaction: Interaction in interactioins:
		interaction.run()

func can_interact() -> bool:
	return (not get_overlapping_areas().is_empty())
