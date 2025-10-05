class_name enemy_stats
extends Resource

@export var can_flip_sprite : bool 
@export_group("Base Statistisc")
@export var hp : int
@export var speed : float
@export var dmg : int
@export_group("Range parameters")
@export var attack_pattern : PackedScene
@export_group("Melee parameters")
@export var melee_attack_range : float
