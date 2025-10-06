extends ChunkResource
class_name ChunkResourceRandom

var chunks: Array = [
	preload("res://chunk_manager/chunks/chunk_corridor_cross.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_cross.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_knigths.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_rangers.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_shield_wall.gd").new(),
	preload("res://chunk_manager/chunks/enemy_box.gd").new(),
]
@export var propagate_random: bool = true

func scene_instantiate() -> LevelChunk:
	var c: LevelChunk = load(chunks.pick_random().duplicate().scene_path).instantiate()
	c.chunk_resource = self
	scene = c

	if propagate_random:
		left = chunks.pick_random().duplicate()
		left.right = self
		left.scene_right = scene

	if propagate_random:
		right = chunks.pick_random().duplicate()
		right.left = self
		right.scene_left = scene

	if propagate_random:
		up = chunks.pick_random().duplicate()
		up.down = self
		up.scene_down = scene

	if propagate_random:
		down = chunks.pick_random().duplicate()
		down.up = self
		down.scene_up = scene

	return c
