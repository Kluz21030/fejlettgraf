extends ColorRect

var tween: Tween

func _ready() -> void:
	Events.start_transition_fade.connect(fade)

func fade(out: bool = false) -> void:
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "self_modulate:a", float(out), 0.5)
	await tween.finished
	Events.transition_fade_finished.emit()
