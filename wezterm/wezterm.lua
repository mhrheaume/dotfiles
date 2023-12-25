local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Font
config.font = wezterm.font_with_fallback({
	"Fira Code",
	{ family = "Symbols Nerd Font Mono", scale = 0.6 },
})
config.font_size = 11.0
config.audible_bell = "Disabled"

-- Tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.mouse_wheel_scrolls_tabs = false

-- Colors
config.color_scheme = "Tokyo Night"

return config
