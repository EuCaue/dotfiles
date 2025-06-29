return {
  "HakonHarnes/img-clip.nvim",
  opts = {
    default = {
      process_cmd = "convert - -quality 80 -", -- compress the image with 85% quality
      show_dir_path_in_prompt = true,
    },
    files = {
      ["README.md"] = {
        dir_path = "./",
        file_name = "app.png",
      },
      ["readme.md"] = {
        dir_path = "./",
        file_name = "app.png",
      },
    },
    dirs = {
      ["$ZK_NOTEBOOK_DIR"] = {
        file_name = function()
          local time = "-%Y%m%d%H%M%S"
          return vim.fn.expand("%:t:r") .. time
        end,
        dir_path = function()
          return "assets"
        end,
      },
    },
  },
  keys = {
    { "<leader>np", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
