local material = {
  "marko-cerovac/material.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.material_style = "darker"
    vim.cmd("colorscheme material")
    vim.cmd("hi CursorLine gui=bold cterm=bold")
  end,
}

return {
  material,
}
