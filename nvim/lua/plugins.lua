packer = require 'packer'
packer.init {
	display = {
		prompt_border = 'double', -- Border style of prompt popups
		show_all_info = true, -- Should packer show all update details auto? 
		header_sym = '--', -- the symbol for the header line in packer's display
	}
}


local use = packer.use 
packer.reset()
packer.startup(function()
-- use "amarakon/nvim-cmp-fonts"

use 'wbthomason/packer.nvim' -- Plugin Manager	
--use 'neovim/nvim-lspconfig'
use 'tiagofumo/vim-nerdtree-syntax-highlight' -- NerdTree Syntax
use { 'kartikp10/noctis.nvim', requires = { 'rktjmp/lush.nvim' } }
use 'getomni/neovim'
use 'editorconfig/editorconfig-vim' -- Editorconfig
use "EdenEast/nightfox.nvim" -- Packer
use 'sheerun/vim-polyglot' -- A lot of syntax Highlight 
use 'folke/tokyonight.nvim' -- Colorscheme
use 'preservim/nerdcommenter' -- Comment auto
use 'https://github.com/neoclide/coc.nvim'  -- Auto Completion
use 'https://github.com/ap/vim-css-color' -- CSS Color Preview
use 'https://github.com/preservim/nerdtree' -- Tree File
use {
  'romgrk/barbar.nvim',
  requires = {'kyazdani42/nvim-web-devicons'}
}
use 'ryanoasis/vim-devicons' -- Developer Icons
use 'https://github.com/tc50cal/vim-terminal' -- Vim Terminal
use 'https://github.com/terryma/vim-multiple-cursors' -- CTRL + N for multiple cursors
use 'https://github.com/preservim/tagbar' -- Tagbar for code navigation
use {'dracula/vim',  as = 'dracula' } -- ColorScheme
use 'https://github.com/rafi/awesome-vim-colorschemes' -- Retro Scheme
use 'https://github.com/tpope/vim-fugitive'
use 'jiangmiao/auto-pairs' --this will auto close ( [ {
use {'dsznajder/vscode-es7-javascript-react-snippets',run = 'yarn install --frozen-lockfile && yarn compile'}
use 'Mofiqul/adwaita.nvim' -- Adwaita colorScheme
use {'nvim-lualine/lualine.nvim',requires = { 'kyazdani42/nvim-web-devicons', opt = true }} require('lualine').setup({}) -- status bar 
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
} -- Also Comment
use 'JoosepAlviste/nvim-ts-context-commentstring' -- Comments

-- Better Syntax Highlight
 use {
         'nvim-treesitter/nvim-treesitter',
         run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
     }  
 		use 'maxmellon/vim-jsx-pretty'
 		use 'HerringtonDarkholme/yats.vim'
use 'leafgarland/typescript-vim'
 		use 'peitalin/vim-jsx-typescript'
 		use 'styled-components/vim-styled-components'
-- Better Syntax Highlight

use { 'windwp/nvim-ts-autotag' }

use {
   "neovim/nvim-lspconfig",
    "jose-elias-alvarez/null-ls.nvim",
}
use 'rafamadriz/friendly-snippets'

end)


