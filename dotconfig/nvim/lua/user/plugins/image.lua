return {
  {
    lazy = true,
    enabled = false,
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    enabled = false,
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    opts = {},
    cmd = "RenderImage",
  },
}
