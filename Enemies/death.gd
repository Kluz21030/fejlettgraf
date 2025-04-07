extends State

@export var death_animation_name: StringName

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	animation_player.play(death_animation_name)
