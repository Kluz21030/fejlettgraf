class_name EndOfLevel extends Area3D

@export var next_level: PackedScene
@export var next_level_name: String

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	Events.choice_accepted.connect(_on_accept)

func _on_area_entered(area: Area3D) -> void:
	Events.eol_reached.emit("Enter: %s?" % next_level_name)

func _on_accept() -> void:
	Events.transition_to_next_level.emit(next_level)
