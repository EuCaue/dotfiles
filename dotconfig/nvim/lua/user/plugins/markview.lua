return {
  enabled = false,
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  opts = {
    preview = {
      modes = { "n", "x", "v", "no", "c" }, -- Change these modes
      hybrid_modes = { "n" }, -- Uses this feature on
      callbacks = {
        on_enable = function(_, win)
          vim.wo[win].conceallevel = 2
          vim.wo[win].concealcursor = ""
        end,
      },
    },
    markdown = {
      list_items = {
        shift_width = 1,
        indent_size = 1,
      },
    },
  },
}
