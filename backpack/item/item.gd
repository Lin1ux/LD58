extends Control
class_name Item

#region przestrzen igora

@export var spaces_taken: Array[Vector2i]
@export var spaces_starred: Array[Vector2i]



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
		draw_rect(rect,Color.GREEN)

@export var proj : PackedScene
var placement : Vector2i


func rotate_vector(vec : Vector2):
	match orientation:
		0:
			return vec
		1:
			return Vector2(-vec.y,vec.x)
		2:
			return Vector2(-vec.x,-vec.y)
		3:
			return Vector2(vec.y,-vec.x)

func get_rotated_ocupations():
	return spaces_taken.map(func (vec): rotate_vector(vec))

func do() -> void:
	var x : ItemEffect= get_node("combat_start") as ItemEffect
	var params : CastParams = CastParams.new()
	params.item = self
	params.projectile = proj.instantiate() as BaseProjectile


	x.execute(params)
