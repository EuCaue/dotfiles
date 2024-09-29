return {
  "echasnovski/mini.icons",
  lazy = true,
  version = false,
  enabled = vim.g.have_nerd_font,
  opts = {
    filetype = {
      dotenv = { glyph = "", hl = "MiniIconsYellow" },
    },
  },
  init = function()
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
