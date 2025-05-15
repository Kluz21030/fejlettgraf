extends TextureRect

@export var label: Label
@export var timer: Timer

func _ready() -> void:
	Events.player_died.connect(appear)

func appear() -> void:
	var tween: Tween = create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(self, "self_modulate:a", 0.25, 0.25)
	tween.tween_property(label, "self_modulate:a", 1.0, 0.5)
	tween.parallel().tween_property(self, "self_modulate:a", 1.0, 0.75)
	await tween.finished
	timer.start()
	await timer.timeout
	Events.death_popup_finished.emit()
