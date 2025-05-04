class_name SequentialStateWrapper extends State

var current_sub_state: State
var sequence_index: int = 0
var number_of_sub_states: int

func initialize() -> void:
	current_sub_state = get_child(sequence_index)
	number_of_sub_states = 0
	
	for state_node: State in find_children("*", "State", false):
		state_node.finished.connect(_transition_to_next_state)
		state_node.animation_player = animation_player
		state_node.animation_tree = animation_tree
		state_node.body = body
		number_of_sub_states += 1
		if state_node is SequentialStateWrapper or state_node is RandomizedStateWrapper or state_node is ChooseOneStateWrapper:
			state_node.initialize()

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	sequence_index = data.get("sequnce_index", sequence_index) % number_of_sub_states
	current_sub_state = get_child(sequence_index)
	current_sub_state.enter(previous_state_path, data)

func exit() -> void:
	sequence_index = 0
	if current_sub_state:
		print("combo")
		current_sub_state.exit()

func handle_input(event: InputEvent) -> void:
	current_sub_state.handle_input(event)

func update(delta) -> void:
	current_sub_state.update(delta)

func physics_update(delta) -> void:
	current_sub_state.physics_update(delta)

func _transition_to_next_state(next_state_path: String, data: Dictionary = {}) -> void:	
	current_sub_state.exit()
	
	if body is Enemy and not body.player_in_range:
		finished.emit("Chase")
		return
	
	if not next_state_path.is_empty():
		current_sub_state = null
		finished.emit(next_state_path, {"sequence_index": sequence_index})
		return

	if sequence_index + 1 == number_of_sub_states:
		current_sub_state = null
		finished.emit("Idle")
		return

	sequence_index = (sequence_index + 1) % number_of_sub_states
	current_sub_state = get_child(sequence_index)
	current_sub_state.enter("")
	
	Events.entity_state_changed.emit(owner, owner.skin)
