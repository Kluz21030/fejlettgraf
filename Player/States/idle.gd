extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.play(animation)

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		finished.emit("Attack")
	if event.is_action_pressed("dodge"):
		finished.emit("Dodge")
	if event.is_action_pressed("jump"):
		finished.emit("Jump")
	if event.is_action_pressed("kick"):
		finished.emit("Kick")

func update(_delta: float) -> void:
	if not body.is_on_floor():
		finished.emit("Jump", {"falling": true})
	elif not body.velocity.is_equal_approx(Vector3.ZERO):
		finished.emit("Run")

func physics_update(_delta: float) -> void:
	pass
