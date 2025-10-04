extends Node2D

@export var nav_region : NavigationRegion2D

func _ready():
	set_region()

func set_region():
	for i in self.get_children():
		i.nav_region = nav_region
