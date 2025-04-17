class_name KickArea extends Area3D

var targets: Dictionary[PhysicsBody3D, bool]

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: PhysicsBody3D) -> void:
	targets.set(body, false)

func _on_body_exited(body: PhysicsBody3D) -> void:
	targets.erase(body)
