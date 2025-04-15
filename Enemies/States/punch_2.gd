extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	animation_player.play(animation, 0.1)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_attack_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation:
		finished.emit("Idle")
