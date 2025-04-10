extends State

@export var frame_counter: int = 0
@export var in_range_check_frequency: int = 20

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	animation_player.play("enemy_animations/Idle_Combat")

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if not owner.player_in_range:
		finished.emit("Chase")

func physics_update(_delta: float) -> void:
	pass
