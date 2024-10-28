--  TODO: make this modify the cmp instead  
return {
  "allaman/emoji.nvim",
  ft = "markdown", -- adjust to your needs
  opts = {
    enable_cmp_integration = false,
  },
  keys = {
    {
      "<leader>se",
      "<cmd>Telescope emoji<cr>",
      desc = "Emojis",
    },
  },
}
