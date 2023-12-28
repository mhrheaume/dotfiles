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

config.window_padding = {
	left = "0",
	right = "5",
	top = "5",
	bottom = "5",
}

-- Tab bar
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.mouse_wheel_scrolls_tabs = false
config.tab_bar_at_bottom = true

local ACTIVE_TAB_FG = { AnsiColor = "Black" }
local ACTIVE_TAB_BG = { AnsiColor = "Blue" }
local INACTIVE_TAB_FG = { AnsiColor = "White" }
-- HACK: Use resolved palette, from configuration, maybe?
local INACTIVE_TAB_BG = { Color = "#1a1b26" }
local TAB_BG = { Color = "#1a1b26" }

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local next_tab = tabs[tab.tab_index + 2]

	local title
	if tab.tab_title ~= nil and #tab.tab_title > 0 then
		title = tab.tab_title
	else
		title = tab.active_pane.title
	end

	if tab.is_active then
		local divider
		if next_tab == nil then
			divider = wezterm.format({
				{ Background = TAB_BG },
				{ Foreground = ACTIVE_TAB_BG },
				{ Text = wezterm.nerdfonts.pl_left_hard_divider },
			})
		else
			divider = wezterm.format({
				{ Background = INACTIVE_TAB_BG },
				{ Foreground = ACTIVE_TAB_BG },
				{ Text = wezterm.nerdfonts.pl_left_hard_divider },
			})
		end
		return {
			{ Background = ACTIVE_TAB_BG },
			{ Foreground = ACTIVE_TAB_FG },
			{
				Text = " "
					.. tab.tab_index
					.. " "
					.. wezterm.nerdfonts.pl_left_soft_divider
					.. " "
					.. title
					.. " "
					.. divider,
			},
		}
	else
		local divider
		if next_tab == nil then
			divider = wezterm.format({
				{ Background = TAB_BG },
				{ Foreground = INACTIVE_TAB_BG },
				{ Text = wezterm.nerdfonts.pl_left_hard_divider },
			})
		elseif next_tab.is_active then
			divider = wezterm.format({
				{ Background = ACTIVE_TAB_BG },
				{ Foreground = INACTIVE_TAB_BG },
				{ Text = wezterm.nerdfonts.pl_left_hard_divider },
			})
		else
			divider = wezterm.format({
				{ Background = INACTIVE_TAB_BG },
				{ Foreground = INACTIVE_TAB_BG },
				{ Text = wezterm.nerdfonts.pl_left_hard_divider },
			})
		end
		return {
			{ Background = INACTIVE_TAB_BG },
			{ Foreground = INACTIVE_TAB_FG },
			{
				Text = " "
					.. tab.tab_index
					.. " "
					.. wezterm.nerdfonts.pl_left_soft_divider
					.. " "
					.. title
					.. " "
					.. divider,
			},
		}
	end
end)

-- Colors
config.color_scheme = "Tokyo Night"

-- Keybindings
config.leader = { key = "a", mods = "CTRL" }
config.disable_default_key_bindings = true
config.keys = {
	-- New window
	{
		key = "n",
		mods = "SUPER",
		action = wezterm.action.SpawnWindow,
	},
	-- New tab
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	-- Close tab
	{
		key = "&",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	-- Previous tab
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	-- Next tab
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- Move tab left
	{
		key = "p",
		mods = "LEADER|CTRL",
		action = wezterm.action.MoveTabRelative(-1),
	},
	-- Move tab right
	{
		key = "n",
		mods = "LEADER|CTRL",
		action = wezterm.action.MoveTabRelative(1),
	},
	{
		key = ".",
		mods = "LEADER",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Copy
	{
		key = "c",
		mods = "SUPER",
		action = wezterm.action.CopyTo("Clipboard"),
	},
	-- Paste
	{
		key = "v",
		mods = "SUPER",
		action = wezterm.action.PasteFrom("Clipboard"),
	},
	-- Debug
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action.ShowDebugOverlay,
	},
}

return config
