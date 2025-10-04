extends Node

@export var player : CharacterBody2D
@export var enemy_box : Node2D

func _ready() -> void:
	set_player_for_enemies()
	
func set_player_for_enemies():
	for i in enemy_box.get_children():
		i.player = player
