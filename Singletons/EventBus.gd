class_name EventBus extends Node

signal entity_state_changed(owner: Node, skin: Node3D)
signal player_attacked
signal player_resource_changed(resource: StringName, current_value: int, max_value: int)
signal boss_spawmed
signal boss_health_changed(current_health: int, max_health: int)
