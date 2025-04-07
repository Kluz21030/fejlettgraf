class_name Player extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity: float = 0.5

@export_group("Movement")
@export var movement_speed: int = 10
@export var acceleration: int = 50
@export var stopping_speed: int = 5
@export var rotate_speed: int = 12
@export var jump_impulse: int = 6

@onready var _camera: Camera3D = %Camera3D
@onready var _camera_pivot: Node3D = %CameraPivot
@onready var state_machine: StateMachine = %StateMachine
@onready var skin: Node3D = %Knight

var _camera_input_direction: Vector2 = Vector2.ZERO
var _last_movement_direction: Vector3 = Vector3.BACK
var _input_direction: Vector2
var _move_direction: Vector3
var _gravity: float = -18

func _input(event: InputEvent) -> void:
	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED and event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("jump"):
		pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera_input_direction = event.screen_relative * mouse_sensitivity
	
func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x + _camera_input_direction.y * delta, -PI / 2.05, PI / 2.05)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO
	
	_input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_back") if state_machine.current_state.can_move else Vector2.ZERO
	
	_move_direction = _camera.global_basis.z * _input_direction.y + _camera.global_basis.x * _input_direction.x
	_move_direction.y = 0.0
	_move_direction = _move_direction.normalized()
	
	var y_velocity = velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(_move_direction * movement_speed, acceleration * delta)
	velocity.y = y_velocity + _gravity * delta
	
	#if is_equal_approx(_move_direction.length(), 0.0) and velocity.length() < stopping_speed:
		#velocity = Vector3.ZERO
	
	if _move_direction != Vector3.ZERO:
		_last_movement_direction = _move_direction
	var target_rotation: float = Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	skin.rotation.y = lerp_angle(skin.rotation.y, target_rotation, rotate_speed * delta)
	
	move_and_slide()
