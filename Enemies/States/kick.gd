extends State

@export var impulse: int = 15
@export var kick_area: KickArea
@export var kick_delay: Timer

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(animation, 0.4)
	
	kick_delay.start()
	await kick_delay.timeout
	
	var kick_direction: Vector3 = body.skin.global_basis.z
	
	for target in kick_area.targets:
		var character: CharacterBody3D = target as CharacterBody3D
		var object: RigidBody3D = target as RigidBody3D
		if character and character.state_machine.current_state.interruptable:
			character.state_machine.current_state.interrupt()
			character.velocity += impulse * kick_direction
		if object:
			object.apply_impulse(impulse * kick_direction)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation:
		finished.emit("Idle")
