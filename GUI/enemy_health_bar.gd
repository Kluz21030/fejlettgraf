class_name EnemyHealthBar extends Node3D

@export var resource_name: StringName
@export var progress_bar: ProgressBar
@export var timer: Timer

var camera: Camera3D
var tween: Tween

func _ready() -> void:
	camera = get_tree().get_first_node_in_group("PlayerCamera")
	
func _process(delta: float) -> void:
	look_at(camera.global_position, Vector3(0, 1, 0), true)

func _on_resource_changed(current_value: int, max_value: int):
	progress_bar.max_value = max_value
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT)
	if not is_equal_approx(progress_bar.self_modulate.a, 1.0):
		tween.tween_property(progress_bar, "self_modulate:a", 1.0, 0.25)
	tween.tween_property(progress_bar, "value", current_value, 0.3)
	timer.start()
	await timer.timeout
	tween = create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(progress_bar, "self_modulate:a", 0.0, 0.25)

func _on_death(owner: CharacterBody3D) -> void:
	await tween.finished
	queue_free()
