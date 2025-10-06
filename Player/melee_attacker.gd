extends Node2D
class_name MelleAtacker

@onready var attack_area: Area2D = $attack_area
@onready var collision_shape_2d: CollisionShape2D = $attack_area/CollisionShape2D
@onready var animSprite: AnimatedSprite2D = $attack_area/AnimatedSprite2D



func attack(size : Vector2 = Vector2.ONE * 200, damage: int = 0):
	animSprite.play("attack")
	collision_shape_2d.shape.size = size
	attack_area.position.x = size.x/2
	look_at(get_global_mouse_position())
	for x in attack_area.get_overlapping_areas():
		var hp_component : HpComponent = x as HpComponent
		if hp_component != null:
			hp_component.health.decrease_hp(damage)
