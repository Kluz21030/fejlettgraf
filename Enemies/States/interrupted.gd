extends State

@export var health_component: ResourceComponent

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(animation, 0.5)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation and health_component.current_value != 0:
		finished.emit("Idle")

func _on_health_component_died(owner):
	finished.emit("Death")
