class_name EnemyHealthBar extends Node3D

@export var resource_name: StringName
@export var progress_bar: ProgressBar

var camera: Camera3D

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("PlayerCamera")
	
func _process(delta: float) -> void:
	look_at(camera.global_position, Vector3(0, 1, 0), true)

func _on_resource_changed(current_value: int, max_value: int):
	progress_bar.max_value = max_value
	print("%s health changed" % owner.name)
	progress_bar.value = current_value

func _on_death(owner: CharacterBody3D) -> void:
	queue_free()
