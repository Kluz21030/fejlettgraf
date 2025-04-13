extends State

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	body.set_process(false)
	body.set_physics_process(false)
	animation_player.play(animation)
