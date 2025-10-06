extends ItemEffect
class_name GetManaAndStats

@export var mana_total : int = 1
var mana_left =1

@export var scale_boost :float= 0
@export var dmg_boost:int =0

func reset():
	mana_left = mana_total

func execute(params : CastParams):
	params.dmg += dmg_boost
	params.scale += scale_boost

	if(mana_left <= 0):
		return
	if params.projectile != null:
		return

	mana_left-=params.required_mana
	if mana_left < 0:
		params.required_mana = abs(mana_left)
