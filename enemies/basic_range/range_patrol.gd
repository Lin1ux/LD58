extends State

var target_position : Vector2
@export var timer : Timer

func _ready() -> void:
	super._ready()
	timer.set_paused(true)

func init() -> void:
	timer.set_paused(false)
	if enemy.nav_region != null:
		target_position = NavigationServer2D.region_get_random_point(enemy.nav_region.get_rid(), 1, false)
		#print(NavigationServer2D.region_get_random_point(enemy.nav_region.get_rid(), 1, false))
		enemy.make_path_to_point(target_position)
	else:
		target_position = Vector2.ZERO
	
func update():
	if target_position == Vector2.ZERO:
		init()
	
func fixed_update():
	enemy.move()
	if enemy.nav_agent.is_navigation_finished():
		state_machine.change_state_str("RangePatrol")
	
func exit() -> void:
	timer.set_paused(true)

func _on_reload_timer_timeout() -> void:
	if enemy.player_in_range:
		state_machine.change_state_str("Shoot")
		
