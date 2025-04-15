extends State

@export var hurtbox: HurtboxComponet
@export var impulse: int = 15

var dodge_direction: Vector3 = Vector3.FORWARD:
	set(value):
		if value != Vector3.ZERO:
			dodge_direction = value

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	animation_player.play(animation)
	
	var direction: Vector3 = body.skin.global_basis.z * dodge_direction.z + body.skin.global_basis.x * dodge_direction.x
	direction = direction.normalized()
	
	body.velocity += impulse * direction
	
	hurtbox.set_deferred('monitorable', false)

func exit() -> void:
	hurtbox.monitorable = true
	dodge_direction = Vector3.FORWARD
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_attack_animation_finished(anim_name) -> void:
	if anim_name == animation:
		finished.emit("Idle")
