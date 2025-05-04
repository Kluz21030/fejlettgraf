extends ProgressBar


func _ready() -> void:
	Events.boss_health_changed.connect(_on_boss_health_changed)

func _on_boss_health_changed(current_value: int, max_value: int):
	self.max_value = max_value
	value = current_value
