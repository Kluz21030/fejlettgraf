class_name State extends Node

@export var can_move: bool
@export var root_motion_movement: bool = false
@export var interruptable: bool = true
@export var animation: StringName
@export var transition_mapping: Dictionary[StringName, float]

var body: CharacterBody3D
var animation_player: CharacterAnimationPlayer
var animation_tree: AnimationTree

signal finished(next_state_path: String, data: Dictionary)

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func interrupt(interrupt_state_name: String = "") -> void:
	finished.emit(interrupt_state_name if not interrupt_state_name.is_empty() else "Interrupted")
