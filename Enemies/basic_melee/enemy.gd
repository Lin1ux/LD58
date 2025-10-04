extends CharacterBody2D

var player_in_range : bool = false
@export var stats : enemy_stats
@export var hp : Health

func _ready():
	hp.init(stats.hp)

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true
	print("Player In")

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
	print("Player Out")
	
func deal_damage(value : int):
	hp.decrease_hp(value)
	if hp.health < 0:
		queue_free()
	
func heal(value : int):
	hp.increase_hp(value)
