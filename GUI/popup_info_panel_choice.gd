extends Panel

@export var label: RichTextLabel

var tween: Tween

func _ready():
	Events.eol_reached.connect(_on_popup_info)
	scale = Vector2(0.05, 0.05)
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept") or event.is_action_pressed("cancel"):
		if tween and tween.is_valid():
			tween.kill()
		tween = create_tween().set_trans(Tween.TRANS_BACK)
		tween.tween_property(self, "scale", Vector2(0.05, 0.05), 0.3)
		await tween.finished
		self.modulate.a = 0.0
		set_process_input(false)
		if event.is_action_pressed("accept"):
			Events.choice_accepted.emit()

func _on_popup_info(text: String) -> void:
	set_process_input(true)
	label.text = text
	self.modulate.a = 1.0
	if tween and tween.is_valid():
		tween.kill()
	tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3)
