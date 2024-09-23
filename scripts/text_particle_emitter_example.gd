extends Control

@export_group("Settings")
@export var text_particle_emitter: TextParticleEmitter
@export var text: TextEdit
@export var amount: SpinBox
@export var font_size: SpinBox
@export var preset_dropdown: OptionButton
	
func connect_signals():
	preset_dropdown.connect("item_selected", _on_preset_selected)
	text.connect("text_changed", _on_text_changed)
	font_size.connect("value_changed", _on_font_size_changed)
	amount.connect("value_changed", _on_amount_changed)

func _ready() -> void:
	connect_signals()

func _on_preset_selected(index: int):
	text_particle_emitter.preset = index

func _on_text_changed():
	text_particle_emitter.text = text.text
	
func _on_font_size_changed(new_size: float):
	text_particle_emitter.font_size = int(new_size)

func _on_amount_changed(new_amount: float):
	text_particle_emitter.amount = int(new_amount)
