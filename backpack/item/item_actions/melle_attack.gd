extends ItemAction
class_name MeleeAttack


var attacker : MelleAtacker
@export var attack_size : Vector2
@export var damage : int

func execute(params : CastParams):
	if attacker == null:
		attacker = GameInfo.player.get_node("MeleeAttacker")
	attacker.attack(attack_size,callback)

func callback(hp : HpComponent):
	hp.health.decrease_hp(damage)
