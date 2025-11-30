return {
  "4e554c4c/darkman.nvim",
  event = "VimEnter",
  build = "go build -o bin/darkman.nvim",
  opts = {
    change_background = true,
    send_user_event = false,
    colorscheme = { dark = "base16-tomorrow-night", light = "base16-tomorrow" },
  },
}
