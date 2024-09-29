return {
  "marko-cerovac/material.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.material_style = "darker"
    local colors = require("material.colors")
    require("material").setup({
      disable = {
        colored_cursor = true,
      },
      contrast = {
        cursor_line = true, -- Enable darker background for the cursor line
        lsp_virtual_text = true, -- Enable contrasted background for lsp virtual text
      },
      custom_highlights = {
        RenderMarkdownH2Bg = { bg = colors.main.blue, fg = colors.main.black },
        RenderMarkdownH4Bg = { bg = colors.main.yellow, fg = colors.main.black },
        RenderMarkdownH5Bg = { bg = colors.main.gray, fg = colors.main.black },
        ["@markup.link.label.markdown_inline"] = { fg = colors.main.orange },
      },
    })
    vim.cmd("colorscheme material-darker")
  end,
}
