extends Control

@export_group("Settings")
@export var key_display: KeyDisplay
@export var key_dropdown: OptionButton
@export var pressed_checkbox: CheckBox

var keys: Dictionary = {}

func build_properties():
	var key_index = 0;
	for key in key_display.Keys:
		key_dropdown.add_item(key, key_index)
		keys[key_index] = key
		key_index += 1
	
	var extra_key_index = key_display.Keys.size()
	for extra_key in key_display.ExtraKeys:
		key_dropdown.add_item(extra_key, extra_key_index)
		keys[extra_key_index] = extra_key
		extra_key_index += 1
	
	pressed_checkbox.button_pressed = key_display.is_pressed
	
func connect_signals():
	key_dropdown.connect("item_selected", _on_key_selected)
	pressed_checkbox.connect("toggled", _on_key_pressed_toggle)

func _ready() -> void:
	build_properties()
	connect_signals()
	
func _on_key_selected(index: int):
	var selected_key = keys[index]
	key_display.key = selected_key
	
func _on_key_pressed_toggle(is_pressed: bool):
	key_display.is_pressed = is_pressed
