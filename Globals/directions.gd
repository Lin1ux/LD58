class_name Direction
extends Node2D

enum Dir { UP, DOWN, LEFT, RIGHT }

static func get_direction(dir : Vector2) -> Dir:
	if abs(dir.x) > abs(dir.y):
		if dir.x >= 0:
			return Direction.Dir.RIGHT
		return Direction.Dir.LEFT
	if dir.y >= 0:
		return Direction.Dir.UP
	return Direction.Dir.DOWN
	
static func random_vector(min : float ,max : float) -> Vector2:
	return Vector2(randf_range(min,max),randf_range(min,max))
	
func get_mouse_position() -> Vector2:
	return get_global_mouse_position()
