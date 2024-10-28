return {
  "gaoDean/autolist.nvim",
  enabled = false,
  ft = { "markdown", "text" },
  opts = {},
  cmd = {
    "AutolistRecalculate",
    "AutolistNewBullet",
    "AutolistNewBulletBefore",
  },
  keys = {
    {
      mode = "i",
      "<c-t>",
      "<c-t><cmd>AutolistRecalculate<cr>",
      ft = { "markdown", "text" },
    },
    {
      mode = "i",
      "<CR>",
      "<CR><cmd>AutolistNewBullet<cr>",
      ft = { "markdown", "text" },
    },
    {
      mode = "n",
      "o",
      "o<cmd>AutolistNewBullet<cr>",
      ft = { "markdown", "text" },
    },

    {
      mode = "n",
      "O",
      "O<cmd>AutolistNewBulletBefore<cr>",
      ft = { "markdown", "text" },
    },
    {
      mode = "n",
      ">>",
      ">><cmd>AutolistRecalculate<cr>",
      ft = { "markdown", "text" },
    },
    {
      mode = "n",
      "<<",
      "<<<cmd>AutolistRecalculate<cr>",
      ft = { "markdown", "text" },
    },
    {
      mode = "n",
      "dd",
      "dd<cmd>AutolistRecalculate<cr>",
      ft = { "markdown", "text" },
    },
    {
      mode = "v",
      "d",
      "d<cmd>AutolistRecalculate<cr>",
      ft = { "markdown", "text" },
    },
  },
}
