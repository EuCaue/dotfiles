return {
  enabled = false,
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  opts = {
    modes = { "n", "x", "v", "no", "c" }, -- Change these modes
    hybrid_modes = { "n" }, -- Uses this feature on
    list_items = {
      shift_width = 1,
      indent_size = 1,
    },
    callbacks = {
      on_enable = function(_, win)
        vim.wo[win].conceallevel = 2
        vim.wo[win].concealcursor = ""
      end,
    },
  },
}
