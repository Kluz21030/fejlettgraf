extends CanvasLayer

@export var first_level: PackedScene
@export var control_node: Control

func _on_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(control_node, "modulate", Color.BLACK, 1)
	await tween.finished
	get_tree().change_scene_to_packed(first_level)
