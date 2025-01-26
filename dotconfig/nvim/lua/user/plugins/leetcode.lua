return {
  "kawre/leetcode.nvim",
  cmd = "Leet",
  build = ":TSUpdate html",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    arg = "leet",
    lang = "typescript",
    storage = {
      home = vim.fn.getenv("HOME") .. "/Code/leetcode"
    },
    description = {
      width = "35%",
    },
    image_support = true,
  },
}
