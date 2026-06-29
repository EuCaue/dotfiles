return {
  enabled = true,
  config = {
    set_dark_mode = function()
      vim.api.nvim_set_option_value("background", "dark", {})
      vim.cmd("colorscheme night-owl")
    end,
    set_light_mode = function()
      vim.api.nvim_set_option_value("background", "light", {})
      vim.cmd("colorscheme light-owl")
    end,
    update_interval = 3000,
    fallback = "dark",
  },
  "f-person/auto-dark-mode.nvim",
}
