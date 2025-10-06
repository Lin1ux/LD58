class_name DamageArea
extends Node

@export var damage: int
@export var area : Area2D
@export var anim_sprite : AnimatedSprite2D
	
func _ready() -> void:
	if anim_sprite != null:
		anim_sprite.play("open")	

func deal_damage():
	for i in area.get_overlapping_areas():
		var hp_component : HpComponent = i as HpComponent
		if hp_component != null:
			hp_component.health.decrease_hp(damage)

func _on_attack_damage_timeout() -> void:
	deal_damage()
	if anim_sprite != null:
		anim_sprite.play("close")


func _on_destroy_timer_timeout() -> void:
	self.queue_free()
