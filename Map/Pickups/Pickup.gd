class_name Pickup extends Area3D

@export var type: StringName
@export var value: int

var tween: Tween

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y + 0.25, 1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:y", position.y - 0.25, 1).set_trans(Tween.TRANS_CUBIC)

func _on_area_entered(area: HurtboxComponet) -> void:
	set_deferred("monitoring", false)
	if type == &"Health":
		area.health_component.change_max_value(value)
	if type == &"Stamina":
		area.owner.find_child("StaminaComponent").change_max_value(value)
	
	tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT_IN).set_parallel().set_loops(1)
	tween.tween_property(self, "position:y", position.y + 2, 0.5)
	tween.tween_property(self, "rotation:y", rotation.y + 3 * PI, 0.5)
	tween.tween_property(self, "scale", Vector3(0.05, 0.05, 0.05), 0.5)
	
	await tween.finished
	
	queue_free()
