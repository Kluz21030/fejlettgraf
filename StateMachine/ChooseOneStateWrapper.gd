class_name ChooseOneStateWrapper extends State

var sub_state: State

func initialize() -> void:
	for state_node: State in find_children("*", "State", false):
		state_node.finished.connect(_transition_to_next_state)
		state_node.animation_player = animation_player
		state_node.animation_tree = animation_tree
		state_node.body = body
		if state_node is SequentialStateWrapper or state_node is RandomizedStateWrapper or state_node is ChooseOneStateWrapper:
			state_node.initialize()

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	sub_state = get_children().pick_random()
	sub_state.enter(previous_state_path, data)

func exit() -> void:
	if sub_state:
		sub_state.exit()

func handle_input(event: InputEvent) -> void:
	sub_state.handle_input(event)

func update(delta) -> void:
	sub_state.update(delta)

func physics_update(delta) -> void:
	sub_state.physics_update(delta)

func _transition_to_next_state(next_state_path: String, data: Dictionary = {}) -> void:
	sub_state.exit()
	
	sub_state = null
	
	finished.emit(next_state_path)
	
	Events.entity_state_changed.emit(owner, owner.skin)
