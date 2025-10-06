extends Control
class_name Item

#region przestrzen igora

@export var spaces_taken: Array[Vector2i]
@export var spaces_starred: Array[Vector2i]

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
		items.push_back(backpack[vec.y][vec.x])

	return items



func do() -> void:
	var x : ItemEffect= get_node("combat_start") as ItemEffect
	var params : CastParams = CastParams.new()
	params.item = self
	params.projectile = proj.instantiate() as BaseProjectile


	x.execute(params)

func _ready():
	color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1))
