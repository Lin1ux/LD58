extends Control

@export var backpack_size : Vector2i
@onready var grid_container: GridContainer = $GridContainer
@onready var texture_rect: TextureRect = $GridContainer/TextureRect

var items : Array[Array]


func _ready() -> void:
	items.resize(backpack_size.y)
	for y in range(backpack_size.y):
		items[y].resize(backpack_size.x)
		for x in range(backpack_size.x):
			grid_container.add_child(texture_rect.duplicate())


	grid_container.columns = backpack_size.x
	grid_container.remove_child(texture_rect)
