extends Control
class_name Item

#region przestrzen igora
@export var spaces_taken: Array[Vector2i]

@export var spaces_starred: Array[Vector2i]
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

@export var proj : PackedScene

func do() -> void:
	var x : ItemEffect= get_node("combat_start") as ItemEffect
	var params : CastParams = CastParams.new()
	params.item = self
	params.projectile = proj.instantiate() as BaseProjectile


	x.execute(params)
