return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  ft = { "markdown" },
  cmd = "RenderMarkdown",
  opts = {
    file_types = { "markdown" },
    render_modes = { "n", "c", "x", "v", "no" },
    quotes = {
      repeat_linebreak = true,
    },
    checkbox = {
      unchecked = {
        icon = " ",
      },
      checked = {
        icon = " ",
      },
      custom = {
        cancelled = { raw = "[~]", rendered = " ", highlight = "DiagnosticError" },
        todo = { rendered = "󱉺 ", highlight = "RenderMarkdownMath" },
        doing = { raw = "[>]", rendered = "󱉺 ", highlight = "RenderMarkdownMath" },
      },
    },
    link = {
      email = "󰀆 ",
      hyperlink = "󰴜 ",
      custom = {
        web = { icon = "󰾔 " },
      },
    },
    code = {
      position = "right",
      width = "block",
      right_pad = 10,
    },
    win_options = {
      conceallevel = {
        rendered = 2,
      },
    },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  keys = {
    { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "toggle markdown rendering" },
  },
}
