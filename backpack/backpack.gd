extends Control

@export var backpack_size : Vector2i
@onready var grid_container: GridContainer = $GridContainer
@onready var texture_rect: TextureRect = $GridContainer/TextureRect
const ITEM = preload("uid://c0fui50daxc8i")



var items : Array[Array]

var curently_held : Item
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			curently_held = ITEM.instantiate()
			add_child(curently_held)

			var pos: Vector2i= get_local_mouse_position()
			var coords: Vector2i= pos/ GameInfo.backpack_cell_size
			print(coords)
			if check_bounds(coords):
				items[coords.y][coords.x] = curently_held
				curently_held.position = coords * GameInfo.backpack_cell_size
				curently_held.visible = false
				curently_held.placement = coords


		if event.button_index == 2 and event.is_pressed():
			curently_held.orientation+=1


func check_bounds(vec : Vector2i)->bool:
	if vec.x >= backpack_size.x:
		return false
	if vec.x < 0:
		return false

	if vec.y >= backpack_size.y:
		return false
	if vec.y < 0:
		return false

	return true

func _ready() -> void:
	texture_rect.size = Vector2(GameInfo.backpack_cell_size,GameInfo.backpack_cell_size)
	items.resize(backpack_size.y)
	for y in range(backpack_size.y):
		items[y].resize(backpack_size.x)
		for x in range(backpack_size.x):
			var place = texture_rect.duplicate()
			grid_container.add_child(place)
			place.set_meta("location",Vector2i(x,y))



	grid_container.columns = backpack_size.x
	grid_container.remove_child(texture_rect)

func _process(delta: float) -> void:
	if curently_held:
		curently_held.queue_redraw()
	queue_redraw()


func _draw() -> void:
	for row in items:
		for cell : Item in row:
			if cell == null:
				continue
			var rect := Rect2(cell.placement * GameInfo.backpack_cell_size,Vector2(GameInfo.backpack_cell_size,GameInfo.backpack_cell_size) )
			#print(cell.placement)
			draw_rect(rect,Color.AQUAMARINE,false,3)
