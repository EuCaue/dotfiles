return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  cmd = "VenvSelect",
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
  },
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
}
