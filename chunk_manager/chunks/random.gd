extends ChunkResource
class_name ChunkResourceRandom

var chunks: Array = [
	preload("res://chunk_manager/chunks/chunk_corridor_cross.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_cross.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_easy.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_knigths.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_rangers.gd").new(),
	preload("res://chunk_manager/chunks/chunk_enemy_shield_wall.gd").new(),
]
@export var propagate_random: bool = true

func scene_instantiate() -> LevelChunk:
	if scene == null:
		var aaa = chunks.pick_random().duplicate()
		var path = aaa.scene_path
		var sc = load(path)
		var c: LevelChunk = sc.instantiate()
		c.chunk_resource = self
		scene = c

		if propagate_random:
			left = ChunkResourceRandom.new()
			left.right = self
			left.scene_right = scene

		if propagate_random:
			right = ChunkResourceRandom.new()
			right.left = self
			right.scene_left = scene

		if propagate_random:
			up = ChunkResourceRandom.new()
			up.down = self
			up.scene_down = scene

		if propagate_random:
			down = ChunkResourceRandom.new()
			down.up = self
			down.scene_up = scene

		return c
	return scene
