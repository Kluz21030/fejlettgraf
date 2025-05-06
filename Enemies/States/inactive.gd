extends State

@onready var detection_area: Area3D = %Detection_Area
@export var awaken_animation: StringName

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	detection_area.body_entered.connect(_on_enemy_player_detected)
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(animation)

func exit() -> void:
	detection_area.body_entered.disconnect(_on_enemy_player_detected)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_enemy_player_detected(body: Node3D) -> void:
	if body is Player:
		owner.player = body
		if self.body is Boss:
			Events.boss_engaged.emit()
		if awaken_animation:
			animation_player.play(awaken_animation)

func _on_animation_finished(anim_name: StringName) -> void:
		if awaken_animation == anim_name:
			if self.body.player_in_range:
				finished.emit("Idle")
			else:
				finished.emit("Chase")
