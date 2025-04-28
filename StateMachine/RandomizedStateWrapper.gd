class_name RandomizedStateWrapper extends State

@export var initial_state: State
var current_sub_state: State
var sub_state_index: int = 0
var number_of_sub_states: int

func initialize() -> void:
	if initial_state:
		sub_state_index = initial_state.get_index()
		current_sub_state = initial_state
	else:
		sub_state_index = randi_range(0, get_child_count() - 1)
		get_child(sub_state_index)
	number_of_sub_states = get_child_count()
	
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
		state_node.animation_player = animation_player
		state_node.animation_tree = animation_tree
		state_node.body = body

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	current_sub_state = get_child(sub_state_index)
	sub_state_index = current_sub_state.get_index()
	current_sub_state.enter(previous_state_path, data)

func handle_input(event: InputEvent) -> void:
	current_sub_state.handle_input(event)

func update(delta) -> void:
	current_sub_state.update(delta)

func physics_update(delta) -> void:
	current_sub_state.physics_update(delta)

func _transition_to_next_state(next_state_path: String, data: Dictionary = {}) -> void:
	current_sub_state.exit()
	
	if not next_state_path.is_empty():
		finished.emit(next_state_path)
		return

	if data.get("mapping"):
		var sum: float = 0.0
		var roll: float = randf_range(0.0, 1.0)
		for key in data["mapping"]:
			sum += data["mapping"][key]
			if roll <= sum:
				current_sub_state = find_child(key)
				sub_state_index = current_sub_state.get_index()
				break
	else:
		var possible_indices: Array[int] = range(0, sub_state_index) + range(sub_state_index, number_of_sub_states)
		current_sub_state = get_child(possible_indices.pick_random())
		current_sub_state.enter("")
	
	Events.entity_state_changed.emit(owner, owner.skin)
