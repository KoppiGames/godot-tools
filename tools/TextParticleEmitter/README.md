# TextParticleEmitter

## Description

### Overview
The `TextParticleEmitter` node is responsible for rendering text within a particle effect using a `SubViewport` and `GPUParticles2D`. It allows for customizable text, themes, fonts, and particle presets to create dynamic visual effects.

> [!NOTE] 
> All properties emit the `value_change` signal when modified.

### Properties

#### Text
- **text (String):** The text that will be rendered.

#### Theme
- **theme (Theme):** The theme for the label rendering the text.

#### Theme Overrides
##### Colors
- **font_color (Color):** The color of the text font.
- **font_shadow_color (Color):** The color of the text's shadow, if any.
- **font_outline_color (Color):** The color of the text's outline, if any.

##### Fonts
- **font (Font):** The font used for rendering the text.
- **font_size (int):** The size of the font, in pixels.

#### Viewport
- **size (Vector2):** The size of the viewport used to render the text.

#### Particle Presets
- **preset (enum Presets):** The particle effect preset. It can be set to either `CUSTOM`, `ONEUP`, or `EXPLOSION`.

### Signals
- **value_change:** Emitted whenever any property (e.g., `text`, `theme`, `font_color`, etc.) changes.

### Methods

- **setup_viewport():** Initializes the `SubViewport` and `Label` used to render the text if they are not already set up.
- **setup_particle_material():** Configures the particle material for particle effects. If no material exists, it creates a new `ParticleProcessMaterial`.
- **reset_effects():** Resets the particle effects and creates a fresh material for the particles.
- **setup_texture():** Sets up the viewport's texture for rendering the particles.
- **update_label():** Updates the label's properties such as `text`, `theme`, `font_color`, `font_shadow_color`, `font_outline_color`, `font`, and `font_size`.
- **update_viewport():** Updates the size of the viewport used for rendering.
- **setup():** Sets up the viewport, particle material, and texture.
- **_on_value_change(property, new_value):** Responds to property changes, updating the text and particle settings accordingly.
- **_on_preset_update():** Updates the particle settings when the preset is changed.

### Particle Presets

The node comes with three preset particle effects:

1. **EXPLOSION:** A burst of particles that spread outward.
2. **ONEUP:** Particles moving upward with gravity applied.
3. **CUSTOM:** Allows for manual configuration of particle properties.

### Usage

1. **Define the text to be rendered:** Set the `text` property with the desired string.
2. **Customize the theme and colors:** Adjust the `theme`, `font_color`, `font_shadow_color`, and `font_outline_color` properties.
3. **Choose or adjust the font:** Set the `font` and `font_size` properties as needed.
4. **Adjust the viewport size:** Use the `size` property to configure the viewport for rendering.
5. **Select a particle preset:** Choose from the available particle presets (`CUSTOM`, `ONEUP`, or `EXPLOSION`), or customize the particle material directly.

### How It Works

The `TextParticleEmitter` node renders text as a dynamic particle effect by combining a `SubViewport` (for rendering the text) and a `GPUParticles2D` system. Here's the step-by-step process:

1. **Setup of Viewport and Label:** A `SubViewport` and a `Label` are created to render the desired text. The text, font, and various visual properties are assigned to the label.
2. **Particle Rendering:** The viewport is used as a texture for the `GPUParticles2D` system, making the rendered text part of the particle effect.
3. **Preset Effects:** Based on the selected particle preset, the particle behavior is adjusted. For example, the `EXPLOSION` preset spreads particles outward, while the `ONEUP` preset moves particles upward with gravity.
4. **Dynamic Updates:** When any property changes (e.g., text, theme, font color), the system updates the label, viewport, and particle effects in real-time, keeping everything in sync.

This allows for the creation of engaging particle-based text effects, ideal for damage indicators, score increases, etc.