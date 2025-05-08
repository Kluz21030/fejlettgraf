class_name ResourceComponent extends Node

signal resource_changed(current_value: int, max_value: int)
signal died(owner: CharacterBody3D)

@export var regenerate: bool = false
@export var regen_rate: int
@export var regen_timer: Timer
@export var resource_name: StringName
@export var max_value: float:
	set(value):
		if value < max_value and value < current_value:
			current_value = value
		max_value = value
		if owner is Player:
			Events.player_resource_changed.emit(resource_name, current_value, max_value)

var current_value: float:
	set(value):
		current_value = clampf(value, 0, max_value)
		if resource_name == &"Health" and current_value == 0:
			died.emit(owner)
		if owner is Player:
			Events.player_resource_changed.emit(resource_name, current_value, max_value)
		if owner is Boss:
			Events.boss_health_changed.emit(current_value, max_value)
		elif owner is Enemy:
			resource_changed.emit(current_value, max_value)

func _ready() -> void:
	current_value = max_value

func _process(delta: float) -> void:
	if regenerate and regen_timer.is_stopped() and current_value != max_value:
		current_value += regen_rate * delta

func take_damage(damage: int):
	current_value -= damage
	if regenerate:
		regen_timer.start()

func change_max_value(max_value: int, heal: bool = true) -> void:
	self.max_value += max_value
	if heal:
		current_value = self.max_value
