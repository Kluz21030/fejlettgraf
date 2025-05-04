extends State

@export var impulse: int = 15
@export var kick_area: KickArea
@export var kick_delay: Timer
@export var stamina_cost: int
@export var stamina_component: ResourceComponent
@export var gap_close_state: State
@export_range(0.0, 1.0, 0.01) var gap_close_chance: float

var character_hit: bool = false

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	if stamina_component:
		if stamina_cost > stamina_component.current_value:
			finished.emit(previous_state_path)
			return
		stamina_component.take_damage(stamina_cost)
	
	character_hit = false
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
			character_hit = true
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
		if character_hit and randf_range(0.0, 1.0) <= gap_close_chance:
			finished.emit(gap_close_state.name)
		else:
			finished.emit("Idle")
