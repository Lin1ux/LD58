class_name Enemy_Projectile_Spawner
extends Node2D

@export var enemy : Enemy
#@export var projectile : PackedScene
@export var dmg : int
@export var speed : float = 400
	
func _ready():
	dmg = enemy.stats.dmg
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_projectile(attack_pattern : PackedScene):
	var projectile : BaseProjectile = attack_pattern.instantiate()
	if projectile is not BaseProjectile || projectile == null:
		print("pattern is null")
		return
	Holder.add_child(projectile)
	#var direction = (get_global_mouse_position() - global_position).normalized()
	var direction = enemy.global_position.direction_to(GameInfo.player.global_position)
	projectile.global_position = global_position
	projectile.damage = dmg
	projectile.speed = speed
	projectile.initiate_projectile(direction)
