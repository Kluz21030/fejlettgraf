extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	var transition_time: float = 0.2
	if previous_state_path == "Jump":
		transition_time = 0.15
	animation_player.play("player_animations/Running_A", transition_time)
	#animation_tree.active = true

func exit() -> void:
	#animation_tree.active = false
	pass

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		finished.emit("Attack")
	if event.is_action_pressed("dodge"):
		finished.emit("Dodge")
	if event.is_action_pressed("jump"):
		finished.emit("Jump")

func update(_delta: float) -> void:
	if body.velocity.is_equal_approx(Vector3.ZERO):
		finished.emit("Idle")

func physics_update(_delta: float) -> void:
	pass
