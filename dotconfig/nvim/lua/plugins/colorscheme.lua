local gruvbox_material = {
  "sainnhe/gruvbox-material",
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_cursor = "orange"
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_foreground = "original"
    vim.cmd.colorscheme("gruvbox-material")
  end,
}

return {
  gruvbox_material,
}
