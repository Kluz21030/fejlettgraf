extends State

@export var impulse: int = 8
@export var health_component: ResourceComponent
@export var fall_damage: float
@export var fall_damage_theshold: float

@onready var buffer: Timer = get_child(0)

var enter_height: float

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	if data.get("falling"):
		animation_player.play(&"player_animations/Jump_Idle")
		return
	body.velocity.y += impulse
	animation_player.play(animation)
	buffer.start(0.05)
	enter_height = body.global_position.y

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		finished.emit("Attack")
	if event.is_action_pressed("right_click"):
		finished.emit("HeavyAttack")
	if event.is_action_pressed("dodge"):
		finished.emit("Dodge")

func update(_delta: float) -> void:
	if body.is_on_floor() and buffer.is_stopped():
		if not body.velocity.is_equal_approx(Vector3.ZERO):
			finished.emit("Run")
		else:
			var fall_distance: float = enter_height - body.global_position.y
			if fall_distance >= fall_damage_theshold:
				health_component.take_damage(fall_distance * fall_damage)
			if health_component.current_value != 0:
				animation_player.play(&"player_animations/Jump_Land", 0.2)

func physics_update(_delta: float) -> void:
	pass

func _on_animation_finished(anim_name: StringName):
	if anim_name == &"player_animations/Jump_Start":
		animation_player.play(&"player_animations/Jump_Idle", 0.1)
	if anim_name == &"player_animations/Jump_Land":
		finished.emit("Idle")
