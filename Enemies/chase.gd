extends State

var navigation_agent: NavigationAgent3D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	navigation_agent = body.navigation_agent
	navigation_agent.set_target_position(body.player.global_position)
	animation_player.play("enemy_animations/Running_A")

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var next_point = navigation_agent.get_next_path_position() - body.global_position
	var direction = next_point.normalized()
	
	body.velocity = direction * body.movement_speed
	body.move_and_slide()
