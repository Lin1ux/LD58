extends Control
class_name Item

#region przestrzen igora
@export var item_name : String =""

@export var spaces_taken: Array[Vector2i]
@export var spaces_starred: Array[Vector2i]

@export var triggered : ItemEffect

var color

var orientation : int = 0 :
	set(value):
		orientation = wrapi(value,0,4)



func rotate():
	for i in len(spaces_taken):
		var val_x: int = spaces_taken[i].x
		var val_y: int = spaces_taken[i].y

		spaces_taken[i].y = -val_x
		spaces_taken[i].x = val_y
	for i in len(spaces_starred):
		var val_x: int = spaces_starred[i].x
		var val_y: int = spaces_starred[i].y

		spaces_starred[i].y = -val_x
		spaces_starred[i].x = val_y
#endregion



func _draw() -> void:
	for vec in spaces_taken:
		var rect := Rect2(rotate_vector(vec) * GameInfo.backpack_cell_size,Vector2(GameInfo.backpack_cell_size,GameInfo.backpack_cell_size))
		draw_rect(rect,color)

@export var proj : PackedScene
var placement : Vector2i


func rotate_vector(vec : Vector2i)->Vector2i:
	match orientation:
		0:
			return vec
		1:
			return Vector2i(-vec.y,vec.x)
		2:
			return Vector2i(-vec.x,-vec.y)
		3:
			return Vector2i(vec.y,-vec.x)
	return Vector2i.ZERO

func get_rotated_ocupations()->Array[Vector2i]:
	var arr : Array[Vector2i]
	for x in spaces_taken:
		arr.push_back(rotate_vector(x))
	return arr

func get_rotated_stars()->Array[Vector2i]:
	var arr : Array[Vector2i]
	for x in spaces_starred:
		arr.push_back(rotate_vector(x))
	return arr


func get_starred_items() ->Array[Item]:
	var items :Array[Item] = []

	var backpack := GameInfo.backpack

	for star_pos in get_rotated_stars():
		var vec = placement + star_pos
		var item = backpack.items[vec.y][vec.x]
		if item == null:
			continue
		if item  in items:
			continue

		items.push_back(item)

	return items



func do() -> void:
	#var x : ItemEffect= get_node("triggered") as ItemEffect
	var params : CastParams = CastParams.new()
	params.item = self
	params.projectile = proj.instantiate() as BaseProjectile


	triggered.execute(params)

func _ready():
	color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1))


func _on_input_action_primary() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	var min_x: float = 100
	var max_x: float = -100
	var min_y: float = 100
	var max_y: float = -100

	print(get_rotated_ocupations())
	for space in spaces_taken:
		min_x = min(min_x, space.x)
		min_y = min(min_y, space.y)
		max_x = max(max_x, space.x + 1)
		max_y = max(max_y, space.y + 1)

	$TextureRect.position.x = min_x * GameInfo.backpack_cell_size
	$TextureRect.position.y = min_y * GameInfo.backpack_cell_size
	$TextureRect.size.x = (max_x - min_x) * GameInfo.backpack_cell_size
	$TextureRect.size.y = (max_y - min_y) * GameInfo.backpack_cell_size

	$TextureRect.rotation = PI/2 * orientation
	if orientation == 1:
		$TextureRect.position.x += GameInfo.backpack_cell_size
	if orientation == 2:
		$TextureRect.position.x += GameInfo.backpack_cell_size
		$TextureRect.position.y += GameInfo.backpack_cell_size
	if orientation == 3:
		$TextureRect.position.y += GameInfo.backpack_cell_size

	print($TextureRect.position, $TextureRect.size)
