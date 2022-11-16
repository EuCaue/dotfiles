local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

-- Autoformat
vim.cmd[[
augroup _lsp
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.format { async = true}
augroup end
]]


local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)
