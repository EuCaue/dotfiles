return {
  "iamcco/markdown-preview.nvim",
  ft = "markdown",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.cmd([[do FileType]])
    vim.cmd([[
      function OpenMarkdownPreview (url)
      let cmd = "epiphany " . shellescape(a:url) . " &"
      silent call system(cmd)
      silent call setreg('+', a:url)
      endfunction
      ]])
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_port = "2512"
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview_auto_refresh = 1
    vim.g.mkdp_open_ip = "localhost"
    vim.g.mkdp_open_to_the_world = 1
    vim.g.mkdp_echo_preview_url = 1
    -- vim.g.mkdp_highlight_css = "/home/caue/dotfiles/dotconfig/highlight.css"
  end,
  keys = {
    {
      "<leader>cp",
      ft = "markdown",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Markdown Preview",
    },
  },
}
