class_name BounceProjectile
extends BaseProjectile

@export var number_of_bounces : int = 3

func _on_area_entered(area: Area2D) -> void:
	var hp_component : HpComponent = area as HpComponent
	if hp_component != null:
		hp_component.health.decrease_hp(damage)
	direction *= -1
	number_of_bounces -= 1
	if number_of_bounces == 0:
		queue_free()

func on_wall_hit(body: Node2D):
	queue_free()
