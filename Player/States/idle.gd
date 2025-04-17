extends State

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.play("player_animations/2H_Melee_Idle")

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
	if not body.velocity.is_equal_approx(Vector3.ZERO) and body.is_on_floor():
		finished.emit("Run")

func physics_update(_delta: float) -> void:
	pass
