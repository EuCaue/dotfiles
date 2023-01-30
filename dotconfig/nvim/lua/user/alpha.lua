local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", "<cmd>new<CR>"),
	dashboard.button("SPC t o", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("SPC t f", "  Find Files", "<cmd>Telescope find_files<cr>"),
	dashboard.button("SPC g", "  File browser", "<cmd>Telescope file_browser<CR>"),
	dashboard.button("SPC t p", "  Projects", "<cmd>Telescope project<cr>"),
	dashboard.button("SPC d", "  Dotfiles", "<cmd>cd ~/dotfiles/ | NvimTreeToggle<cr>"),
	dashboard.button(
		"c",
		"  Neovim config",
		"<cmd>cd ~/dotfiles/dotconfig/nvim/ | e ~/dotfiles/dotconfig/nvim/init.lua<cr>"
	),
	dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.config)
