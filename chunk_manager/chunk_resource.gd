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

	if left:
		left.right = self
		left.scene_right = scene

	if right:
		right.left = self
		right.scene_left = scene

	if up:
		up.down = self
		up.scene_down = scene

	if down:
		down.up = self
		down.scene_up = scene

	return c
