extends Node2D
class_name MeleeAtacker

@export var attack_area: Area2D
@export var collision_shape_2d: CollisionShape2D
@export var enemy: Enemy

func attack(size : Vector2 = Vector2.ONE * 200, callback : Callable = func x() : pass):
	collision_shape_2d.shape.size = size
	attack_area.position.x = size.x/2
	look_at(GameInfo.player.global_position)
	for x in attack_area.get_overlapping_areas():
		var hp_component : HpComponent = x as HpComponent
		if hp_component != null:
			hp_component.health.decrease_hp(enemy.stats.dmg)
		#print("hitting ", x.name)
