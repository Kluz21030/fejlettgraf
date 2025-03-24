class_name HealthComponent extends Node

signal died

@export var MAX_HEALTH: int
var health: int:
	set(value):
		health = clampi(value, 0, MAX_HEALTH)
		if health == 0:
			died.emit()

func _ready() -> void:
	health = MAX_HEALTH

func take_damage(damage: int):
	health -= damage
