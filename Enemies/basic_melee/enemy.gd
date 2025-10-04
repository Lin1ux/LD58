extends CharacterBody2D

@export var stats : enemy_stats
@export var hp : Health
@export var player : CharacterBody2D

var nav_agent : NavigationAgent2D

var player_in_range : bool = false

func _ready():
	nav_agent = $NavigationAgent2D as NavigationAgent2D
	hp.init(stats.hp)
	
#Przenieść później do maszyny stanów
func _physics_process(delta: float) -> void:
	move_towards_player()
	
func move_towards_player():
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * stats.speed
	move_and_slide()
	
func make_path_to_player():
	nav_agent.target_position = player.global_position 

func deal_damage(value : int):
	hp.decrease_hp(value)
	if hp.health < 0:
		queue_free()
	
func heal(value : int):
	hp.increase_hp(value)

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true
	print("Player In")

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
	print("Player Out")

func _on_make_path_timer_timeout() -> void:
	make_path_to_player()
