extends State

@export var stamina_cost: int
@export var stamina_component: ResourceComponent
@export var damage_modifier: float = 1.0
@export var weapons: Array[Weapon]

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_attack_animation_finished)
	animation_player.can_attack.connect(_on_can_transition)
	
	if stamina_cost > stamina_component.current_value:
		finished.emit("Idle")
		return
	stamina_component.take_damage(stamina_cost)
	
	for weapon in weapons:
		weapon.update_damage(damage_modifier)
	
	animation_player.play(animation, 0.1)
	Events.player_attacked.emit()

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_attack_animation_finished)
	animation_player.can_attack.disconnect(_on_can_transition)
	
	for weapon in weapons:
		weapon.update_damage()

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_attack_animation_finished(anim_name: StringName):
	#if anim_name == &"player_animations/2H_Melee_Attack_Stab":
		#finished.emit("Idle")
		pass

func _on_can_transition():
	finished.emit("Idle")
