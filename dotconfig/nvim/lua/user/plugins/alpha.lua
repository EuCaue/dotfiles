local icons = require("user.core.icons")

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = require("user.core.ascii-headers").arts[24]
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
      -- button("f", icons.ui.Files .. " Find file", "<cmd>Telescope find_files<cr>"),
      -- button("n", icons.ui.NewFile .. " New file", "<cmd>ene <BAR> startinsert<cr>"),
      -- button("o", icons.ui.History .. " Old files", "<cmd>Telescope oldfiles<cr>"),
      -- button("z", icons.ui.BookMark .. " Zoxide", "<cmd>Telescope zoxide list<cr>"),
      button("f", icons.ui.Files .. " Find file", "<cmd>FzfLua files<cr>"),
      button("n", icons.ui.NewFile .. " New file", "<cmd>ene <BAR> startinsert<cr>"),
      button("o", icons.ui.History .. " Old files", "<cmd>FzfLua oldfiles<cr>"),
      button("z", icons.ui.BookMark .. " Zoxide", "<cmd>FzfLua zoxide<cr>"),
      button("s", icons.misc.RestoreSession .. " Restore Session", [[<cmd> lua require("persistence").load()<cr>]]),
      button("c", icons.ui.Gear .. " Config", "<cmd>FzfLua files cwd=$HOME/.config/nvim<cr>"),
      button("l", icons.misc.Lazy .. " Lazy", "<cmd>Lazy<cr>"),
      button("q", icons.ui.SignOut .. " Quit", "<cmd>qa!<cr>"),
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
