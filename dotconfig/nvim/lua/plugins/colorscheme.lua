local material = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material-darker",
    },
  },
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.material_style = "darker"
      vim.cmd("colorscheme material")
    end,
  },
}

local t = {
  "dasupradyumna/midnight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Lua
    require("midnight").setup({
      LspInlayHint = {
        link = "Namespace",
      },
    })
    vim.cmd.colorscheme("midnight")
  end,
}

local ever = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everblush",
    },
  },
  {
    "Everblush/nvim",
    name = "everblush",
    config = function()
      require("everblush").setup({
        override = {
          IblIndent = { fg = "comment" },
        },
      })
      vim.cmd("colorscheme everblush")
    end,
  },
}

return {
  ever,
}
