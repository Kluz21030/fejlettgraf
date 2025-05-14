extends Panel

@export var label: RichTextLabel

var tween: Tween

func _ready():
	Events.popup_info.connect(_on_popup_info)
	scale = Vector2(0.05, 0.05)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept"):
		disappear()

func _on_popup_info(text: String) -> void:
	label.text = text
	appear()

func appear() -> void:
	self.modulate.a = 1.0
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3)

func disappear() -> void:
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2(0.05, 0.05), 0.3)
	await tween.finished
	self.modulate.a = 0.0
