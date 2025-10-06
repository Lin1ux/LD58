extends Area2D
class_name BaseProjectile

@export var direction: Vector2
@export var damage: int
@export var speed : float
@export var sprite : Sprite2D

func initiate_projectile(vec: Vector2) -> void:
	print("speeeed",speed)
	direction = vec * speed
	rotation = direction.angle() + deg_to_rad(-90)

func _process(delta: float) -> void:
	position += direction * delta


func _on_area_entered(area: Area2D) -> void:
	print("area: ",area)
	var hp_component : HpComponent = area as HpComponent
	if hp_component != null:
		hp_component.health.decrease_hp(damage)
	queue_free()
