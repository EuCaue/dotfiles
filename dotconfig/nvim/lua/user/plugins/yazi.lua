return {
  "mikavilpas/yazi.nvim",
  cmd = "Yazi",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>fb",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      "<leader>fB",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
    {
      "<leader>-",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = true,
    floating_window_scaling_factor = 1,
    future_features = {
      -- Whether to use `ya emit reveal` to reveal files in the file manager.
      -- Requires yazi 0.4.0 or later (from 2024-12-08).
      ya_emit_reveal = true,

      -- Use `ya emit open` as a more robust implementation for opening files
      -- in yazi. This can prevent conflicts with custom keymappings for the enter
      -- key. Requires yazi 0.4.0 or later (from 2024-12-08).
      ya_emit_open = true,
    },
  },
}
