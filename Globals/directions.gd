class_name Direction
extends Node

enum Dir { UP, DOWN, LEFT, RIGHT }

static func get_direction(dir : Vector2) -> Dir:
	if abs(dir.x) > abs(dir.y):
		if dir.x >= 0:
			return Direction.Dir.RIGHT
		return Direction.Dir.LEFT
	if dir.y >= 0:
		return Direction.Dir.UP
	return Direction.Dir.DOWN
