extends Control
class_name Backpack

@export var backpack_size : Vector2i
@onready var grid_container: GridContainer = $GridContainer
@onready var texture_rect: TextureRect = $GridContainer/TextureRect

const item_instances: Dictionary[String, PackedScene] = {
	"Basic Arrow": preload("res://backpack/item/instances/arrow_baisic.tscn"),
	"Battery": preload("res://backpack/item/instances/battery.tscn"),
	"Longbow": preload("res://backpack/item/instances/bow2.tscn"),
	"Shortbow": preload("res://backpack/item/instances/bow.tscn"),
	"Phone": preload("res://backpack/item/instances/phone.tscn"),
	"Recorder": preload("res://backpack/item/instances/recorder.tscn"),
	"Greatsword": preload("res://backpack/item/instances/sword2.tscn"),
	"Sword": preload("res://backpack/item/instances/sword.tscn"),
	"Cocktail :)": preload("res://backpack/item/instances/wybuchov.tscn"),
}

var items : Array[Array]

var curently_held : Item
func _input(event: InputEvent) -> void:
	if not visible:
		return

	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			if curently_held != null:
				place_item()


		if event.button_index == 2 and event.is_pressed():

			if curently_held != null:
				curently_held.orientation+=1
			else:
				pick_up_item()


func place_item():
	if not visible:
		return


	var pos: Vector2i= get_local_mouse_position()
	var coords: Vector2i= pos/ GameInfo.backpack_cell_size


	for item_coord in curently_held.get_rotated_ocupations():

		var pom =coords + item_coord
		if not check_bounds(pom):
			return
		if not check_is_free(pom):
			return

	for item_coord in curently_held.get_rotated_ocupations():

		var pom =coords + item_coord


		items[pom.y][pom.x] = curently_held
		curently_held.position = coords * GameInfo.backpack_cell_size
		curently_held.placement = coords
	curently_held = null

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

func check_is_free(vec: Vector2i)->bool:
	return items[vec.y][vec.x]==null

func pick_up_item():
	var pos: Vector2i= get_local_mouse_position()
	var coords: Vector2i= pos/ GameInfo.backpack_cell_size

	if check_bounds(coords):
		var previev :Item= items[coords.y][coords.x]

		if previev == null:
			return
		curently_held = previev

		for p in curently_held.get_rotated_ocupations():
			var vec = p + curently_held.placement
			items[vec.y][vec.x] = null

func item_select(item: String) -> void:
	curently_held = item_instances[item].instantiate()
	add_child(curently_held)

func _ready() -> void:
	visible = false


	for ii in item_instances:
		var b := Button.new()
		b.text = ii
		b.pressed.connect(item_select.bind(ii))
		$VBoxContainer.add_child(b)


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
	if Input.is_action_just_pressed("backpack"):
		visible = not visible

	if not visible:
		return

	if curently_held:
		curently_held.position = get_global_mouse_position()
		curently_held.queue_redraw()

	queue_redraw()




func _draw() -> void:
	if not visible:
		return

	for row in range(items.size()):
		for coll in range(backpack_size.x):
			var cell: Item = items[row][coll]
			if cell == null:
				continue
			var rect := Rect2(Vector2(coll,row) * GameInfo.backpack_cell_size,Vector2(GameInfo.backpack_cell_size,GameInfo.backpack_cell_size) )
			#print(cell.placement)
			draw_rect(rect,Color.AQUAMARINE,false,3)
	var pos: Vector2i= get_local_mouse_position()
	var coords: Vector2i= pos/ GameInfo.backpack_cell_size

	if check_bounds(coords):
		var previev :Item= items[coords.y][coords.x]
		if previev != null:
			for x in previev.get_rotated_stars():

				var rect = Rect2((previev.placement + x) * GameInfo.backpack_cell_size,Vector2(20,20))
				draw_rect(rect,Color.YELLOW)


func _on_clear_pressed() -> void:
	for row in range(len(items)):
		for item in range(len(items[row])):
			if items[row][item] != null:
				items[row][item].queue_free()
				items[row][item] = null
