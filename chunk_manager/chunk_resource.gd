extends Resource
class_name ChunkResource

var scene: String = ""

@export var left: ChunkResource
@export var right: ChunkResource
@export var up: ChunkResource
@export var down: ChunkResource


func scene_instantiate() -> LevelChunk:
	var c: LevelChunk = load(scene).instantiate()
	c.chunk_left = left
	c.chunk_right = right
	c.chunk_up = up
	c.chunk_down = down
	return c
