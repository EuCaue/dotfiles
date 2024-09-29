return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    {
      "<leader>fs",
      function()
        require("persistence").select()
      end,
      desc = "Find Session",
    },
  },
}
