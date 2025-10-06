extends Control

@export var timer : Timer
@export var hp_bar : ProgressBar
@export var damage_bar : ProgressBar

var hp

func _ready():
	GlobalSignals.player_get_damage.connect(update_hp_bar)
	init_health(GameInfo.player.HP.health)
	
func _process(delta: float) -> void:
	if hp == 0:
		init_health(GameInfo.player.HP.health)

func init_health(value : int):
	print("zajebie sie",value)
	hp = value
	hp_bar.max_value = hp
	hp_bar.min_value = 0
	hp_bar.value = value
	damage_bar.max_value = hp
	damage_bar.min_value = 0
	damage_bar.value = value
	
func update_hp_bar():
	print("UPDATE HP BAR")
	hp_bar.value = GameInfo.player.HP.health
	hp = hp_bar.value
	timer.start()
	print("HP",hp)

func _on_timer_timeout() -> void:
	damage_bar.value = hp
	print("TIME OUT")
