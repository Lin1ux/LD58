extends Node


var player : Player :
	get():
		if player != null:
			player = get_tree().get_first_node_in_group("Player")
		return player
