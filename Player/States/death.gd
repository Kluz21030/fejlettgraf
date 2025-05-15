extends State


func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.play(animation)
