local material = {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material-darker",
    },
  },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.material_style = "darker"
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
    lazy = false,
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
