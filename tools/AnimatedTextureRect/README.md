## Description

### Overview
The `AnimatedTextureRect` node extends `TextureRect` to display an animated texture using a sprite sheet. It allows for defining the number of frames horizontally and vertically, and selecting the current frame to display.

### Properties
- **animation_texture (Texture2D):** The animated texture resource. Changing this property triggers the `_on_value_change` method.
- **h_frames (int):** The number of columns in the sprite sheet. Changing this property triggers the `_on_value_change` method.
- **v_frames (int):** The number of rows in the sprite sheet. Changing this property triggers the `_on_value_change` method.
- **frame (int):** The current frame to display from the sprite sheet. Either `h_frames` or `v_frames` must be greater than 1. Changing this property triggers the `_on_value_change` method.

### Signals
- **value_change:** Emitted when any of the properties (`animation_texture`, `h_frames`, `v_frames`, `frame`) are changed.

### Methods
- **get_frame_pos() -> Vector2:** Calculates and returns the column and row of the current frame in the sprite sheet.
- **setup():** Configures the `AtlasTexture` and sets up the texture size and frame size based on the `animation_texture`, `h_frames`, and `v_frames` properties.
- **build_frame():** Calculates the region of the current frame and sets it on the `AtlasTexture`.
- **_ready() -> void:** Initializes the node by calling `setup()` and `build_frame()`.
- **_on_value_change(property: StringName, new_value: Variant):** Responds to changes in any of the properties, emitting the `value_change` signal and re-configuring the texture and frame.

### Usage
1. **Assign the animated texture:** Set the `animation_texture` property to the desired `Texture2D` resource.
2. **Define the sprite sheet dimensions:** Set the `h_frames` and `v_frames` properties to indicate the number of columns and rows in the sprite sheet.
3. **Select the current frame:** Adjust the `frame` property to display the desired frame from the sprite sheet.

### Integration with AnimationPlayer
The `AnimatedTextureRect` node can be used with an `AnimationPlayer` to create smooth animations by incrementing the `frame` value. Here's how to set it up:

1. **Add an AnimationPlayer node:** Add an `AnimationPlayer` node to the same scene as the `AnimatedTextureRect` node.
2. **Create a new animation:** In the `AnimationPlayer`, create a new animation.
3. **Add keyframes for the frame property:** For each frame in your sprite sheet, add a key to the `frame` property of the `AnimatedTextureRect` node. This will increment the `frame` value, displaying the corresponding frame from the sprite sheet.
4. **Set the animation length and playback:** Adjust the animation length and playback settings to control the speed of the animation.

### Example
1. **Select the `AnimatedTextureRect` node in the AnimationPlayer timeline.**
2. **Animate the `frame` property by adding keyframes at different points in time.** For example:
   - At 0.0 seconds, set `frame` to 0.
   - At 0.1 seconds, set `frame` to 1.
   - At 0.2 seconds, set `frame` to 2.
   - Continue this process for all frames in the sprite sheet.

This setup allows the `AnimationPlayer` to automatically increment the `frame` value over time, creating a smooth animation from the sprite sheet.

### How It Works
The `AnimatedTextureRect` node uses an `AtlasTexture` to render the appropriate frame from the sprite sheet. An `AtlasTexture` allows for cutting specific regions from a larger texture atlas. Here's how it works in this context:

1. **Configure the texture:** The `animation_texture` property is assigned to the `atlas_texture`.
2. **Calculate frame size:** Based on the texture size and the number of horizontal and vertical frames (`h_frames` and `v_frames`), the node calculates the size of each frame.
3. **Determine the frame region:** Using the `frame` property, the node calculates the column and row of the current frame and then the specific region within the texture atlas.
4. **Set the region:** The node configures the `AtlasTexture` with the calculated region (`Rect2`) and assigns the selected texture to it.
5. **Render the frame:** Finally, the node sets the `AtlasTexture` as its texture, rendering the desired frame on the screen.

This approach ensures that each frame is accurately rendered from the appropriate section of the texture atlas, allowing for efficient and flexible animation display.
