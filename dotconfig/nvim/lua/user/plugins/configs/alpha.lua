local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local icons = require("user.utils").icons
local num_plugins_loaded = require("lazy").stats().loaded

local header = {
  " ███╗   ██╗██╗   ██╗██╗███╗   ███╗    ",
  " ████╗  ██║██║   ██║██║████╗ ████║    ",
  " ██╔██╗ ██║██║   ██║██║██╔████╔██║    ",
  " ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║    ",
  " ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║    ",
  " ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝    ",
}

dashboard.section.header.val = header

dashboard.section.buttons.val = {
  dashboard.button("e", icons.ui.file .. "  New file", "<cmd>enew<CR>"),
  dashboard.button(
    "o",
    icons.ui.file .. "  Recent Files",
    "<cmd>Telescope oldfiles<cr>"
  ),
  dashboard.button(
    "f",
    icons.ui.open_folder .. "  Explorer",
    "<cmd>Explore<cr>"
  ),
  dashboard.button(
    "c",
    icons.ui.config .. "  Neovim config",
    "<cmd>e ~/.config/nvim/lua/user/ | cd %:p:h<cr>"
  ),
  dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<cr>"),
  dashboard.button("q", icons.ui.close .. "  Quit NVIM", ":qa<CR>"),
}

local footer = {
  type = "text",
  val = { "⚡" .. num_plugins_loaded .. " plugins loaded." },
  opts = { position = "center", hl = "Comment" },
}

local section = {
  header = dashboard.section.header,
  buttons = dashboard.section.buttons,
  footer = footer,
}

local opts = {
  layout = {
    { type = "padding", val = 8 },
    section.header,
    { type = "padding", val = 2 },
    section.buttons,
    { type = "padding", val = 1 },
    section.bottom_section,
    { type = "padding", val = 1 },
    section.footer,
  },
}

alpha.setup(opts)
