local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
	dashboard.button("e", "  New file", "<cmd>new<CR>"),
	dashboard.button("SPC t o", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("SPC g", "  File browser", "<cmd>NvimTreeToggle<CR>"),
	dashboard.button("SPC t p", "  Projects", "<cmd>Telescope project<cr>"),
	dashboard.button("SPC d", "  Dotfiles", "<cmd>cd ~/dotfiles/ | NvimTreeToggle<cr>"),
	dashboard.button("SPC x", "  Neovim config"),
	dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.config)
