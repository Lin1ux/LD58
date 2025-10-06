extends ItemAction
class_name ShootProjectile

var shooter : ProjectileShooter

@export var damage : int
@export var speed : float 


func execute(params : CastParams):
	params.projectile.damage += damage
	params.projectile.speed += speed
	params.projectile.direction = GameInfo.player.global_position.direction_to(Directions.get_mouse_position())
	if shooter == null:
		shooter = GameInfo.player.get_node("ProjectileShooter")
	
	shooter.shoot_projectile_straight(params.projectile)
