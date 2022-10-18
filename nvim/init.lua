require('plugins')
require('mapping')
-- mappingLua = require('mappingLua')
require('settings')
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
-- require("mason").setup()
--require('cmppp')
-- require('lsp')
-- require('lspconfig')
-- require'lspconfig'.setup{}
--require('server')
require('treesitter')
require('coc')
vim.cmd('colorscheme dogrun')
