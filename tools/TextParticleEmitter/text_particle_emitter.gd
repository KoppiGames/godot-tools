@tool
class_name TextParticleEmitter
extends GPUParticles2D

signal value_change # Signal emitted when a property value changes

@export_category("Text")
@export_multiline var text: String = "Example": # Multi-line export for text with default value "Example"
	set(new_text):
		text = new_text
		# Emit signal when text changes
		value_change.emit("text", new_text)
		
@export_group("Theme")
@export var theme: Theme: # Exported theme property
	set(new_theme):
		theme = new_theme
		# Emit signal when theme changes
		value_change.emit("theme", new_theme)
		
@export_subgroup("Theme Overrides")
@export_subgroup("Colors")
@export var font_color: Color = Color("#000"): # Font color with default black
	set(new_font_color):
		font_color = new_font_color
		# Emit signal when font color changes
		value_change.emit("font_color", new_font_color)
		
@export var font_shadow_color: Color = Color("#000"): # Shadow color for the font
	set(new_font_shadow_color):
		font_shadow_color = new_font_shadow_color
		# Emit signal when font shadow color changes
		value_change.emit("font_shadow_color", new_font_shadow_color)
		
@export var font_outline_color: Color = Color("#000"): # Outline color for the font
	set(new_font_outline_color):
		font_outline_color = new_font_outline_color
		# Emit signal when font outline color changes
		value_change.emit("font_outline_color", new_font_outline_color)

@export_subgroup("Fonts")
@export var font: Font: # Exported font property
	set(new_font):
		font = new_font
		# Emit signal when font changes
		value_change.emit("font", new_font)
		
@export_custom(PROPERTY_HINT_NONE, "suffix:px") var font_size: int = 20: # Font size with "px" suffix
	set(new_font_size):
		font_size = new_font_size
		# Emit signal when font size changes
		value_change.emit("font_size", new_font_size)
		
@export_category("Viewport")
@export var size: Vector2 = Vector2(100, 100): # Viewport size with default value 100x100
	set(new_size):
		size = new_size
		# Emit signal when size changes
		value_change.emit("size", new_size)

@export_category("Particle Presets")
enum Presets {CUSTOM, ONEUP, EXPLOSION} # Enum for particle effect presets
@export var preset: Presets = 0: # Default preset (CUSTOM)
	set(new_preset):
		preset = new_preset
		# Emit signal when preset changes
		value_change.emit("preset", new_preset)

var viewport: SubViewport # SubViewport to display text
var label: Label # Label for rendering text
var particle_material: ParticleProcessMaterial # Material for particle processing
		
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
		viewport.transparent_bg = true # Make background transparent
		add_child(viewport)
		viewport.set_owner(get_parent()) # Set the owner to the parent node
	
	# Check if the viewport contains a Label
	if viewport.get_child_count() > 0 and viewport.get_child(0) is Label:
		label = viewport.get_child(0)
	else:
		# Create a new Label if not found
		label = Label.new()
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER # Center text horizontally
		label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER # Center text vertically
		label.set_anchors_preset(Control.PRESET_FULL_RECT) # Set anchor preset to Full Rect
		viewport.add_child(label)
		label.set_owner(get_parent())

func setup_particle_material():
	# Create a new particle material if not already set
	if not process_material:
		particle_material = ParticleProcessMaterial.new()
		process_material = particle_material

func reset_effects():
	# Reset particle effects by creating a new particle material
	particle_material = ParticleProcessMaterial.new()
	process_material = particle_material
	explosiveness = 0 # Reset explosiveness value
		
func setup_texture():
	# Set the viewport texture for the particles
	texture = viewport.get_texture()
		
func update_label():
	# Update label properties based on current values
	label.text = text # Update text content
	label.theme = theme # Update theme
	
	# Update font color, shadow color, and outline color based on overrides
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
	
	# Update font and font size
	if font:
		label.set("theme_override_fonts/font", font)
	elif label.get("theme_override_fonts/font"):
		label.set("theme_override_fonts/font", null)
	
	if font_size:
		label.set("theme_override_font_sizes/font_size", font_size)
	elif label.get("theme_override_font_sizes/font_size"):
		label.set("theme_override_font_sizes/font_size", null)

func update_viewport():
	# Update viewport size based on current size property
	viewport.size = size

func setup():
	# Setup viewport, particle material, and texture
	setup_viewport()
	setup_particle_material()
	setup_texture()
	
func _ready() -> void:
	# Call setup functions when the node is ready
	setup()

func _enter_tree() -> void:
	# Connect value change signal and update label/viewport when entering the scene tree
	if not self.is_connected("value_change", _on_value_change):
		self.connect("value_change", _on_value_change)
	
	setup()
	update_label()
	update_viewport()
	
func _on_value_change(property: StringName, _new_value: Variant):
	# Update setup, label, and viewport when a property value changes
	setup()
	update_label()
	update_viewport()
	if (property == 'preset'):
		# Handle preset-specific updates
		_on_preset_update()

func _on_preset_update():
	# Update particle effects based on selected preset
	reset_effects()
	match preset:
		Presets.EXPLOSION:
			# Explosion preset: set specific particle properties
			explosiveness = 1
			particle_material.gravity = Vector3(0, 0, 0)
			particle_material.initial_velocity_min = 50
			particle_material.initial_velocity_max = 100
			particle_material.spread = 180
		Presets.ONEUP:
			# ONEUP preset: set gravity and velocity for particle effect
			particle_material.initial_velocity_max = 24
			particle_material.gravity = Vector3(0, -100, 0)
			particle_material.spread = 180
