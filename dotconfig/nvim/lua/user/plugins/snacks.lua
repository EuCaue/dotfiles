local dim_enabled = false
return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>i",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>tz",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
    {
      "<leader>tZ",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen mode",
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
      "<leader>k",
      ft = { "txt", "markdown" },
      function()
        Snacks.image.hover()
      end,
      desc = "Preview image under cursor",
    },
  },
  ---@type snacks.Config
  opts = {
    image = { enabled = true },
    dim = { enabled = true },
    zen = {enabled=true},
    bigfile = {
      enabled = true,
    },
  },
}
