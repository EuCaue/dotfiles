require('plugins')
require('mapping')
require('settings')
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
require('linelua')
require('telescopefuzzy')
require('treesitter')
require('coc')
require('autopairs')
require('gitsignss')
require('nvimtree')
require('termtoggle')
vim.cmd('colorscheme adwaita')
