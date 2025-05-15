class_name Level extends Node

@export var spawn_point: Node3D
@export var scene_file: PackedScene

var tween: Tween

func _ready():
	Events.transition_to_next_level.connect(transition)
	Events.death_popup_finished.connect(reset)
	Events.start_transition_fade.emit()
	if spawn_point:
		var player: Player = get_tree().get_first_node_in_group(&"Player")
		player.reparent(self)
		player.global_position = spawn_point.position
		player.set_process(true)

func transition(next_level: PackedScene):
	Events.start_transition_fade.emit(true)
	await Events.transition_fade_finished
	var player: Player = get_tree().get_first_node_in_group(&"Player")
	player.set_process(false)
	player.reparent(get_tree().root)
	get_tree().change_scene_to_packed(next_level)

func reset() -> void:
	Events.start_transition_fade.emit(true)
	await Events.transition_fade_finished
	Events.reset.emit()
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		enemy.reset()
	var player: Player = get_tree().get_first_node_in_group(&"Player")
	player.reset()
	Events.start_transition_fade.emit()
