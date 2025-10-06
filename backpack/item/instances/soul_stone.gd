extends Node

func _ready() -> void:
	GlobalSignals.enemy_dead.connect(add_charge)

func add_charge()->void:
	$"../GetManaAndStats".mana_left = $"../GetManaAndStats".mana_total
	print("soul stone regaind mana")
