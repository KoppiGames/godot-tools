@tool
class_name TextParticleEmitter
extends GPUParticles2D

signal value_change

@export_category("Text")
@export_multiline var text: String = ":D":
	set(new_text):
		text = new_text
		value_change.emit("text", new_text)
		
@export_group("Theme")
@export var theme: Theme:
	set(new_theme):
		theme = new_theme
		value_change.emit("theme", new_theme)
		
@export_subgroup("Theme Overrides")
@export_subgroup("Colors")
@export var font_color: Color = Color("#000"):
	set(new_font_color):
		font_color = new_font_color
		value_change.emit("font_color", new_font_color)
@export var font_shadow_color: Color = Color("#000"):
	set(new_font_shadow_color):
		font_shadow_color = new_font_shadow_color
		value_change.emit("font_shadow_color", new_font_shadow_color)
@export var font_outline_color: Color = Color("#000"):
	set(new_font_outline_color):
		font_outline_color = new_font_outline_color
		value_change.emit("font_outline_color", new_font_outline_color)
		
@export_subgroup("Fonts")
@export var font: Font:
	set(new_font):
		font = new_font
		value_change.emit("font", new_font)
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var font_size: int = 20:
	set(new_font_size):
		font_size = new_font_size
		value_change.emit("font_size", new_font_size)
		
@export_category("Viewport")
@export var size: Vector2 = Vector2(100, 100):
	set(new_size):
		size = new_size
		value_change.emit("size", new_size)
		
@export_category("Particle Presets")
enum Presets {CUSTOM}
@export var presets: Presets

var viewport: SubViewport
var label: Label
var particle_material: ParticleProcessMaterial
		
func setup_viewport():
	# Early return if the viewport is already set
	if viewport:
		return
	
	# Check if the first child is a SubViewport
	if get_child_count() > 0 and get_child(0) is SubViewport:
		viewport = get_child(0)
	else:
		# Create a new SubViewport if not found
		viewport = SubViewport.new()
		viewport.transparent_bg = true
		add_child(viewport)
		viewport.set_owner(get_parent())
	
	# Check if the viewport contains a Label
	if viewport.get_child_count() > 0 and viewport.get_child(0) is Label:
		label = viewport.get_child(0)
	else:
		# Create a new Label if not found
		label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		viewport.add_child(label)
		label.set_owner(get_parent())

func setup_particle_material():
	if not process_material:
		particle_material = ParticleProcessMaterial.new()
		process_material = particle_material
		
func setup_texture():
	texture = viewport.get_texture()
		
func update_label():
	label.text = text
	label.theme = theme
	
	if font_color:
		label.add_theme_color_override("font_color", font_color)
	elif label.has_theme_color_override("font_color"):
		label.remove_theme_color_override("font_color")
		
	if font_shadow_color:
		label.add_theme_color_override("font_shadow_color", font_shadow_color)
	elif label.has_theme_color_override("font_shadow_color"):
		label.remove_theme_color_override("font_shadow_color")
	
	if font_outline_color:
		label.add_theme_color_override("font_outline_color", font_outline_color)
	elif label.has_theme_color_override("font_outline_color"):
		label.remove_theme_color_override("font_outline_color")
	
	if font:
		label.set("theme_override_fonts/font", font)
	elif label.get("theme_override_fonts/font"):
		label.set("theme_override_fonts/font", null)
	
	if font_size:
		label.set("theme_override_font_sizes/font_size", font_size)
	elif label.get("theme_override_font_sizes/font_size"):
		label.set("theme_override_font_sizes/font_size", null)

func update_viewport():
	viewport.size = size

func setup():
	setup_viewport()
	setup_particle_material()
	setup_texture()
	
func _ready() -> void:
	setup()

func _enter_tree() -> void:
	self.connect("value_change", _on_value_change)
	
	setup()
	update_label()
	update_viewport()
	
func _on_value_change(_property: StringName, _new_value: Variant):
	setup()
	update_label()
	update_viewport()
