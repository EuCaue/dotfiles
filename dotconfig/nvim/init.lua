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
require("user.whichkey") -- whichkey
require("user.scrollbar") -- scrollbar
require("user.cmp") -- CMP
require("user.lspsaga") -- LSP SAGA
require("user.lsp") -- LSP
require("user.mason") -- Mason
require("user.null-ls") -- Global linter
require("user.neoscroll") -- Neoscroll
require("user.barbar") -- barbar

-- VIM
vim.cmd("colorscheme rose-pine") -- colorscheme
vim.cmd('let g:netrw_bufsettings = "noma nomod nonu nowrap ro buflisted"')
