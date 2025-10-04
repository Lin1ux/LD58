extends CharacterBody2D

var player_in_range : bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true
	print("Player In")

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
	print("Player Out")
