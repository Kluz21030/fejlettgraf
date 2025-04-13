extends State

var frame_counter: int = 0

@export var in_range_check_frequency: int = 20
@export var min_idle_time: float = .5
@export var max_idle_time: float = 2.0
@export var idle_timer: Timer

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	animation_player.play(animation, .3 if previous_state_path == "Attack" else -1)
	if body.player_in_range:
		idle_timer.timeout.connect(_on_idle_timeout)
		idle_timer.start(randf_range(min_idle_time, max_idle_time))

func exit() -> void:
	if idle_timer.timeout.is_connected(_on_idle_timeout):
		idle_timer.timeout.disconnect(_on_idle_timeout)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if not owner.player_in_range:
		finished.emit("Chase")

func physics_update(_delta: float) -> void:
	pass

func _on_idle_timeout() -> void:
	finished.emit("Attack")
