class_name Health
extends Node

signal dead
signal hp_changed(percentage : float)
signal damage_dealt

var health : int
var max_health : int

func init(start_hp : int) -> void:
	max_health = start_hp
	health = max_health

func increase_hp(value : int):
	health += value
	if max_health < health:
		health = max_health
	hp_changed.emit(health/max_health)
		
func decrease_hp(value : int):
	print("DMG GET: ",value)
	health -= value
	damage_dealt.emit()
	hp_changed.emit(health/max_health)
	if health <= 0:
		health = 0
		dead.emit()
		
	
