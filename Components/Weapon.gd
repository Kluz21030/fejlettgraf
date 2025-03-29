class_name Weapon extends StaticBody3D

@export var weapon_name: StringName
@export var hitbox: CollisionShape3D

func _ready() -> void:
	if not weapon_name:
		weapon_name = name
	if not hitbox:
		hitbox = find_children("*", "CollisionShape3D")[0]
