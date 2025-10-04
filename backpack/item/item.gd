extends Control
class_name Item

#region przestrzen igora



#endregion


func _ready() -> void:
	var x = get_node("combat_start")
	var params : CastParams = CastParams.new()
	x.execute()
