class_name ResourceBar extends ProgressBar

@export var resource_name: StringName

var tween: Tween

func _ready() -> void:
	Events.player_resource_changed.connect(_on_player_resource_changed)

func _on_player_resource_changed(resource_name: StringName, current_value: int, max_value: int):
	if self.resource_name != resource_name:
		return
	self.max_value = max_value
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_parallel()
	tween.tween_property(self, "custom_minimum_size", Vector2(self.max_value / 500 * 100, custom_minimum_size.y), 0.2)
	tween.tween_property(self, "value", current_value, 0.3)
