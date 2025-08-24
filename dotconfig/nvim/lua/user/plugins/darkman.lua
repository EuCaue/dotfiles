return {
  "4e554c4c/darkman.nvim",
  event = "VimEnter",
  build = "go build -o bin/darkman.nvim",
  opts = {
    colorscheme = { dark = "base16-tomorrow-night", light = "base16-tomorrow" },
  },
}
