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
    -- require("auto-dark-mode").setup({
    --   set_dark_mode = function()
    --     vim.api.nvim_set_option_value("background", "dark", {})
    --     vim.cmd("colorscheme base16-tomorrow-night")
    --   end,
    --   set_light_mode = function()
    --     vim.api.nvim_set_option_value("background", "light", {})
    --     vim.cmd("colorscheme base16-tomorrow")
    --   end,
    --   update_interval = 10000,
    --   fallback = "light",
    -- })
  end,
}
