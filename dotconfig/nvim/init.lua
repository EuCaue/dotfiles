require("plugins") -- all plugins
require("mapping") -- keybinds
require("settings") -- config
require("Comment").setup({
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}) -- better comment on JSX/TSX
require("linelua") -- status bar config
require("telescopefuzzy") -- telescope config
require("treesitter") -- treesitter config, betterhighlight
require("autopairs") -- auto close ([{)
require("gitsignss") -- git status
require("nvimtree") -- tree file manager
require("termtoggle") -- toggle a terminal inside of neovim
require("dash") -- dashboard
require("autocmd") -- autocmd's
require("wkey")

-- require("mmmason") -- some config for meson
-- require('handlers').setup()
-- CMP + LSP
require("comp") -- CMP
require("auto") -- LSP
require("mason").setup() -- Mason
require("mason-lspconfig").setup() -- Mason LSP Pluggin

require("ls-null") -- global linter
require('nscroll') 
-- VIM
vim.cmd("colorscheme rose-pine") -- colorscheme
vim.cmd('let g:netrw_bufsettings = "noma nomod nonu nowrap ro buflisted"')
