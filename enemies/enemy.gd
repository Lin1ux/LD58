class_name Enemy
extends CharacterBody2D

@export_group("Stats")
@export var stats : enemy_stats
@export_group("Children")
@export var hp : Health
@export var nav_agent : NavigationAgent2D
@export var animSprite : AnimatedSprite2D
@export var attack_component : Node2D
@export var anim : AnimationPlayer
@export_group("From Globals")
@export var player : CharacterBody2D
@export var nav_region : NavigationRegion2D

var player_in_range : bool = false
var enemy_direction : int = Direction.Dir.DOWN

func _ready():
	var start_hp : int = int(stats.hp + stats.hp * GameInfo.finished_rooms * stats.hp_multiplayer)
	var start_dmg : int = int(stats.dmg + stats.dmg * GameInfo.finished_rooms * stats.dmg_multiplayer)
	nav_region = GameInfo.nav_region
	hp.init(start_hp)
	hp.dead.connect(kill)
	hp.damage_dealt.connect(get_damage)

func move():
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	play_animation_based_on_direction(dir)
	velocity = dir * stats.speed
	move_and_slide()

func make_path_to_player():
	nav_agent.target_position = GameInfo.player.global_position

func make_path_to_point(new_position :Vector2):
	nav_agent.target_position = new_position

func heal(value : int):
	hp.increase_hp(value)

func play_animation_based_on_direction(dir : Vector2):
	if animSprite != null:
		animSprite.scale.x = 1
		match Direction.get_direction(dir):
			Direction.Dir.UP:
				animSprite.play("walk_up")
			Direction.Dir.DOWN:
				animSprite.play("walk_down")
			Direction.Dir.LEFT:
				if stats.can_flip_sprite:
					animSprite.play("walk_right")
					animSprite.scale.x = -1
				else:
					animSprite.play("walk_left")
			Direction.Dir.RIGHT:
				animSprite.play("walk_right")

func attack():
	if attack_component is Enemy_Projectile_Spawner:
		attack_component.spawn_projectile(stats.attack_pattern)
		return
	if attack_component is MeleeAtacker:
		attack_component.attack()
		return
	if attack_component is Enemy_Area_Spawner:
		attack_component.spawn_area(stats.attack_pattern)
		return

func get_damage():
	print("get_damage")
	if anim != null:
		anim.play("get_damage")

func kill():
	GlobalSignals.enemy_dead.emit()
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	player_in_range = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
