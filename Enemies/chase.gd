extends State

var navigation_agent: NavigationAgent3D
var navigation_update_counter: int = 0

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	navigation_agent = body.navigation_agent
	navigation_agent.set_target_position(body.player.global_position)
	animation_player.play("enemy_animations/Running_A")

func exit() -> void:
	body.move_direction = Vector3.ZERO

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if navigation_update_counter == 20:
		navigation_agent.set_target_position(body.player.global_position)
		navigation_update_counter = 0
		return
	navigation_update_counter += 1

func physics_update(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		finished.emit("Attack")
		return
	var next_point = navigation_agent.get_next_path_position() - body.global_position
	var direction = (next_point * Vector3(1, 0, 1)).normalized()
	
	body.move_direction = direction
