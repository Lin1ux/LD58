class_name Health
extends Node

signal dead

var health : int
var max_health : int

func init(start_hp : int) -> void:
	max_health = start_hp
	health = max_health

func increase_hp(value : int):
	health += value
	if max_health < health:
		health = max_health
		
func decrease_hp(value : int):
	health -= value
	if health <= 0:
		health = 0
		dead.emit()
	print("Current Health =",health)
		
	
