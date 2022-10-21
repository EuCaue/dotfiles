packer = require 'packer'
packer.init {
	display = {
		prompt_border = 'double', -- Border style of prompt popups
		show_all_info = true, -- Should packer show all update details auto? 
		header_sym = '--', -- the symbol for the header line in packer's display
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	}
}


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local use = packer.use 
packer.reset()
packer.startup(function()
use 'wbthomason/packer.nvim' -- Plugin Manager	

use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
use 'getomni/neovim' -- Omni Colorscheme
use { "ellisonleao/gruvbox.nvim" } -- Gruvbox colorscheme
use 'editorconfig/editorconfig-vim' -- Editorconfig
use 'sheerun/vim-polyglot' -- A lot of syntax Highlight 
use 'folke/tokyonight.nvim' -- Colorscheme
use 'preservim/nerdcommenter' -- Comment auto
use 'https://github.com/neoclide/coc.nvim'  -- Auto Completion
use {'https://github.com/ap/vim-css-color'} -- CSS Color Preview
use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
use {'ryanoasis/vim-devicons'} -- Developer Icons
use {'https://github.com/terryma/vim-multiple-cursors'} -- CTRL + N for multiple cursors
use {'dracula/vim',  as = 'dracula' } -- ColorScheme
use {"windwp/nvim-autopairs"}
use {'rose-pine/neovim', as = 'rose-pine',}
use {'dsznajder/vscode-es7-javascript-react-snippets',run = 'yarn install --frozen-lockfile && yarn compile'}
use {'Mofiqul/adwaita.nvim'} -- Adwaita colorScheme
use {'nvim-lualine/lualine.nvim',requires = { 'kyazdani42/nvim-web-devicons',opt = true }} require('lualine').setup({}) -- status bar 
use {'numToStr/Comment.nvim',config = function() require('Comment').setup() end} -- Also Comment
use {'JoosepAlviste/nvim-ts-context-commentstring'} -- Comments
-- Better Syntax Highlight
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
use 'styled-components/vim-styled-components'
-- Better Syntax Highlight
use 'Mofiqul/vscode.nvim'
use {"lunarvim/colorschemes"} -- a bunch of colorschemes
use { 'windwp/nvim-ts-autotag' }
use {"neovim/nvim-lspconfig",}
use {'rafamadriz/friendly-snippets'}
use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
use { 'nvim-lua/popup.nvim' } -- PopUp API for neovim 
use { "p00f/nvim-ts-rainbow" } -- {} colored
use {"lewis6991/gitsigns.nvim", tag = "release"} -- Git
use { "kyazdani42/nvim-tree.lua" } -- Tree file
use { "akinsho/toggleterm.nvim",} -- show a "portable" terminal
use { "L3MON4D3/LuaSnip"}


-- use 'hrsh7th/cmp-nvim-lsp'
-- use 'hrsh7th/cmp-nvim-lua'
-- use 'hrsh7th/cmp-buffer'
-- use 'hrsh7th/cmp-path'
-- use 'hrsh7th/cmp-cmdline'
-- use 'hrsh7th/nvim-cmp'
-- use { "williamboman/mason.nvim" }
-- use {"saadparwaiz1/cmp_luasnip"}
-- use {"williamboman/mason-lspconfig.nvim"}
-- use {"jose-elias-alvarez/null-ls.nvim"}
end)


