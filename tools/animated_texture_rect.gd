@tool
class_name AnimatedTextureRect
extends TextureRect

signal value_change

@export_group("Animation")
@export var animation_texture: Texture2D:
	set(new_animation_texture):
		animation_texture = new_animation_texture
		_on_value_change("animation_texture", new_animation_texture)
@export var h_frames: int = 1:
	set(new_h_frames):
		h_frames = new_h_frames
		_on_value_change("h_frames", new_h_frames)
@export var v_frames: int = 1:
	set(new_v_frames):
		v_frames = new_v_frames
		_on_value_change("v_frames", new_v_frames)
@export var frame: int:
	set(new_frame):
		frame = new_frame
		_on_value_change("frame", new_frame)
@export var frame_coords: Vector2:
	set(new_frame_coords):
		frame_coords = new_frame_coords
		_on_value_change("frame_coords", new_frame_coords)

var atlas_texture: AtlasTexture
var texture_size: Vector2
var texture_frame_size: Vector2

func get_frame_pos() -> Vector2:
	# Calculate the column and row
	var column = frame % h_frames
	var row = frame / h_frames
	
	# Create the frame_pos Vector2
	var frame_pos = Vector2(column, row)
	
	return frame_pos

func setup():
	if not atlas_texture:
		atlas_texture = AtlasTexture.new()
	if not animation_texture:
		push_warning("Missing texture in ", self)
		return
	atlas_texture.atlas = animation_texture
	
	texture_size = animation_texture.get_size()
	var texture_frame_size_x = texture_size.x / h_frames
	var texture_frame_size_y = texture_size.y / v_frames
	texture_frame_size = Vector2(texture_frame_size_x, texture_frame_size_y)

	texture = atlas_texture

func build_frame():
	var frame_pos = get_frame_pos()
	var region_x = texture_frame_size.x * frame_pos.x
	var region_y = texture_frame_size.y * frame_pos.y
	var region_w = texture_frame_size.x
	var region_h = texture_frame_size.y
	
	atlas_texture.region = Rect2(region_x, region_y, region_w, region_h)

func _ready() -> void:
	setup()
	build_frame()

func _on_value_change(property: StringName, new_value: Variant):
	value_change.emit(property, new_value)
	setup()
	build_frame()
