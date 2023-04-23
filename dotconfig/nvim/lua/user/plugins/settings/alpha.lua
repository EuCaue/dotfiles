local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	vim.notify("Plugin alpha not found", "error")
	return
end
local dashboard = require("alpha.themes.dashboard")
local icons = require("user.utils").icons

dashboard.section.buttons.val = {
	dashboard.button("e", icons.ui.file .. "  New file", "<cmd>new<CR>"),
	dashboard.button("SPC f o", icons.ui.files .. "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("SPC f f", icons.ui.open_folder .. "  Find Files", "<cmd>Telescope find_files<cr>"),
	dashboard.button("SPC f p", icons.ui.project_folder .. "  Projects", "<cmd>Telescope project<cr>"),
	dashboard.button(
		"SPC s s",
		icons.ui.restore .. "  Restore Last Session",
		"<cmd>SessionManager load_last_session<cr>"
	),
	dashboard.button("c", icons.ui.config .. "  Neovim config", "<cmd>e ~/.config/nvim/lua/user/ | cd %:p:h<cr>"),
	dashboard.button(
		"p",
		icons.ui.config .. "  Plugin config",
		"<cmd>e ~/.config/nvim/lua/user/plugins/ | cd %:p:h<cr>"
	),
	dashboard.button("q", icons.ui.close .. "  Quit NVIM", ":qa<CR>"),
}

local datetime = os.date("  %H:%M ")
local bottom_section = {
	type = "text",
	val = icons.ui.arrow_right .. datetime .. icons.ui.arrow_left,
	opts = {
		position = "center",
	},
}

local section = {
	header = dashboard.section.header,
	bottom_section = bottom_section,
	buttons = dashboard.section.buttons,
}

local opts = {
	layout = {
		{ type = "padding", val = 2 },
		section.header,
		{ type = "padding", val = 2 },
		section.buttons,
		section.bottom_section,
	},
}

alpha.setup(opts)
