extends State

@export var timer : Timer

func _ready() -> void:
	super._ready()
	timer.stop()

func init():
	timer.start()
	if enemy.animSprite != null:
		enemy.animSprite.play("idle")
	
func exit():
	enemy.attack()
	timer.stop()
	

func _on_wait_timer_timeout() -> void:
	state_machine.change_state_str("MoveTowardEnemy")
