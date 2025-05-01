extends State

var navigation_agent: NavigationAgent3D
var navigation_update_counter: int = 0
var gap_close_counter: int 

@export var attack_range: Area3D
@export var gap_close_roll_frequency: int = 120
@export var gap_closers: Array[State]
@export_range(0.0, 1.0, 0.01) var gap_close_chance: float

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	attack_range.body_entered.connect(_on_player_in_range)
	navigation_agent = body.navigation_agent
	navigation_agent.set_target_position(body.player.global_position)
	animation_player.play(animation)

func exit() -> void:
	body.move_direction = Vector3.ZERO
	attack_range.body_entered.disconnect(_on_player_in_range)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if navigation_update_counter == 20:
		navigation_agent.set_target_position(body.player.global_position)
		navigation_update_counter = 0
	else:
		navigation_update_counter += 1
	if gap_close_counter == gap_close_roll_frequency:
		roll_to_gap_close()
		gap_close_counter = 0
	else:
		gap_close_counter += 1

func physics_update(_delta: float) -> void:
	var next_point = navigation_agent.get_next_path_position() - body.global_position
	var direction = (next_point * Vector3(1, 0, 1)).normalized()
	
	body.move_direction = direction

func roll_to_gap_close() -> void:
	if gap_closers and randf_range(0.0, 1.0) <= gap_close_chance:
		finished.emit(gap_closers[randi_range(0, len(gap_closers) - 1)].name)

func _on_player_in_range(body: Node3D) -> void:
	if body is Player:
		if randf_range(0.0, 1.0) <= 0.5:
			finished.emit("Attack")
			return
		finished.emit("Idle")
