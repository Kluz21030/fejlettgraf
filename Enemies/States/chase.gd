extends State

var navigation_agent: NavigationAgent3D
var navigation_update_counter: int = 0

@export var attack_range: Area3D

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	attack_range.body_entered.connect(_on_player_in_range)
	navigation_agent = body.navigation_agent
	navigation_agent.set_target_position(body.player.global_position)
	animation_player.play("enemy_animations/Running_A")

func exit() -> void:
	body.move_direction = Vector3.ZERO
	attack_range.body_entered.disconnect(_on_player_in_range)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if navigation_update_counter == 20:
		navigation_agent.set_target_position(body.player.global_position)
		navigation_update_counter = 0
		return
	navigation_update_counter += 1

func physics_update(_delta: float) -> void:
	var next_point = navigation_agent.get_next_path_position() - body.global_position
	var direction = (next_point * Vector3(1, 0, 1)).normalized()
	
	body.move_direction = direction

func _on_player_in_range(body: Node3D) -> void:
	if body is Player:
		owner.player_in_range = true
		if randf_range(0.0, 1.0) <= 0.5:
			finished.emit("Attack")
			return
		finished.emit("Idle")
