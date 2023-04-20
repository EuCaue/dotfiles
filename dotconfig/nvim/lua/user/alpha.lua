local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", "<cmd>new<CR>"),
  dashboard.button("SPC f o", "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("SPC f f", "  Find Files", "<cmd>Telescope find_files<cr>"),
  dashboard.button("SPC f b", "  File browser", "<cmd>Telescope file_browser<CR>"),
  dashboard.button("SPC f p", "  Projects", "<cmd>Telescope project<cr>"),
  dashboard.button("SPC s s", "  Restore Last Session", "<cmd>SessionManager load_last_session<cr>"),
  dashboard.button("c", "  Neovim config", "<cmd>e $MYVIMRC | cd %:p:h<cr>"),
  dashboard.button("p", "  Plugin config", "<cmd>e ~/.config/nvim/lua/user/plugins.lua | cd %:p:h<cr>"),
  dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.config)
