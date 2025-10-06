class_name Enemy_Area_Spawner
extends Node2D

@export var enemy : Enemy
@export var dmg : int
	
func _ready():
	dmg = enemy.stats.dmg
	
func spawn_area(attack_pattern : PackedScene):
	var area : DamageArea = attack_pattern.instantiate()
	if area is not DamageArea || attack_pattern == null:
		print("area is null")
		return
	Holder.add_child(area)
	area.global_position = GameInfo.player.global_position
	area.damage = dmg
