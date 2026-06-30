return {
  "oxfist/night-owl.nvim",
  dir = vim.fn.expand("$HOME") .. "/gitclone/night-owl.nvim",
  name = "night-owl",
  priority = 1000,
  config = function()
    require("night-owl").setup()
  end,
}
