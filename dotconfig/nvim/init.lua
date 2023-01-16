require("user.mapping") -- keybinds
require("user.settings") -- config
require("user.lazy") -- lazy
require("user.rosepine") -- colorscheme
require("user.lualine") -- status bar config
require("user.telescope") -- telescope config
require("user.treesitter") -- treesitter config, betterhighlight
require("user.autopairs") -- auto close ([{)
require("user.gitsigns") -- git status
require("user.nvimtree") -- tree file manager
require("user.toggleterm") -- toggle a terminal inside of neovim
require("user.autocmd") -- autocmd's
require("user.comment") -- comment
require("user.whichkey") -- whichkey
require("user.scrollbar") -- scrollbar
require("user.cmp") -- CMP
require("user.lsp") -- LSP
require("user.mason") -- Mason
require("user.null-ls") -- Global linter
require("user.neoscroll") -- Neoscroll
require("user.bufferline") -- tabs
require("user.navic") --
require("user.indent-blankline") --
require("user.alpha")
require("user.lir")
require("user.cursorline")
require("user.lightbulb")
-- require("user.barbecue")
require("user.colorizer")
require("user.auto-hlsearch")
require("user.nvim-cursorline")
require("user.symbols-outline")

require("fidget").setup({})
-- vim.notify = require("notify")
require("notify").setup({
	timeout = 1000,
	render = "minimal",
})
require("luasnip").filetype_extend("typescript", { "css" })
