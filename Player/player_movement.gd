extends CharacterBody2D
class_name Player

var input_queue: Array[Direction.Dir] = []
var _input_queue_first: Direction.Dir

func input_queue_push(input: Direction.Dir) -> void:
	if input_queue.has(input):
		input_queue.erase(input)
	input_queue.append(input)
	
func input_queue_erase(input: Direction.Dir) -> void:
	if input_queue.has(input):
		input_queue.erase(input)
		
func input_queue_first() -> Direction.Dir:
	if input_queue.size() == 0:
		return _input_queue_first
	_input_queue_first = input_queue[0]
	return _input_queue_first

@export var start_HP = 10
@export var SPEED : float = 300.0
@export var ACCEL: float = 30
@export var decel: float = 0.8
@export var idle_threshold: float = 1
@export var animSprite : AnimatedSprite2D
@export var HP : Health

func _ready():
	HP.init(start_HP)
	HP.dead.connect(kill_player)	
	HP.hp_changed.connect(hp_changed)
	HP.damage_dealt.connect(get_damage)

func _physics_process(_delta: float) -> void:

	var direction_x := Input.get_axis("move_left", "move_right")
	var direction_y := Input.get_axis("move_up", "move_down")

	if Input.is_action_just_pressed("move_left"):
		input_queue_push(Direction.Dir.LEFT)
	if Input.is_action_just_released("move_left"):
		input_queue_erase(Direction.Dir.LEFT)
	if Input.is_action_just_pressed("move_right"):
		input_queue_push(Direction.Dir.RIGHT)
	if Input.is_action_just_released("move_right"):
		input_queue_erase(Direction.Dir.RIGHT)
	if Input.is_action_just_pressed("move_up"):
		input_queue_push(Direction.Dir.UP)
	if Input.is_action_just_released("move_up"):
		input_queue_erase(Direction.Dir.UP)
	if Input.is_action_just_pressed("move_down"):
		input_queue_push(Direction.Dir.DOWN)
	if Input.is_action_just_released("move_down"):
		input_queue_erase(Direction.Dir.DOWN)

	if direction_x:
		velocity.x += direction_x * ACCEL
	else:
		velocity.x *= decel
	velocity.x = clamp(velocity.x, -SPEED, SPEED)
	if abs(velocity.x) < idle_threshold:
		velocity.x = 0


	if direction_y:
		velocity.y += direction_y * ACCEL
	else:
		velocity.y *= decel
	velocity.y = clamp(velocity.y, -SPEED, SPEED)
	if abs(velocity.y) < idle_threshold:
		velocity.y = 0

	if velocity.length() == 0:
		animSprite.play("idle")
		animSprite.scale.x = 1
	else:
		play_animation_based_on_direction()


	move_and_slide()

func play_animation_based_on_direction():
	if animSprite != null:
		match input_queue_first():
			Direction.Dir.UP:
				animSprite.play("walk_down")
				animSprite.scale.x = 1
			Direction.Dir.DOWN:
				animSprite.play("walk_up")
				animSprite.scale.x = 1
			Direction.Dir.LEFT:
				animSprite.play("walk_right")
				animSprite.scale.x = -1
			Direction.Dir.RIGHT:
				animSprite.play("walk_right")
				animSprite.scale.x = 1
	
func kill_player():
	print("Player Killed")
	
func hp_changed(percantege : float):
	GlobalSignals.player_amount_hp.emit(percantege)
	
func get_damage():
	GlobalSignals.player_get_damage.emit()
