extends State

@export var stomp_area: StompAreaComponent

func enter(previous_state_path:String, data: Dictionary = {}) -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	stomp_area.area_entered.connect(_on_area_entered)
	animation_player.play(animation)

func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)
	stomp_area.area_entered.disconnect(_on_area_entered)

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func _on_area_entered(area: Area3D) -> void:
	if area is HurtboxComponet:
		var attack: Attack = Attack.new()
		attack.damage = stomp_area.damage
		attack.interrupt = true
		area.damage(attack)

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == animation:
		finished.emit("")
