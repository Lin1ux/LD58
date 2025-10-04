extends Node

@export var player : CharacterBody2D
@export var nav_region : NavigationRegion2D
@export var enemy_box : Node2D

func _ready() -> void:
	set_enemies()
	
func set_enemies():
	for i in enemy_box.get_children():
		i.player = player
		i.nav_region = nav_region
