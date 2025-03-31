extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.play("player_animations/Running_A")
	#animation_tree.active = true

func exit() -> void:
	#animation_tree.active = false
	pass

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		finished.emit("Attack")

func update(_delta: float) -> void:
	if body.velocity.is_equal_approx(Vector3.ZERO):
		finished.emit("Idle")

func physics_update(_delta: float) -> void:
	pass
