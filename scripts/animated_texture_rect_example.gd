extends Control

@export_group("Settings")
@export var animated_texture_rect: AnimatedTextureRect
@export var hframes_text: TextEdit
@export var vframes_text: TextEdit
@export var frame_text: TextEdit
@export var speed_slider: HSlider
@export var animation_player: AnimationPlayer

func _ready() -> void:
	hframes_text.text = str(animated_texture_rect.h_frames)
	vframes_text.text = str(animated_texture_rect.v_frames)
	speed_slider.value = animation_player.speed_scale
	speed_slider.connect("value_changed", _on_speed_change)

func _process(delta: float) -> void:
	frame_text.text = str(animated_texture_rect.frame)

func _on_speed_change(speed: float):
	print(speed)
	animation_player.speed_scale = speed
