return {
  "tadmccorkle/markdown.nvim",
  name = "markdown-tools",
  ft = "markdown",
  opts = {
    on_attach = function(bufnr)
      local function toggle(key)
        return "<Esc>gv<Cmd>lua require'markdown.inline'" .. ".toggle_emphasis_visual'" .. key .. "'<CR>"
      end
      vim.keymap.set("x", "<C-b>", toggle("b"), { buffer = bufnr })
      vim.keymap.set("x", "<C-i>", toggle("i"), { buffer = bufnr })
      vim.keymap.set("x", "<C-c>", toggle("c"), { buffer = bufnr })
    end,
  },
}
