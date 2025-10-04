extends Area2D
class_name BaseProjectile

@export var direction: Vector2
@export var damage: int
@export var speed : float


func initiate_projectile(vec: Vector2) -> void:
	direction = vec * speed


func _process(delta: float) -> void:
	position += direction * delta
