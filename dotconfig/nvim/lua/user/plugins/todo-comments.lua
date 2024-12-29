return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoFzfLua" },
  event = "BufReadPost",
  opts = {},
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    -- { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    -- { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Todo" },
    { "<leader>sT", "<cmd>TodoFzfLua keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}
