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
      home = vim.fn.getenv("HOME") .. "/Code/leetcode",
    },
    hooks = {
      ---@type fun()[]
      ["question_enter"] = {
        function()
          vim.cmd("wincmd h")
          vim.cmd("set wrap")
          vim.cmd("wincmd l")
          vim.keymap.set("n", "<leader>clr", "<cmd>Leet run<cr>", { desc = "run leetcode answer" })
          vim.keymap.set("n", "<leader>cls", "<cmd>Leet submit<cr>", { desc = "submit leetcode answer" })
        end,
      },
    },
    description = {
      width = "35%",
    },
    image_support = false,
  },
}
