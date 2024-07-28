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
      require("material").setup({
        contrast = {
          cursor_line = true, -- Enable darker background for the cursor line
          lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
        },
        high_visibility = {
          darker = true, -- Enable higher contrast text for darker style
        },
      })
      vim.cmd("colorscheme material-darker")
    end,
  },
}

local night = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "night-owl",
    },
  },
  {
    "oxfist/night-owl.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      require("night-owl").setup()
      vim.cmd.colorscheme("night-owl")
    end,
  },
}

return {
  material,
  night,
}
