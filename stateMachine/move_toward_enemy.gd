extends State

@export var timer : Timer

func _ready() -> void:
	super._ready()
	timer.stop()

func init() -> void:
	enemy.make_path_to_player()
	timer.start()
	
func fixed_update():
	enemy.move()
	if !enemy.player_in_range:
		state_machine.change_state_str("Patrol")	
	if enemy.global_position.distance_to(GameInfo.player.global_position ) < enemy.stats.melee_attack_range:
		state_machine.change_state_str("Attack")	
	
func exit() -> void:
	timer.stop()


func _on_path_updater_timeout() -> void:
	enemy.make_path_to_player()
