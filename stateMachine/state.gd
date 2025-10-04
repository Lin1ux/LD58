class_name State
extends Node

@export var next_state : State
var state_machine : StateMachine

func _ready() -> void:
	state_machine = get_parent()

func init() -> void:
	print("Init")
	
func update():
	print("Update")
	
func fixed_update():
	print("Fixed Update")
	
func exit() -> void:
	print("Exit")
	state_machine.change_state(next_state)
