extends Node

@export var enemy: Enemy
var target_position : Vector2

func init() -> void:
	target_position = NavigationServer2D.region_get_random_point(GameInfo.nav_region.get_rid(), 1, false)
	print(NavigationServer2D.region_get_random_point(GameInfo.nav_region.get_rid(), 1, false))
	enemy.make_path_to_point(target_position)
	
func update():
	if target_position == Vector2.ZERO:
		init()
	#print(NavigationServer2D.region_get_random_point(GameInfo.nav_region.get_rid(), 1, false))
	#print(NavigationServer2D.region_get_random_point(GameInfo.nav_region.get_rid(), 1, false))
	#print("Update")
	
func fixed_update():
	enemy.move()
	if enemy.nav_agent.is_navigation_finished():
		exit()
	
func exit() -> void:
	print("Exit")
	state_machine.change_state_str("Patrol")
