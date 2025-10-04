extends Area2D
class_name LevelChunk

@export var chunk_resource: ChunkResource

@export_category("Camera")
@export var lock_camera: bool = true


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

	if not chunk_resource.left:
		link_left.queue_free()
	if not chunk_resource.right:
		link_right.queue_free()
	if not chunk_resource.up:
		link_up.queue_free()
	if not chunk_resource.down:
		link_down.queue_free()


func load_left() -> void:
	if not is_inside_tree:
		return

	if chunk_resource.scene_left:
		get_parent().add_child(chunk_resource.scene_left)

	elif chunk_resource.left:
		var c: LevelChunk = chunk_resource.left.scene_instantiate()
		c.global_position = link_left.global_position - c.link_right.position
		get_parent().add_child(c)

	get_parent().remove_child(self)


func load_right() -> void:
	if not is_inside_tree:
		return

	if chunk_resource.scene_right:
		get_parent().add_child(chunk_resource.scene_right)

	elif chunk_resource.right:
		var c: LevelChunk = chunk_resource.right.scene_instantiate()
		c.global_position = link_right.global_position - c.link_left.position
		get_parent().add_child(c)

	get_parent().remove_child(self)


func load_up() -> void:
	if not is_inside_tree:
		return

	if chunk_resource.scene_up:
		get_parent().add_child(chunk_resource.scene_up)

	elif chunk_resource.up:
		var c: LevelChunk = chunk_resource.up.scene_instantiate()
		c.global_position = link_up.global_position - c.link_down.position
		get_parent().add_child(c)

	get_parent().remove_child(self)


func load_down() -> void:
	if not is_inside_tree:
		return

	if chunk_resource.scene_down:
		get_parent().add_child(chunk_resource.scene_down)

	elif chunk_resource.down:
		var c: LevelChunk = chunk_resource.down.scene_instantiate()
		c.global_position = link_down.global_position - c.link_up.position
		get_parent().add_child(c)

	get_parent().remove_child(self)


var tween : Tween
func _on_area_entered(area: Area2D) -> void:
	if area is CameraArea:
		var camera: Camera2D = area.get_parent()

		if tween:
			tween.kill()
		tween = get_tree().create_tween()
		tween.set_parallel()
		tween.tween_property(camera, "limit_left", $CollisionShape2D.global_position.x - $CollisionShape2D.shape.size.x / 2, 0.5)
		tween.tween_property(camera, "limit_right", $CollisionShape2D.global_position.x + $CollisionShape2D.shape.size.x / 2, 0.5)
		tween.tween_property(camera, "limit_top", $CollisionShape2D.global_position.y - $CollisionShape2D.shape.size.y / 2, 0.5)
		tween.tween_property(camera, "limit_bottom", $CollisionShape2D.global_position.y + $CollisionShape2D.shape.size.y / 2, 0.5)
