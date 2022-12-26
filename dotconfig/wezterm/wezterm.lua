local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()

local mykeys = {}
table.insert(mykeys, {
	key = "LeftArrow",
	mods = "CTRL|SHIFT",
	action = wezterm.action.ActivateTabRelative(-1),
})

table.insert(mykeys, {
	key = "RightArrow",
	mods = "CTRL|SHIFT",
	action = wezterm.action.ActivateTabRelative(1),
})

return {
	colors = colors,
	window_frame = window_frame,
	font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", italic = true }),
	font_size = 15.0,
	scrollback_lines = 2500,
	cursor_blink_ease_in = "EaseOut",
	cursor_blink_rate = 450,
	default_cursor_style = "BlinkingBar",
	cursor_thickness = "2px",

	use_fancy_tab_bar = false,
	enable_wayland = true,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = "17px",
		right = "0px",
		top = "0px",
		bottom = "1px",
	},
	keys = mykeys,
}
