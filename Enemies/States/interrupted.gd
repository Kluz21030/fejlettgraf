extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(animation)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation:
		finished.emit("Idle")
