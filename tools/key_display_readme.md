## Description

### Overview
The `KeyDisplay` node is responsible for rendering a specific keyboard key as an image. It supports both regular keys and extra keys, with customizable textures, sizes, and pressed states.

### Properties
- **key (String):** The specific key to be rendered. It can be one of many predefined keys (e.g., "UP", "A", "F1"). Changing this property triggers the `_on_value_change` method.
- **is_pressed (bool):** Indicates whether the key is rendered in a pressed state. Changing this property also triggers the `_on_value_change` method.
- **keyboard_texture (Texture2D):** The texture used for rendering regular keys.
- **keyboard_extras_texture (Texture2D):** The texture used for rendering extra keys.
- **key_size (int):** The size of each key in pixels.
- **key_pressed_offset (int):** The vertical offset for pressed textures of regular keys.
- **extra_key_pressed_offset (int):** The vertical offset for pressed textures of extra keys.

### Signals
- **value_change:** Emitted when either the `key` or `is_pressed` properties are changed.

### Methods
- **setup_texture():** Determines the appropriate texture to use based on the `key` property.
- **build_key_data():** Sets up the key data (position and type) based on the `key` property.
- **setup():** Configures the `AtlasTexture` for rendering the key, setting the appropriate region and texture based on the key's type and pressed state.
- **_start():** Initializes the node by connecting the `value_change` signal and setting up the texture and key data.
- **_on_value_change(property, new_value):** Responds to changes in the `key` or `is_pressed` properties, triggering a re-setup of the texture and key data.

### Key Data
- **Keys:** A dictionary containing the positions of regular keys.
- **ExtraKeys:** A dictionary containing the positions of extra keys.

### Usage
1. **Define the key to be rendered:** Set the `key` property to one of the predefined keys.
2. **Set the pressed state:** Adjust the `is_pressed` property to indicate whether the key is pressed.
3. **Configure textures:** Assign appropriate textures to the `keyboard_texture` and `keyboard_extras_texture` properties.
4. **Adjust key size and offsets:** Set the `key_size`, `key_pressed_offset`, and `extra_key_pressed_offset` properties as needed.

### How It Works
The `KeyDisplay` node uses an `AtlasTexture` to render the appropriate key. An `AtlasTexture` allows for cutting specific regions from a larger texture atlas. Here's how it works in this context:

1. **Determine the texture:** Based on whether the key is a regular or extra key, the node selects the appropriate texture (`keyboard_texture` or `keyboard_extras_texture`).
2. **Calculate the region:** Using the `key_size` and the key's position from the `Keys` or `ExtraKeys` dictionary, the node calculates the region to be displayed. If the key is pressed, it adjusts the vertical position using `key_pressed_offset` or `extra_key_pressed_offset`.
3. **Set the region:** The node configures the `AtlasTexture` with the calculated region (`Rect2`) and assigns the selected texture to it.
4. **Render the key:** Finally, the node sets the `AtlasTexture` as its texture, rendering the desired key on the screen.

This approach ensures that each key is accurately rendered from the appropriate section of the texture atlas, allowing for efficient and flexible key display.
