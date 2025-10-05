extends Control

@export var backpack_size : Vector2i
@onready var grid_container: GridContainer = $GridContainer
@onready var texture_rect: TextureRect = $GridContainer/TextureRect
const ITEM = preload("uid://c0fui50daxc8i")



var items : Array[Array]
var curently_held : Control
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			curently_held = ITEM.instantiate()
			add_child(curently_held)
		if event.button_index == 2 and event.is_pressed():
			curently_held.orientation+=1


func _ready() -> void:
	texture_rect.size = Vector2(GameInfo.backpack_cell_size,GameInfo.backpack_cell_size)
	items.resize(backpack_size.y)
	for y in range(backpack_size.y):
		items[y].resize(backpack_size.x)
		for x in range(backpack_size.x):
			grid_container.add_child(texture_rect.duplicate())



	grid_container.columns = backpack_size.x
	grid_container.remove_child(texture_rect)

func _process(delta: float) -> void:
	if curently_held:
		curently_held.position = get_global_mouse_position()
		curently_held.queue_redraw()
