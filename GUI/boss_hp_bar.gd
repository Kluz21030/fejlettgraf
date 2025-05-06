extends ProgressBar

var tween: Tween

func _ready() -> void:
	Events.boss_health_changed.connect(_on_boss_health_changed)
	Events.boss_engaged.connect(_on_engaged)

func _on_boss_health_changed(current_value: int, max_value: int):
	self.max_value = max_value
	if not (tween and tween.is_valid()):
		tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "value", current_value, 0.25)

func _on_engaged() -> void:
	if not (tween and tween.is_valid()):
		tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)
