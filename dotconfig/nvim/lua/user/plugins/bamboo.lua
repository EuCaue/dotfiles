return {
  "ribru17/bamboo.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("bamboo").setup({
      lualine = {
        transparent = true, -- lualine center bar transparency
      },
    })
    require("bamboo").load()
  end,
}
