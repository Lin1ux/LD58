extends Node
class_name ItemEffect


@export var effects : Array[ItemAction] =[]


func execute(params : CastParams):
	for effect in effects:
		effect.execute(params)
