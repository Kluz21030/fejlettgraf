class_name Weapon extends Area3D

@export var weapon_name: StringName
@export var base_damage: int
@export var two_handed: bool

var already_hit: Array[HurtboxComponet]

func _ready() -> void:
	if not weapon_name:
		weapon_name = name
	area_entered.connect(_on_hit)
	
	Events.entity_state_changed.connect(_on_state_changed)

func _on_hit(area: Area3D) -> void:
	if area is HurtboxComponet and area not in already_hit:
		var attack: Attack = Attack.new()
		attack.damage = base_damage
		area.damage(attack)
		already_hit.append(area)

func reset_hit_list() -> void:
	already_hit = []

func _on_state_changed(state_owner: Node, skin: Node3D) -> void:
	if state_owner == owner or skin == owner:
		reset_hit_list()
