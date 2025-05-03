class_name ResourceComponent extends Node

signal died(owner: CharacterBody3D)
@export var resource_name: StringName
@export var max_value: int:
	set(value):
		max_value = value
		if owner is Player:
			Events.player_resource_changed.emit(resource_name, health, max_value)

var health: int:
	set(value):
		health = clampi(value, 0, max_value)
		print(health)
		if health == 0:
			died.emit(owner)
		if owner is Player:
			Events.player_resource_changed.emit(resource_name, health, max_value)

func _ready() -> void:
	health = max_value

func take_damage(damage: int):
	health -= damage
