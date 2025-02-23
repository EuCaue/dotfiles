return {
  "marko-cerovac/material.nvim",
  enabled = false,
  lazy = false,
  priority = 1000,
  config = function()
    local styles = { "lighter", "darker", "deep ocean", "oceanic", "palenight" }
    vim.api.nvim_create_user_command("MaterialStyle", function(data)
      local style = data.args
      if vim.tbl_contains(styles, style, {}) then
        if style == "lighter" then
          vim.o.background = "light"
        else
          vim.o.background = "dark"
        end
        require("material.functions").change_style(style)
      end
    end, {
      nargs = "*",
      complete = function()
        return styles
      end,
    })

    local color_scheme = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")
    color_scheme = color_scheme:gsub("%s+", "")
    color_scheme = color_scheme:gsub("\n", "")
    if color_scheme == "'prefer-dark'" then
      vim.g.material_style = "darker"
    else
      vim.g.material_style = "lighter"
    end
    local colors = require("material.colors")
    require("material").setup({
      high_visibility = {
        lighter = true, -- Enable higher contrast text for lighter style
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
    vim.cmd("colorscheme material")
  end,
}
