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

-- onSave run PackerSync
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local use = packer.use 
packer.reset()
packer.startup(function()
-- PACKER
use 'wbthomason/packer.nvim' -- Plugin Manager	
use 'theRealCarneiro/hyprland-vim-syntax'	

-- Colorscheme
use {'rose-pine/neovim', as = 'rose-pine',} -- Colorscheme
use 'getomni/neovim' -- Omni Colorscheme
use { "ellisonleao/gruvbox.nvim" } -- Gruvbox colorscheme
use 'folke/tokyonight.nvim' -- Colorscheme
use {'dracula/vim',  as = 'dracula' } -- ColorScheme
use {"lunarvim/colorschemes"} -- a bunch of colorschemes
use {'Mofiqul/adwaita.nvim'} -- Adwaita colorScheme
use 'Mofiqul/vscode.nvim' -- Colorscheme

-- BetterComment
use 'preservim/nerdcommenter' -- Comment 
use {'numToStr/Comment.nvim',config = function() require('Comment').setup() end} -- Also Comment
use {'JoosepAlviste/nvim-ts-context-commentstring'} -- Better JSX + TSX comment

-- BetterHighlight
use 'sheerun/vim-polyglot' -- A lot of syntax Highlight 
use 'styled-components/vim-styled-components' -- highlight for styled-components
use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- a better highlight for everything
use { "p00f/nvim-ts-rainbow" } -- {} colored
use {'https://github.com/ap/vim-css-color'} -- CSS Color Preview


-- Snippets
use { "L3MON4D3/LuaSnip"} -- Snippet engine
use {'rafamadriz/friendly-snippets'} -- a lot of snippets
use {'dsznajder/vscode-es7-javascript-react-snippets',run = 'yarn install --frozen-lockfile && yarn compile'}


-- IDE	
-- use 'https://github.com/neoclide/coc.nvim'  -- Auto Completion/Intelisense
use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}} -- Tab/Buffer Manager
use {"neovim/nvim-lspconfig",} -- LSP
use { "kyazdani42/nvim-tree.lua" } -- Tree file
use 'editorconfig/editorconfig-vim' -- Editorconfig
use {'https://github.com/terryma/vim-multiple-cursors'} -- CTRL + N for multiple cursors
use {'ryanoasis/vim-devicons'} -- Developer Icons
use {"windwp/nvim-autopairs"} -- auto close ({[
use {'nvim-lualine/lualine.nvim',requires = { 'kyazdani42/nvim-web-devicons',opt = true }} require('lualine').setup({}) -- status bar 
use { 'windwp/nvim-ts-autotag' } -- <> autoclose tag
use {"lewis6991/gitsigns.nvim", tag = "release"} -- Git





-- Useful
use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } } -- fzf finder
use { 'nvim-lua/popup.nvim' } -- PopUp API for neovim 
use { "akinsho/toggleterm.nvim",} -- show a "portable" terminal
use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", config = function() require("todo-comments").setup {}end
} -- TODO: 
use {'glepnir/dashboard-nvim'} -- dashboard

-- CMP + LSP : 
use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-nvim-lua'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/cmp-cmdline'
use 'hrsh7th/nvim-cmp'
use { "williamboman/mason.nvim" }
use {"saadparwaiz1/cmp_luasnip"}
use {"williamboman/mason-lspconfig.nvim"}
-- use {"jose-elias-alvarez/null-ls.nvim"}
end)


