extends ItemAction
class_name SelfAreaAttack

var attacker : AreaSpawner
@export var attack_size : Vector2
@export var damage : int
@export var area : PackedScene
@export var scale : float

@export var mana_cost : int = 1

func execute(params : CastParams):

	params.required_mana = mana_cost

	for stared_item in params.item.get_starred_items():
		var getter = stared_item.get_node_or_null("GetManaAndStats") as GetManaAndStats
		if getter != null:
			getter.execute(params)

	print("required mana ",params.required_mana)
	if(params.required_mana > 0):
		return

	if attacker == null:
		attacker = GameInfo.player.get_node("AreaSpawner")
	var area_attack : DamageArea = area.instantiate()
	area_attack.damage = damage + params.dmg
	area_attack.scale = Vector2(scale + params.scale,scale + params.scale)
	attacker.spawn_area_in_holder(area_attack)
