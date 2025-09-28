return {
  "mactep/code_to_image.nvim",
  commit = "6acc5c4988398588213e953836b1c65ca5ff82ac",
  enabled = true,
  build = "bun install", -- needed for `print_method = "browser"`
  opts = {
    debug = true,
    browser = "firefox",
    font = {
      family = vim.fn
        .system("ghostty +show-config | rg 'font-family' | awk -F= '{print $2}' | head -1")
        :gsub("\n", "")
        :match("^%s*(.-)%s*$"),
    },
  },
  cmd = "CodeToImage",
}
