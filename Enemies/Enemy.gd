class_name Enemy extends CharacterBody3D

var _gravity: float = -18
var _last_movement_direction: Vector3
var _initial_position: Vector3

var player: Player
var player_in_range: bool
var move_direction: Vector3

@export var acceleration: int = 20
@export var movement_speed: int = 5
@export var rotate_speed: int = 12
@export var skin: Node3D
@export var animation_player: CharacterAnimationPlayer

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	_initial_position = global_position

func _physics_process(delta: float) -> void:
	if not state_machine.current_state.can_move:
		move_direction = Vector3.ZERO
	if not state_machine.current_state.root_motion_movement:
		var y_velocity = velocity.y
		velocity.y = 0.0
		velocity = velocity.move_toward(move_direction * movement_speed, acceleration * delta)
		velocity.y = y_velocity + _gravity * delta * int(not is_on_floor())
	
	if move_direction != Vector3.ZERO:
		_last_movement_direction = move_direction
	if velocity.is_zero_approx() and player:
		_last_movement_direction = ((player.global_position - global_position) * Vector3(1, 0, 1)).normalized()
	if state_machine.current_state.can_move:
		var target_rotation: float = Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
		skin.rotation.y = lerp_angle(skin.rotation.y, target_rotation, rotate_speed * delta)
	
	move_and_slide()

func _on_died(_body: CharacterBody3D):
	state_machine.current_state.finished.emit("Death")
	$HurtboxComponet.set_deferred("monitorable", false)
	set_collision_layer_value(3, false)
	set_collision_mask_value(2, false)

func _on_player_moved_away(body: Node3D) -> void:
	if body is Player:
		player_in_range = false

func _on_player_in_range(body: Node3D) -> void:
	if body is Player:
		player_in_range = true

func reset() -> void:
	if state_machine.current_state.name != "Death":
		state_machine.current_state.finished.emit("Inactive")
		global_position = _initial_position
		player = null
		
		for resource in find_children("*", "ResourceComponent"):
			resource.reset()
