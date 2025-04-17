extends State

@export var timer: Timer
@export_range(0.0, 1.0, 0.1) var attack_again_chance: float = 0.5

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	print("entered from state:%s" % previous_state_path)
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	animation_player.play(animation, 0.1)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func roll_to_attack() -> void:
	if randf_range(0.001, 1.0) <= attack_again_chance:
		var max_wait: float = animation_player.current_animation_length - animation_player.current_animation_position
		var wait_time: float = randf_range(0.0, max_wait)
		timer.start(wait_time)
		if wait_time >= 0.05:
			await timer
		finished.emit("")

func _on_attack_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation:
		finished.emit("Idle")
