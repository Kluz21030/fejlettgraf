extends State

@export var impulse: int = 15
var enter_loc: Vector3
var actual_impulse: float = impulse
var impulse_modifier: float = 1.0

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(animation)
	enter_loc = body.global_position * Vector3(1, 0, 1)
	calculate_impulse_modifier()

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	actual_impulse = impulse * impulse_modifier
	body.velocity = body.skin.get_quaternion() * animation_player.get_root_motion_position() * Vector3(1, .25, 1) * actual_impulse / delta

func calculate_impulse_modifier():
	impulse_modifier = body.global_position.distance_to(body.player.global_position) / 23

func _on_animation_finished(anim_name) -> void:
	if anim_name == animation:
		finished.emit("Chase")
