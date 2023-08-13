local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
  vim.notify("Plugin alpha not found", "error")
  return
end
local dashboard = require("alpha.themes.dashboard")
local icons = require("user.utils").icons
local utils = require("user.utils")

dashboard.section.buttons.val = {
  dashboard.button("e", icons.ui.file .. "  New file", "<cmd>enew<CR>"),
  dashboard.button("SPC f o", icons.ui.files .. "  Recent Files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("SPC f f", icons.ui.open_folder .. "  Find Files", "<cmd>Telescope find_files<cr>"),
  dashboard.button("SPC f p", icons.ui.project_folder .. "  Projects", "<cmd>Telescope project<cr>"),
  dashboard.button(
    "SPC s s",
    icons.ui.restore .. "  Restore Last Session",
    "<cmd>SessionManager load_last_session<cr>"
  ),
  dashboard.button("c", icons.ui.config .. "  Neovim config", "<cmd>e ~/.config/nvim/lua/user/ | cd %:p:h<cr>"),
  dashboard.button("q", icons.ui.close .. "  Quit NVIM", ":qa<CR>"),
}

  local datetime = os.date(" %H:%M. ")
local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath("data") .. "/lazy", "*", 0, 1)

local footer = {
  type = "text",
  val = { num_plugins_loaded .. " plugins 󰚥 installed" },
  opts = { position = "center", hl = "Comment" },
}

local bottom_section = {
  type = "text",
  val = "Hi " .. utils.get_user() .. "," .. " It's" .. datetime .. "How are you doing today?",
  opts = {
    position = "center",
  },
}

local section = {
  header = dashboard.section.header,
  bottom_section = bottom_section,
  buttons = dashboard.section.buttons,
  footer = footer,
}

local opts = {
  layout = {
    { type = "padding", val = 2 },
    section.header,
    { type = "padding", val = 2 },
    section.buttons,
    section.bottom_section,
    section.footer,
  },
}

alpha.setup(opts)
