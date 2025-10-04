extends Area2D
class_name LevelChunk


@export_category("Camera")
@export var lock_camera: bool = true


@export_category("Link Chunks")
@export var chunk_left: ChunkResource
@export var chunk_right: ChunkResource
@export var chunk_up: ChunkResource
@export var chunk_down: ChunkResource


@export_category("Link Nodes")
@export var link_left: LevelChunkLink = null
@export var link_right: LevelChunkLink = null
@export var link_up: LevelChunkLink = null
@export var link_down: LevelChunkLink = null


func _ready() -> void:
	if link_left != null:
		link_left.activated.connect(load_left)
	if link_right != null:
		link_right.activated.connect(load_right)
	if link_up != null:
		link_up.activated.connect(load_up)
	if link_down != null:
		link_down.activated.connect(load_down)


func load_left() -> void:
	if chunk_left == null:
		return
	var c: LevelChunk = chunk_left.scene_instantiate()
	c.global_position = link_left.global_position - c.link_right.position
	get_parent().add_child(c)


func load_right() -> void:
	if chunk_right == null:
		return
	var c: LevelChunk = chunk_right.scene_instantiate()
	c.global_position = link_right.global_position - c.link_left.position
	get_parent().add_child(c)


func load_up() -> void:
	if chunk_up == null:
		return
	var c: LevelChunk = chunk_up.scene_instantiate()
	c.global_position = link_up.global_position - c.link_down.position
	get_parent().add_child(c)


func load_down() -> void:
	if chunk_down == null:
		return
	var c: LevelChunk = chunk_down.scene_instantiate()
	c.global_position = link_down.global_position - c.link_up.position
	get_parent().add_child(c)


func _on_area_entered(area: Area2D) -> void:
	if area is CameraArea:
		var camera: Camera2D = area.get_parent()
		camera.limit_left = $CollisionShape2D.global_position.x - $CollisionShape2D.shape.size.x / 2
		camera.limit_right = $CollisionShape2D.global_position.x + $CollisionShape2D.shape.size.x / 2
		camera.limit_top = $CollisionShape2D.global_position.y - $CollisionShape2D.shape.size.y / 2
		camera.limit_bottom = $CollisionShape2D.global_position.y + $CollisionShape2D.shape.size.y / 2
