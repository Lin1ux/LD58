extends Area2D
class_name BaseProjectile

@export var direction: Vector2
@export var damage: int
@export var speed : float

func initiate_projectile(vec: Vector2) -> void:
	direction = vec * speed

func _process(delta: float) -> void:
	position += direction * delta


func _on_area_entered(area: Area2D) -> void:
	var hp_component : HpComponent = area as HpComponent
	if hp_component != null:
		hp_component.health.decrease_hp(damage)
		queue_free()
