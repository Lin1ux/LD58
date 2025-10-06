class_name EnemyBaseProjectile
extends BaseProjectile

func _on_area_entered(area: Area2D) -> void:
	var hp_component : HpComponent = area as HpComponent
	if hp_component != null:
		hp_component.health.decrease_hp(damage)
		queue_free()
		
