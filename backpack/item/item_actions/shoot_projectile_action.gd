extends ItemAction
class_name ShootProjectile

var shooter : ProjectileShooter

func execute(params : CastParams):
	if shooter == null:
		shooter = GameInfo.player.get_node("ProjectileShooter")
	shooter.shoot_projectile_straight(params.projectile)
