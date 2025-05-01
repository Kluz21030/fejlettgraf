extends State

@export var impulse: int = 15
@export var stomp_area: StompAreaComponent
var enter_loc: Vector3
var actual_impulse: float = impulse
var impulse_modifier: float = 1.0

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	stomp_area.area_entered.connect(_on_area_entered)
	animation_player.play(animation)
	enter_loc = body.global_position * Vector3(1, 0, 1)
	calculate_impulse_modifier()

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)
	stomp_area.area_entered.disconnect(_on_area_entered)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	actual_impulse = impulse * impulse_modifier
	body.velocity = body.skin.get_quaternion() * animation_player.get_root_motion_position() * Vector3(1, .25, 1) * actual_impulse / delta

func calculate_impulse_modifier():
	impulse_modifier = body.global_position.distance_to(body.player.global_position) / 23

func _on_area_entered(area: Area3D) -> void:
	if area is HurtboxComponet:
		var attack: Attack = Attack.new()
		attack.damage = stomp_area.damage
		attack.interrupt = true
		area.damage(attack)

func _on_animation_finished(anim_name) -> void:
	if anim_name == animation:
		print(body.player_in_range)
		if body.player_in_range:
			finished.emit("Idle")
		else:
			finished.emit("Chase")
