@tool
class_name KeyDisplay
extends TextureRect

signal value_change

## Key to be rendered
@export_enum("UP", "DOWN", "LEFT", "RIGHT", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
						 "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", 
						 "V", "W", "X", "Y", "Z", "PERIOD", "COMMA", "QUESTION", "SLASH", "BACKSLASH", "SEMICOLON", "APOSTROPHE", 
						 "LBRACKET", "RBRACKET", "DASH", "EQUALPLUS", "TILDE", "TAB", "ESC", "PRINT", "BACK", "SHIFT", "PGUP", "PGDN", "ENTER", "CTRL", "ALT", "SPACE", "INS", "DEL", "END", "HM", "PAUSE") 
var key: String = "UP":
	set(new_key):
		key = new_key
		_on_value_change("key", new_key)

## Determines if the key is rendered as pressed
@export var is_pressed: bool = false:
	set(new_value):
		is_pressed = new_value
		_on_value_change("is_pressed", new_value)

@export_group("Settings")
## Texture for regular keys
@export var keyboard_texture: Texture2D = preload("res://assets/keyboard.png")
## Texture for extra keys
@export var keyboard_extras_texture: Texture2D = preload("res://assets/keyboard_extras.png")
## Size of each key
@export var key_size: int = 16
## Number of vertical keys before pressed textures
@export var key_pressed_offset: int = 7
## Number of vertical extra keys before pressed textures
@export var extra_key_pressed_offset: int = 4


var ExtraKeys: Dictionary = {
	TAB = {"key": "TAB", "pos": Vector2(0, 0)},
	ESC = {"key": "ESC", "pos": Vector2(1, 0)},
	PRINT = {"key": "PRINT", "pos": Vector2(2, 0)},
	BACK = {"key": "BACK", "pos": Vector2(3, 0)},
	SHIFT = {"key": "SHIFT", "pos": Vector2(0, 1)},
	PGUP = {"key": "PGUP", "pos": Vector2(1, 1)},
	PGDN = {"key": "PGDN", "pos": Vector2(2, 1)},
	ENTER = {"key": "ENTER", "pos": Vector2(3, 1)},
	CTRL = {"key": "CTRL", "pos": Vector2(0, 2)},
	ALT = {"key": "ALT", "pos": Vector2(1, 2)},
	SPACE = {"key": "SPACE", "pos": Vector2(2, 2)},
	INS = {"key": "INS", "pos": Vector2(3, 2)},
	DEL = {"key": "DEL", "pos": Vector2(0, 3)},
	END = {"key": "END", "pos": Vector2(1, 3)},
	HM = {"key": "HM", "pos": Vector2(2, 3)},
	PAUSE = {"key": "PAUSE", "pos": Vector2(3, 3)},
}

