return {
  "sainnhe/gruvbox-material",
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_background = "hard"
    vim.g.gruvbox_material_better_performance = 1
    vim.g.gruvbox_material_ui_contrast = "high"
    vim.g.gruvbox_material_foreground = "original"
    vim.g.gruvbox_material_transparent_background = 0
    vim.cmd.colorscheme("gruvbox-material")
    -- if vim.bo.filetype then
    --   vim.cmd("RenderMarkdown disable")
    --   vim.opt_local.spell = false
    --   _P("here")
    --   vim.cmd("hi markdownUrl guifg=Normal")
    --   vim.cmd("hi markdownH1 guifg=Normal")
    --   vim.cmd("hi markdownH2 guifg=Normal")
    --   vim.cmd("hi markdownH3 guifg=Normal")
    --   vim.cmd("hi markdownH4 guifg=Normal")
    --   vim.cmd("hi markdownH5 guifg=Normal")
    --   vim.cmd("hi markdownLinkText guifg=Normal")
    -- end
  end,
}
