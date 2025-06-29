return {
  "RRethy/base16-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("user.core.helpers").apply_theme_by_system_mode({
      dark = function()
       vim.cmd("colorscheme base16-tomorrow-night")
      end,
      light = function()
        vim.cmd("colorscheme base16-tomorrow")
      end,
    })
  end,
}
