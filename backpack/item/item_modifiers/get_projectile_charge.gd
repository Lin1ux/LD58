extends ItemEffect
class_name GetProjectileWithCharge

@export var charges_count : int = 1
var chargres_left =1
@export var projectile : BaseProjectile

func reset():
	chargres_left = charges_count

func execute(params : CastParams):
	if(chargres_left <= 0):
		return
	if params.projectile != null:
		return

	chargres_left-=1
	params.projectile = projectile
