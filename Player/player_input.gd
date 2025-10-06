extends Node
class_name PlayerInput

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		if event.is_action("primary_action"):
			action_primary.emit()
		elif event.is_action("secondary_action"):
			action_secondary.emit()
		elif event.is_action("tetiary_action"):
			action_tetiary.emit()





signal action_primary
signal action_secondary
signal action_tetiary
