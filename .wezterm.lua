-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Tokyo Night Moon"

config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font_size = 16

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "1cell",
	bottom = "1cell",
}

-- and finally, return the configuration to wezterm
return config