var Keys: Dictionary = {
	UP = {"key": "UP", "pos": Vector2(0, 0)},
	DOWN = {"key": "DOWN", "pos": Vector2(1,0)},
	LEFT = {"key": "LEFT", "pos": Vector2(2,0)},
	RIGHT = {"key": "RIGHT", "pos": Vector2(3,0)},
	F1 = {"key": "F1", "pos": Vector2(4,0)},
	F2 = {"key": "F2", "pos": Vector2(5,0)},
	F3 = {"key": "F3", "pos": Vector2(6,0)},
	F4 = {"key": "F4", "pos": Vector2(7,0)},
	F5 = {"key": "F5", "pos": Vector2(0,1)},
	F6 = {"key": "F6", "pos": Vector2(1,1)},
	F7 = {"key": "F7", "pos": Vector2(2,1)},
	F8 = {"key": "F8", "pos": Vector2(3,1)},
	F9 = {"key": "F9", "pos": Vector2(4,1)},
	F10 = {"key": "F10", "pos": Vector2(5,1)},
	F11 = {"key": "F11", "pos": Vector2(6,1)},
	F12 = {"key": "F12", "pos": Vector2(7,1)},
	A = {"key": "A", "pos": Vector2(0,2)},
	B = {"key": "B", "pos": Vector2(1,2)},
	C = {"key": "C", "pos": Vector2(2,2)},
	D = {"key": "D", "pos": Vector2(3,2)},
	E = {"key": "E", "pos": Vector2(4,2)},
	F = {"key": "F", "pos": Vector2(5,2)},
	G = {"key": "G", "pos": Vector2(6,2)},
	H = {"key": "H", "pos": Vector2(7,2)},
	I = {"key": "I", "pos": Vector2(0,3)},
	J = {"key": "J", "pos": Vector2(1,3)},
	K = {"key": "K", "pos": Vector2(2,3)},
	L = {"key": "L", "pos": Vector2(3,3)},
	M = {"key": "M", "pos": Vector2(4,3)},
	N = {"key": "N", "pos": Vector2(5,3)},
	O = {"key": "O", "pos": Vector2(6,3)},
	P = {"key": "P", "pos": Vector2(7,3)},
	Q = {"key": "Q", "pos": Vector2(0,4)},
	R = {"key": "R", "pos": Vector2(1,4)},
	S = {"key": "S", "pos": Vector2(2,4)},
	T = {"key": "T", "pos": Vector2(3,4)},
	U = {"key": "U", "pos": Vector2(4,4)},
	V = {"key": "V", "pos": Vector2(5,4)},
	W = {"key": "W", "pos": Vector2(6,4)},
	X = {"key": "X", "pos": Vector2(7,4)},
	Y = {"key": "Y", "pos": Vector2(0,5)},
	Z = {"key": "Z", "pos": Vector2(1,5)},
	PERIOD = {"key": ".", "pos": Vector2(2,5)},
	COMMA = {"key": ",", "pos": Vector2(3,5)},
	QUESTION = {"key": "?", "pos": Vector2(4,5)},
	SLASH = {"key": "/", "pos": Vector2(5,5)},
	BACKSLASH = {"key": "\\", "pos": Vector2(6,5)},
	SEMICOLON = {"key": ";", "pos": Vector2(7,5)},
	APOSTROPHE = {"key": "'", "pos": Vector2(0,6)},
	LBRACKET = {"key": "[", "pos": Vector2(1,6)},
	RBRACKET = {"key": "]", "pos": Vector2(2,6)},
	DASH = {"key": "-", "pos": Vector2(3,6)},
	EQUALPLUS = {"key": "=+", "pos": Vector2(4,6)},
	TILDE = {"key": "~", "pos": Vector2(5,6)}
}

var key_type: String = 'regular'
var atlas_texture: AtlasTexture
var keys_texture: Texture2D
var key_data: Dictionary = {}

func setup_texture():
	if Keys.has(key):
		keys_texture = keyboard_texture
		key_type = 'regular'
	elif ExtraKeys.has(key):
		keys_texture = keyboard_extras_texture
		key_type = 'extra'
	else:
		push_warning("Key not found")

func build_key_data():
	if Keys.has(key):
		key_data = Keys[key]
	elif ExtraKeys.has(key):
		key_data = ExtraKeys[key]
	else:
		push_warning("Key not found")
		
func setup():
	if not atlas_texture:
		atlas_texture = AtlasTexture.new()
		
	var key_pos: Vector2 = key_data.pos
	var region_x = key_size * key_pos[0]
	var region_y = key_size
	if is_pressed:
		if key_type == 'extra':
			region_y *= extra_key_pressed_offset + key_pos[1]
		else:
			region_y *= key_pressed_offset + key_pos[1]
	else:
		region_y *= key_pos[1]
	var region_w = key_size - 1
	var region_h = key_size
	if (key_type == 'extra'):
		region_x = (region_x * 2) + 1
		region_w *= 2
	atlas_texture.region = Rect2(region_x, region_y, region_w, region_h)
		
	atlas_texture.atlas = keys_texture
	
	texture = atlas_texture
	
func _start():
	self.connect("value_change", _on_value_change)
	setup_texture()
	build_key_data()
	setup()
	
func _on_value_change(property: StringName, new_value: Variant):
	value_change.emit(property, new_value)
	
	setup_texture()
	build_key_data()
	setup()
