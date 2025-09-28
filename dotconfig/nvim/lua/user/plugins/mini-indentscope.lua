return {
  "nvim-mini/mini.indentscope",
  version = false,
  event = "BufReadPost",
  opts = {
    symbol = require("user.core.icons").ui.BoldLineLeft,
    options = { try_as_border = true  },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "alpha",
        "dashboard",
        "fzf",
        "help",
        "lazy",
        "mason",
        "notify",
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
