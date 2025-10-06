extends ItemEffect
class_name ItemEffectArray


@export var effects : Array[ItemAction] =[]


func execute(params : CastParams):
	print("working")
	for effect in effects:
		effect.execute(params)
