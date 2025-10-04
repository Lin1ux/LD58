extends Node2D
class_name LevelChunkLink

signal activated()

var can_trigger: bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and can_trigger:#Player
		activated.emit()


func _on_timer_timeout() -> void:
	can_trigger = true


func _on_tree_entered() -> void:
	$Timer.start()


func _on_tree_exited() -> void:
	can_trigger = false
