class_name State
extends Node

@export var enemy: Enemy
var state_machine : StateMachine

func _ready() -> void:
	state_machine = get_parent()

func init() -> void:
	pass
	
func update():
	pass
	
func fixed_update():
	pass
	
func exit() -> void:
	pass
