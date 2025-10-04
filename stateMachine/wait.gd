extends State

@export var timer : Timer
@export var next_state : String

func _ready() -> void:
	super._ready()
	timer.stop()

func init():
	timer.start()
	
func exit():
	timer.stop()

func _on_wait_timer_timeout() -> void:
	state_machine.change_state_str(next_state)
