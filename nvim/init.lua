require('plugins') -- all plugins
require('mapping') -- keybinds
require('settings') -- config
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
} -- better comment on JSX/TSX


require('linelua') -- status bar config
require('telescopefuzzy') -- telescope config
require('treesitter') -- treesitter config, betterhighlight
require('coc') -- coc keybinds + autocompletion
require('autopairs') -- auto close ([{)
require('gitsignss') -- git status 
require('nvimtree') -- tree file manager
require('termtoggle') -- toggle a terminal inside of neovim
require('dash') -- dashboard
require('autocmd') -- autocmd's
vim.cmd('colorscheme rose-pine') -- colorscheme 
vim.cmd('let g:netrw_bufsettings = "noma nomod nonu nowrap ro buflisted"')
