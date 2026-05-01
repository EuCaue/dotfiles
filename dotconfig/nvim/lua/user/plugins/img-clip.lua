return {
  "HakonHarnes/img-clip.nvim",
  opts = {
    default = {
      process_cmd = "convert - -quality 80 -", -- compress the image with 85% quality
      show_dir_path_in_prompt = true,
    },
    filetypes = {
      AvanteInput = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
      },
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
    dirs = (function()
      local zk_dir = vim.uv.os_getenv("ZK_NOTEBOOK_DIR")
      if not zk_dir then
        return {}
      end

      return {
        [zk_dir] = {
          file_name = function()
            local time = "-%Y%m%d%H%M%S"
            return vim.fn.expand("%:t:r") .. time
          end,
          dir_path = function()
            return "assets"
          end,
        },
      }
    end)(),
  },
  keys = {
    { "<leader>np", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
