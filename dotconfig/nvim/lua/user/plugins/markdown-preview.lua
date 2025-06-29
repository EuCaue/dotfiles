return {
  "iamcco/markdown-preview.nvim",
  -- ft = "markdown",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = function()
    require("lazy").load({ plugins = { "markdown-preview.nvim" } })
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
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_auto_start = 1
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview_auto_refresh = 1
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_highlight_css = vim.uv.os_homedir() .. "/dotfiles/dotconfig/highlight.css"
    vim.g.mkdp_open_ip = "localhost"
    vim.g.mkdp_open_to_the_world = 1
    local last_previewed_md = nil
    local initialized = false
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.md",
      callback = function()
        local current = vim.fn.expand("%:p")

        if not initialized then
          initialized = true
          last_previewed_md = current
          return
        end

        if last_previewed_md ~= current then
          vim.cmd("silent! MarkdownPreview")
          last_previewed_md = current
        end
      end,
    })
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
