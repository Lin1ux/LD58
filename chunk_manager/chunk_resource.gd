extends Resource
class_name ChunkResource

@export var left: ChunkResource
@export var right: ChunkResource
@export var up: ChunkResource
@export var down: ChunkResource

var scene_path: String = ""

var scene: LevelChunk
var scene_left: LevelChunk
var scene_right: LevelChunk
var scene_up: LevelChunk
var scene_down: LevelChunk


func scene_instantiate() -> LevelChunk:
	var c: LevelChunk = load(scene_path).instantiate()
	c.chunk_resource = self
	scene = c

	c.chunk_left = left
	if c.chunk_left:
		c.chunk_left.right = self
		c.chunk_left.scene_right = scene

	c.chunk_right = right
	if c.chunk_right:
		c.chunk_right.left = self
		c.chunk_right.scene_left = scene

	c.chunk_up = up
	if c.chunk_up:
		c.chunk_up.down = self
		c.chunk_up.scene_down = scene

	c.chunk_down = down
	if c.chunk_down:
		c.chunk_down.up = self
		c.chunk_down.scene_up = scene

	return c
