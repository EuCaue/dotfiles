return {
  enabled = false,
  "luckasRanarison/tailwind-tools.nvim",
  lazy = true,
  cmd = {
    "TailwindConcealEnable",
    "TailwindConcealDisable",
    "TailwindConcealToggle",
    "TailwindColorEnable",
    "TailwindColorDisable",
    "TailwindColorToggle",
    "TailwindSort",
    "TailwindSortSelection",
    "TailwindNextClass",
    "TailwindPrevClass",
  },
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  opts = {
    server = {
      override = false,
    },
    document_color = {
      kind = "background",
      --  TODO: change this debounce 
      debounce = 0,
    },
    conceal = {
      enabled = true,
    },
  },
}
