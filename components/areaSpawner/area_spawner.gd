class_name AreaSpawner
extends Node2D

@export var player : Player
@export var dmg : int

func spawn_area_in_global_holder(area : DamageArea):
	#var area : DamageArea = attack_pattern.instantiate()
	if area == null:
		print("area is null")
		return
	Holder.add_child(area)
	area.global_position = get_global_mouse_position()	#TODO add max range for this and check if it's on map etc.

func spawn_area_in_holder(area : DamageArea):
	#var area : DamageArea = attack_pattern.instantiate()
	if area == null:
		print("area is null")
		return
	self.add_child(area)
	area.global_position = self.global_position
