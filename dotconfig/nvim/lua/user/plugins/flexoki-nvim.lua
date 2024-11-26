return {
  "nuvic/flexoki-nvim",
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    require("flexoki").setup({
      variant = "auto", -- auto, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
      },
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
    })
    vim.cmd("colorscheme flexoki")
  end,
}
