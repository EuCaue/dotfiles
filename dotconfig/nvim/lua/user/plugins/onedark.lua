return {
  "navarasu/onedark.nvim",
  name = "onedark",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "dark",
      transparent = false,
      term_colors = true,
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },
    })
    require("onedark").load()
  end,
}
