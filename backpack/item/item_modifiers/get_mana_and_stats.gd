extends ItemEffect
class_name GetProjectileWithCharge

@export var mana_total : int = 1
var mana_left =1
@export var projectile : BaseProjectile

func reset():
	mana_left = mana_total

func execute(params : CastParams):
	if(mana_left <= 0):
		return
	if params.projectile != null:
		return

	mana_left-=params.required_mana
	if mana_left < 0:
		params.required_mana = abs(mana_left)
