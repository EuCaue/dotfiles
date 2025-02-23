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
    opts = {
      backend = "kitty",
      processor = "magick_rock", -- or "magick_cli"
      editor_only_render_when_focused = true,
    },
    cmd = "RenderImage",
  },
}
