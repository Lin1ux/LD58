extends Node


var player : Player :
	get():
		if player == null:
			player = get_tree().get_first_node_in_group("Player")
		return player

var nav_region : NavigationRegion2D :
	get():
		if nav_region == null:
			nav_region = get_tree().get_first_node_in_group("NavRegion")
		return nav_region
