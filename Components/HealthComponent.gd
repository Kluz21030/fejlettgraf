class_name HealthComponent extends Node

signal died(owner: CharacterBody3D)
@export var MAX_HEALTH: int

var health: int:
	set(value):
		health = clampi(value, 0, MAX_HEALTH)
		print(health)
		if health == 0:
			died.emit(owner)

func _ready() -> void:
	health = MAX_HEALTH

func take_damage(damage: int):
	health -= damage
