extends State

var frame_counter: int = 0

@export var in_range_check_frequency: int = 20
@export var min_idle_time: float = .5
@export var max_idle_time: float = 2.0
@export var idle_timer: Timer
@export var kick_state: State
@export_range(0.0, 1.0, 0.1) var kick_chance: float
@export var dodge_state: State
@export_range(0.0, 1.0, 0.1) var dodge_chance: float
@export_range(0.0, 1.0, 0.1) var intervene_modifier: float

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	animation_player.play(animation, .3 if previous_state_path == "Attack" else -1)
	if previous_state_path == &"Dodge":
		idle_timer.start(1)
		await idle_timer.timeout
	if dodge_state:
		Events.player_attacked.connect(roll_to_dodge)
	if body.player_in_range:
		if kick_state and roll_to_kick():
			return
		if dodge_state and roll_to_dodge(false):
			return
		idle_timer.timeout.connect(_on_idle_timeout)
		idle_timer.start(randf_range(min_idle_time, max_idle_time))

func exit() -> void:
	if idle_timer.timeout.is_connected(_on_idle_timeout):
		idle_timer.stop()
		idle_timer.timeout.disconnect(_on_idle_timeout)
	if dodge_state:
		Events.player_attacked.disconnect(roll_to_dodge)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	if idle_timer.is_stopped() and not owner.player_in_range:
		finished.emit("Chase")

func physics_update(_delta: float) -> void:
	pass

func roll_to_kick() -> bool:
	if randf_range(0.0, 1.0) <= kick_chance:
		finished.emit("Kick")
		return true
	return false

func roll_to_dodge(being_attacked: bool = true) -> bool:
	if randf_range(0.0, 1.0) <= dodge_chance + int(being_attacked) * intervene_modifier:
		finished.emit("Dodge")
		return true
	return false

func _on_idle_timeout() -> void:
	finished.emit("Attack")
