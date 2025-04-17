extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	finished.emit("Idle")
