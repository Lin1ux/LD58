extends Node2D

@export var chunk: ChunkResource


func _ready() -> void:
	var c: LevelChunk = chunk.scene_instantiate()
	add_child(c)
