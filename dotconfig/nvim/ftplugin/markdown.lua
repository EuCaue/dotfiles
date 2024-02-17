local root_dir = vim.fn.getcwd()
if root_dir.match(root_dir, "/home/caue/Documents/vault/") then
  vim.cmd("set spell")
  vim.cmd("set spelllang=en_us,pt_br")
end

vim.keymap.set(
  "n",
  "<leader>mp",
  "<cmd>MarkdownPreview<cr>",
  { noremap = true, silent = true, desc = "Markdown Preview" }
)
