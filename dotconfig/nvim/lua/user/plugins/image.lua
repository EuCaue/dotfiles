return {
  {
    lazy = true,
    enabled = true,
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    enabled = true,
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    opts = {},
    cmd = "RenderImage",
  },
}
