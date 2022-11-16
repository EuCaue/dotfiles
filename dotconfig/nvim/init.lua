require("user.plugins") -- all plugins
require("user.mapping") -- keybinds
require("user.settings") -- config
require("user.lualine") -- status bar config
require("user.telescope") -- telescope config
require("user.treesitter") -- treesitter config, betterhighlight
require("user.autopairs") -- auto close ([{)
require("user.gitsigns") -- git status
require("user.nvimtree") -- tree file manager
require("user.toggleterm") -- toggle a terminal inside of neovim
require("user.dashboard") -- dashboard
require("user.autocmd") -- autocmd's
require("user.whichkey")
require "user.scrollbar"

-- CMP + LSP
require("user.cmp") -- CMP
require("user.lsp") -- LSP
require("mason").setup() -- Mason
require("mason-lspconfig").setup() -- Mason LSP Pluggin

require("user.null-ls") -- global linter
require("user.neoscroll")
-- VIM
vim.cmd("colorscheme rose-pine") -- colorscheme
vim.cmd('let g:netrw_bufsettings = "noma nomod nonu nowrap ro buflisted"')
