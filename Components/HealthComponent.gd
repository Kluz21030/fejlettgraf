class_name HealthComponent extends Node

signal died
@export var timer: Timer
@export var MAX_HEALTH: int
var health: int:
	set(value):
		health = clampi(value, 0, MAX_HEALTH)
		print(health)
		if health == 0:
			owner.queue_free()
			died.emit()

func _ready() -> void:
	health = MAX_HEALTH

func take_damage(damage: int):
	health -= damage
	var kecske: MeshInstance3D = owner
	kecske.mesh.material.albedo_color = Color.RED
	timer.start(0.5)
	await timer.timeout
	kecske.mesh.material.albedo_color = Color.WHITE
