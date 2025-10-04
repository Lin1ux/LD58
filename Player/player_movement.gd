extends CharacterBody2D
class_name Player

@export var SPEED : float = 300.0
@export var animSprite : AnimatedSprite2D

func _physics_process(delta: float) -> void:
	

	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if velocity.x == 0 && velocity.y == 0:
		animSprite.play("idle")
		animSprite.scale.x = 1
	else:
		play_animation_based_on_direction(velocity)
			

	move_and_slide()
	
func play_animation_based_on_direction(dir : Vector2):
	if animSprite != null:
		match Direction.get_direction(dir):
			Direction.Dir.UP: 
				animSprite.play("walk_up")
				animSprite.scale.x = 1
			Direction.Dir.DOWN: 
				animSprite.play("walk_down")
				animSprite.scale.x = 1
			Direction.Dir.LEFT: 
				animSprite.play("walk_right")
				animSprite.scale.x = -1
			Direction.Dir.RIGHT: 
				animSprite.play("walk_right")
				animSprite.scale.x = 1
