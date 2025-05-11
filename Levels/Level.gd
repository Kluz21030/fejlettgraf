class_name Level extends Node

@export var spawn_point: Node3D

func _ready():
	Events.transition_to_next_level.connect(transition)
	var tween: Tween = create_tween()
	tween.tween_property(Transition, "modulate:a", 0.0, 0.5)
	if spawn_point:
		var player: Player = get_tree().get_first_node_in_group(&"Player")
		player.reparent(self)
		player.global_position = spawn_point.position
		player.set_process(true)

func transition(next_level: PackedScene):
	var player: Player = get_tree().get_first_node_in_group(&"Player")
	player.set_process(false)
	player.reparent(get_tree().root)
	var tween: Tween = create_tween()
	tween.tween_property(Transition, "modulate:a", 1.0, 0.5)
	await tween.finished
	get_tree().change_scene_to_packed(next_level)
	
	
