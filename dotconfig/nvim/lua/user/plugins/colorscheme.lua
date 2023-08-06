local utils = require("user.utils")

local onedark = {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("onedark").setup({
      transparent = (utils.get_transparency_value() == "true"),
      lualine = {
        transparent = true,                                                                              -- lualine center bar transparency
      },
      style = "deep",                                                                                    -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      colors = { bg0 = "#000000", bg1 = "#000000", bg2 = "#101010", bg3 = "#1e1e1e", bg_d = "#000000" }, -- Override default colors
      diagnostics = {
        darker = true,                                                                                   -- darker colors for diagnostic
        undercurl = true,                                                                                -- use undercurl instead of underline for diagnostics
        background = true,                                                                               -- use background color for virtual text
      },
      code_style = {
        comments = "italic",
        keywords = "italic",
        functions = "none",
        strings = "italic",
        variables = "none",
      },
    })
    vim.cmd([[colorscheme onedark]])
  end,
}


return {
  onedark,
}
