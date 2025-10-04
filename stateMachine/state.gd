class_name State
extends Node

@export var enemy: Enemy
var state_machine : StateMachine

func _ready() -> void:
	state_machine = get_parent()

func init() -> void:
	print("Init")
	
func update():
	pass
	#print("Update")
	
func fixed_update():
	pass
	#print("Fixed Update")
	
func exit() -> void:
	print("Exit")
	state_machine.change_state_str("")
