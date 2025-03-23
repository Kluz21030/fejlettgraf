extends State

@onready var combot_timer: Timer = get_child(0)

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	animation_player.play("2H_Melee_Attack_Slice", 0.15)
	combot_timer.start(animation_player.current_animation_length / 2.0)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)

func handle_input(event: InputEvent) -> void:
	#print(combot_timer.is_stopped())
	if combot_timer.is_stopped() and event.is_action_pressed("left_click"):
		finished.emit("")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_attack_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"2H_Melee_Attack_Slice":
		finished.emit("Idle")
