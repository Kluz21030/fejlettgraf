extends State

@onready var detection_area: Area3D = %Detection_Area

func enter(previous_state_path: String, data: Dictionary = {}) -> void:
	detection_area.body_entered.connect(_on_enemy_player_detected)
	animation_player.play("enemy_animations/Skeletons_Inactive_Floor_Pose")

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
		animation_player.play("enemy_animations/Skeletons_Awaken_Floor")
		await animation_player.animation_finished
		finished.emit("Chase")
