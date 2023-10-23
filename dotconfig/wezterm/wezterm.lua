local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

local italic = false

local fonts = {
	{ family = "iMWritingMono Nerd Font", italic = italic },
	{ family = "MesloLGL Nerd Font", italic = italic },
	{ family = "Agave Nerd Font" },
	{ family = "JetBrainsMono Nerd Font", italic = italic },
	{ family = "SauceCodePro Nerd Font", italic = italic },
	{ family = "Hasklug Nerd Font", italic = italic },
	{ family = "Hack Nerd Font", italic = italic },
	{ family = "IosevkaTerm Nerd Font", italic = italic },
	{ family = "M+CodeLat Nerd Font", italic = italic },
	{ family = "Cousine Nerd Font", italic = italic },
	{ family = "CommitMono Nerd Font", italic = italic },
	{ family = "IntoneMono Nerd Font", italic = italic },
	{ family = "Lilex Nerd Font", italic = italic },
	{ family = "GoMono Nerd Font", italic = italic },
	{ family = "Martian Mono", italic = italic },
	{ family = "Maple Mono", italic = italic },
}

local emoji_font = { "Apple Color Emoji" }
config.font = wezterm.font_with_fallback({ fonts[16], emoji_font[1] })
config.enable_scroll_bar = false
config.font_size = 14
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = true
config.default_cursor_style = "BlinkingBlock"
config.use_fancy_tab_bar = true
config.window_close_confirmation = "NeverPrompt"
config.enable_tab_bar = false
config.scrollback_lines = 2500
config.window_background_opacity = 0.8
config.term = "wezterm"
-- config.color_scheme = "Dark Pastel"

config.window_padding = {
	left = 30,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
