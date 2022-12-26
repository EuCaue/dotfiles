-- Autoformat
vim.cmd[[
augroup _lsp
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.format { async = true}
augroup end
]]


