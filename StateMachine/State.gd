class_name State extends Node

@export var can_move: bool
@export var interruptable: bool = true
@export var animation: StringName

var body: CharacterBody3D
var animation_player: AnimationPlayer
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
