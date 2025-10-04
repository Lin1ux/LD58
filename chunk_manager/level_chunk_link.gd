extends Node2D
class_name LevelChunkLink

signal activated()

var triggered: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and not triggered:#Player
		triggered = true
		activated.emit()
