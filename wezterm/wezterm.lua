local wezterm = require("wezterm")
local colors = require("lua/rose-pine").colors()
local window_frame = require("lua/rose-pine").window_frame()

local mykeys = {}
for i = 1, 8 do
	-- CTRL+ALT + number to move to that position
	table.insert(mykeys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return {
	colors = colors,
	window_frame = window_frame,
	font = wezterm.font("JetBrains Mono ", { weight = "Medium", italic = false, blink = "Slow" }),
	font_size = 15.0,
	scrollback_lines = 2500,

	-- NOTE: cursor section
	cursor_blink_ease_in = "EaseOut",
	-- cursor_blink_ease_out = "Ease",
	cursor_blink_rate = 450,
	default_cursor_style = "BlinkingBar",
	cursor_thickness = "2px",

	enable_kitty_keyboard = true,
	use_fancy_tab_bar = true,
	enable_wayland = true,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = "0px",
		right = "0px",
		top = "0px",
		bottom = "0px",
	},
	keys = mykeys,
}
