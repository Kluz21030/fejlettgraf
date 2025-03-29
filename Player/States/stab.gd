extends State


func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	animation_player.play("2H_Melee_Attack_Stab", 0.1)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_attack_animation_finished(anim_name: StringName):
	if anim_name == &"2H_Melee_Attack_Stab":
		finished.emit("Idle")
