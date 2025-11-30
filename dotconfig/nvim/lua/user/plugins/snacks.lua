local dim_enabled = false
return {
  event = "VimEnter",
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>i",
      function()
        Snacks.config.style("zoom_indicator", {
          row = vim.api.nvim_win_get_height(0) - 2,
        })
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>tz",
      function()
        Snacks.config.style("zoom_indicator", {
          row = vim.api.nvim_win_get_height(0) - 2,
        })
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>tD",
      function()
        if dim_enabled then
          Snacks.dim.disable()
          dim_enabled = false
          return
        end
        Snacks.dim.enable()
        dim_enabled = true
      end,
      desc = "Toggle Dim",
    },
    {
      "<leader>o",
      ft = { "txt", "markdown" },
      '<cmd>lua require("snacks").image.hover()<cr>',
      desc = "Preview image under cursor",
    },
  },
  ---@type snacks.Config
  opts = {
    image = {
      enabled = true,
      doc = {
        enabled = false,
        inline = false,
      },
    },
    dim = { enabled = true },
    zen = {
      enabled = true,
    },
    bigfile = {
      enabled = true,
    },
  },
}
