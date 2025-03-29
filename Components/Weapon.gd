class_name Weapon extends Area3D

@export var weapon_name: StringName
@export var base_damage: int
@export var two_handed: bool

func _ready() -> void:
	if not weapon_name:
		weapon_name = name
	area_entered.connect(_on_hit)

func _on_hit(area: Area3D) -> void:
	if area is HurtboxComponet:
		var attack: Attack = Attack.new()
		attack.damage = base_damage
		area.damage(attack)
