class_name StateMachine extends Node

@export var initial_state: State = null
@export var animation_player: AnimationPlayer
@export var animation_tree: AnimationTree
@export var body: CharacterBody3D

@onready var current_state: State = (func get_initial_state() -> State: 
	return initial_state if initial_state else get_child(0)
).call()


func _ready() -> void:
	for state_node: State in find_children("*", "State", false):
		state_node.finished.connect(_transition_to_next_state)
		state_node.animation_player = animation_player
		state_node.animation_tree = animation_tree
		state_node.body = body
		if state_node is SequentialStateWrapper:
			state_node.initialize()
	
	await owner.ready
	initial_state.enter("")
	
	Events.entity_state_changed.emit(owner, owner.skin)

func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)

func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := current_state.name
	current_state.exit()
	current_state = get_node(target_state_path)
	current_state.enter(previous_state_path, data)
	print("entered state: " + target_state_path)
	
	Events.entity_state_changed.emit(owner, owner.skin)
