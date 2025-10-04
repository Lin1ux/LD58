extends State

@export var enemy: Enemy
var target_position : Vector2

func init() -> void:
	target_position = enemy.global_position + Vector2(randf_range(-10,10), randf_range(-10,10))
	#NavigationServer2D.region_get_random_point(enemy.nav_agent.get_rid(), 1, false)
	#if enemy.nav_agent.is_target_reachable():
	#	enemy.make_path_to_point(target_position)
	#	print("New Point", target_position)
	#else:
	#	init()
	
func update():
	pass
	#print(NavigationServer2D.region_get_random_point(enemy.nav_region.get_rid(), 1, false))
	#print("Update")
	
func fixed_update():
	return
	enemy.move()
	if enemy.nav_agent.is_target_reached():
		exit()
	
func exit() -> void:
	print("Exit")
	state_machine.change_state_str("Patrol")
