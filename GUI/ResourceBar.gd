class_name ResourceBar extends ProgressBar

@export var resource_name: StringName

func _ready() -> void:
	Events.player_resource_changed.connect(_on_player_resource_changed)

func _on_player_resource_changed(resource_name: StringName, current_value: int, max_value: int):
	if self.resource_name != resource_name:
		return
	self.max_value = max_value
	custom_minimum_size = Vector2(self.max_value / 500 * 100, custom_minimum_size.y)
	value = current_value
