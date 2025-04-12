extends State

@export var death_animation_name: StringName

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	body.set_process(false)
	body.set_physics_process(false)
	animation_player.play(death_animation_name)
