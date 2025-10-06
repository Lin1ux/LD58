extends Health

@export var block : int
@export var base_health : Health

func init(start_hp : int) -> void:
	base_health.init(start_hp)

func increase_hp(value : int):
	base_health.increase_hp(value)
		
func decrease_hp(value : int):
	value -= block
	if value < 0:
		return
	base_health.decrease_hp(value)
	
	
