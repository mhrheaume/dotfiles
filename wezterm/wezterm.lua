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

-- Keybindings
config.disable_default_key_bindings = true
config.keys = {
	-- New window
	{
		key = "n",
		mods = "SUPER",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "c",
		mods = "SUPER",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = "SUPER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
}

return config
