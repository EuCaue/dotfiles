return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local icons = require("user.core.icons")
    local pad = require("user.core.helpers").padding
    local dashboard = require("alpha.themes.dashboard")
    local logo = require("user.core.ascii-headers").get_arts(8)
    local button_width = math.floor(#logo[1] / 3)
    if button_width < 25 then
      button_width = math.floor(#logo[1])
    end

    local function button(sc, txt, keybind, keybind_opts)
      local b = dashboard.button(sc, txt, keybind, keybind_opts)
      b.opts.width = button_width
      b.opts.cursor = 3
      b.opts.hl_shortcut = "Include"
      b.opts.hl = "Define"
      return b
    end

    table.insert(dashboard.opts.layout, 5, { type = "padding", val = 2 })
    local win_height = vim.api.nvim_win_get_height(0)
    local logo_height = #logo
    local padding = math.floor((win_height - logo_height) / 2)
    dashboard.opts.layout[1].val = math.floor(padding * 0.75)
    dashboard.section.header.val = logo
    dashboard.section.header.opts.hl = "Define"
    dashboard.section.buttons.val = {
      button("f", pad(icons.ui.Files, 0, 2) .. "Find file", "<cmd>FzfLua files<cr>"),
      button("n", pad(icons.ui.NewFile, 0, 2) .. "New file", "<cmd>ene <BAR> startinsert<cr>"),
      button("v", pad(icons.ui.Note, 0, 2) .. "Vault", "<cmd>ZkNotes<cr>"),
      button("o", pad(icons.ui.History, 0, 2) .. "Old files", "<cmd>FzfLua oldfiles<cr>"),
      button("z", pad(icons.ui.BookMark, 0, 2) .. "Zoxide", "<cmd>FzfLua zoxide<cr>"),
      button(
        "s",
        pad(icons.misc.RestoreSession, 0, 2) .. "Restore Session",
        [[<cmd> lua require("persistence").load()<cr>]]
      ),
      button("c", pad(icons.ui.Gear, 0, 2) .. "Config", "<cmd>FzfLua files cwd=$HOME/.config/nvim<cr>"),
      button("l", pad(icons.misc.Lazy, 0, 2) .. "Lazy", "<cmd>Lazy<cr>"),
      button("q", pad(icons.ui.SignOut, 0, 2) .. "Quit", "<cmd>qa!<cr>"),
    }
    dashboard.section.buttons.opts.spacing = 0
    dashboard.section.footer.opts.hl = "Question"
    dashboard.section.footer.val = "hi :)"
    return dashboard
  end,
  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)
  end,
}
