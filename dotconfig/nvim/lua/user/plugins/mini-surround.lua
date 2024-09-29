return {
  "echasnovski/mini.surround",
  version = false,
  opts = {
    search_method = "cover_or_nearest",
  },
  keys = {
    { mode = { "n", "v" }, "sa", desc = "Add surrounding in Normal and Visual modes" }, --
    { "sd", desc = "Delete surrounding" },
    { "sf", desc = "Find surrounding (to the right)" }, --
    { "sF", desc = "Find surrounding (to the left)" }, --
    { "sh", desc = "Highlight surrounding" }, --
    { "sr", desc = "Replace surrounding" }, --
  },
}
