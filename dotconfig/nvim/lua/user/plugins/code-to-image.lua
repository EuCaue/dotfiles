return {
  "mactep/code_to_image.nvim",
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
