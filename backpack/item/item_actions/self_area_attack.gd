extends ItemAction
class_name SelfAreaAttack


var attacker : AreaSpawner
@export var attack_size : Vector2
@export var damage : int
@export var area : PackedScene
@export var scale : float

func execute(params : CastParams):
	if attacker == null:
		attacker = GameInfo.player.get_node("AreaSpawner")
	var area_attack : DamageArea = area.instantiate()
	area_attack.damage = damage + params.dmg
	area_attack.scale = Vector2(scale + params.scale,scale + params.scale)
	attacker.spawn_area_in_holder(area_attack)
