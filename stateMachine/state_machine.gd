class_name StateMachine
extends Node

@export var start_state : State
var current_state : State

func _ready() -> void:
	current_state = start_state
	current_state.init()

func _process(delta: float) -> void:
	current_state.update()

func _physics_process(delta: float) -> void:
	current_state.fixed_update()

func change_state(next_state : State):
	current_state.exit()
	current_state = next_state
	current_state.init()

func change_state_str(next_state : String):
	var state = get_node(next_state)
	if state == null:
		printerr("unknown State")
		return
	current_state = state
	current_state.init()
#func _process(delta: float) -> void:
