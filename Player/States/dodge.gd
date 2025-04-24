extends State

@export var hurtbox: HurtboxComponet
@export var impulse: int = 15

var input_direction: Vector3 = Vector3.FORWARD:
	set(value):
		if value != Vector3.ZERO:
			input_direction = value

const animation_mapping : Dictionary[Vector3, StringName] = {
	Vector3.BACK: &"player_animations/Dodge_Forward",
	Vector3.FORWARD: &"player_animations/Dodge_Backward",
}

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	
	input_direction = Vector3.BACK if body._input_direction != Vector2.ZERO else Vector3.FORWARD
	
	animation_player.play(animation_mapping[input_direction])
	
	var direction: Vector3 = body.skin.global_basis.z * input_direction.z + body.skin.global_basis.x * input_direction.x
	direction = direction.normalized()
	
	#body.velocity += impulse * direction
	
	hurtbox.monitorable = false

func exit() -> void:
	hurtbox.monitorable = true
	input_direction = Vector3.FORWARD
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	body.velocity = body.skin.get_quaternion() * animation_player.get_root_motion_position() / delta * 20

func _on_attack_animation_finished(anim_name) -> void:
	if anim_name == animation_mapping[input_direction]:
		finished.emit("Idle")
