extends State

@export var timer : Timer

func init() -> void:
	enemy.make_path_to_player()
	timer.start()
		
func update():
	pass
	
func fixed_update():
	enemy.move()
	if !enemy.player_in_range:
		state_machine.change_state_str("Patrol")
		
	
func exit() -> void:
	timer.stop()


func _on_path_updater_timeout() -> void:
	enemy.make_path_to_player()
