return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  keys = {
    { "<leader>ti", "<cmd>IBLToggle<cr>", desc = "toggle indent blankline" },
  },
  opts = function()
    local icons = require("user.core.icons")
    return {
      indent = {
        char = icons.ui.BoldLineMiddle,
        tab_char = icons.ui.BoldLineMiddle,
      },
      scope = { show_start = false, show_end = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "lazy",
          "mason",
        },
      },
    }
  end,
  main = "ibl",
}
