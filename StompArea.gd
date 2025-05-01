class_name StompAreaComponent extends Area3D

@export var damage: int
@export var particle_emitter: GPUParticles3D

func emit_particles() -> void:
	particle_emitter.emitting = true
