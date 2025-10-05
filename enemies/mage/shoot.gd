extends State

@export var timer : Timer

func _ready() -> void:
	super._ready()
	timer.set_paused(true)

func init():
	timer.set_paused(false)
	enemy.animSprite.play("idle")
	
	
func exit():
	enemy.attack()
	timer.set_paused(true)

func _on_shoot_duration_timeout() -> void:
	print("TIMER")
	state_machine.change_state_str("RangePatrol")
