extends State

@onready var combot_timer: Timer = get_child(0)
@export var stamina_cost: int
@export var stamina_component: ResourceComponent
@export var damage_modifier: float
@export var weapons: Array[Weapon]

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	if stamina_cost > stamina_component.current_value:
		finished.emit(previous_state_path if previous_state_path != "Jump" else "Idle")
		return
	stamina_component.take_damage(stamina_cost)
	
	for weapon in weapons:
		weapon.update_damage(damage_modifier)
	
	combot_timer.start()
	animation_player.play(animation, 0.15)
	Events.player_attacked.emit()

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)
	
	for weapon in weapons:
		weapon.update_damage()

func handle_input(event: InputEvent) -> void:
	if combot_timer.is_stopped():
		if event.is_action_pressed("right_click"):
			finished.emit("")
		if event.is_action_pressed("left_click"):
			finished.emit("Attack")

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_attack_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation:
		finished.emit("Idle")
