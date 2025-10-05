extends Node2D
class_name ProjectileShooter



func shoot_projectile_straight(projectile : ):
	Holder.add_child(projectile)
	var direction = (get_global_mouse_position()- global_position).normalized()
	projectile.global_position = global_position
	projectile.initiate_projectile(direction)
