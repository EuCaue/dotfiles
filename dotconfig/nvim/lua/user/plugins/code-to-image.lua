return {
  "mactep/code_to_image.nvim",
  enabled = true,
  build = "bun install", -- needed for `print_method = "browser"`
  opts = {
    debug = true,
    browser = "firefox",
    colors = {
      outline = "#54546d",
      background = "#181616",
      foreground = "#c5c9c5",
    },
  },
  cmd = "CodeToImage",
}
