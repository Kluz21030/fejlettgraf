extends CanvasLayer

@export var first_level: PackedScene

func _on_button_pressed():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_packed(first_level)
