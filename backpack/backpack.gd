extends Control

@export var backpack_size : Vector2i
@onready var grid_container: GridContainer = $GridContainer
@onready var texture_rect: TextureRect = $GridContainer/TextureRect

var items : Array[Array]


func check_and_mark(item: Item, position_x: int, position_y: int) -> bool:
	for vector in item.spaces_taken:
		if( items[position_y + vector.y][position_x + vector.x] == true):
			return false
	for vector in item.spaces_taken:
		items[position_y][position_x] = true
	return true

func _ready() -> void:
	items.resize(backpack_size.y)
	for y in range(backpack_size.y):
		items[y].resize(backpack_size.x)
		for x in range(backpack_size.x):
			grid_container.add_child(texture_rect.duplicate())


	grid_container.columns = backpack_size.x
	grid_container.remove_child(texture_rect)
