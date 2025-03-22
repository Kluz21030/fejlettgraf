class_name Player extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity: float = 0.5

@export_group("Movement")
@export var movement_speed: int = 40
@export var acceleration: int = 160

@onready var _camera: Camera3D = %Camera3D
@onready var _camera_pivot: Node3D = %CameraPivot

var _camera_input_direction: Vector2 = Vector2.ZERO
var _input_direction: Vector2
var _move_direction: Vector3

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_camera_input_direction = event.screen_relative * mouse_sensitivity
	
func _physics_process(delta: float) -> void:
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x + _camera_input_direction.y * delta, -PI / 2, PI / 2)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO
	
	_input_direction = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	_move_direction = _camera.global_basis.z * _input_direction.y + _camera.global_basis.x * _input_direction.x
	_move_direction.y = 0.0
	_move_direction.normalized()
	
	velocity = velocity.move_toward(_move_direction * movement_speed, acceleration * delta)
	
	move_and_slide()
	
