-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.default_cwd = "$HOME"

-- For example, changing the color scheme:
-- config.color_scheme = "Tokyo Night Moon"
-- config.color_scheme = "Tokyo Night Day"
config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font_size = 16

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "1cell",
	bottom = "1cell",
}

-- and finally, return the configuration to wezterm
config.keys = {
  {key="Enter", mods="SHIFT", action=wezterm.action{SendString="\x1b\r"}},
}

-- and finally, return the configuration to wezterm
return config
