class_name SecretWall extends Area3D

@export var mesh: MeshInstance3D
@export var wall_root: Node3D

var tween: Tween

func destroy() -> void:
	tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(mesh, "transparency", 1.0, 0.5)
	tween.tween_callback(wall_root.queue_free)
