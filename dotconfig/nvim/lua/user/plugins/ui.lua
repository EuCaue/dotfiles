return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("user.plugins.settings.lualine")
    end,
  }, -- Status Bar

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  }, -- LSP progress

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("user.plugins.settings.alpha")
    end,
    cmd = "Alpha",
  }, -- Splash Screen

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  }, -- better ui

  {
    "echasnovski/mini.indentscope",
    event = "BufReadPost",
    version = false,
    opts = {
      symbol = "│",
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  }, -- icons

  -- ui components
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-lua/popup.nvim", lazy = true }, -- PopUp API for neovim
}
