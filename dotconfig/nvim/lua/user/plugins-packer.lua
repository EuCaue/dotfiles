packer = require("packer")

packer.init({
	display = {
		prompt_border = "double", -- Border style of prompt popups
		show_all_info = true, -- Should packer show all update details auto?
		header_sym = "--", -- the symbol for the header line in packer's display
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

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
	use("wbthomason/packer.nvim") -- Plugin Manager

	-- Colorscheme
	use({ "rose-pine/neovim", as = "rose-pine" }) -- Colorscheme
	use({ "Mofiqul/adwaita.nvim" })
	use({ "LunarVim/darkplus.nvim" })

	-- BetterComment
	use({
		"numToStr/Comment.nvim",
	}) -- Also Comment
	use({ "JoosepAlviste/nvim-ts-context-commentstring" }) -- Better JSX + TSX comment

	-- BetterHighlight
	use("styled-components/vim-styled-components") -- highlight for styled-components
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- a better highlight for everything
	use({ "nvim-treesitter/nvim-treesitter-textobjects" })
	use({ "mrjones2014/nvim-ts-rainbow" }) -- {} colored
	use("theRealCarneiro/hyprland-vim-syntax") -- Better syntax highlight in hyprland.conf

	-- Snippets
	use({ "L3MON4D3/LuaSnip" })
	use({ "rafamadriz/friendly-snippets" }) -- a lot of snippets
	use({
		"dsznajder/vscode-es7-javascript-react-snippets",
		run = "yarn install --frozen-lockfile && yarn compile",
	})
	-- IDE
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "neovim/nvim-lspconfig" }) -- LSP
	use({ "SmiteshP/nvim-navic" })
	use({ "fgheng/winbar.nvim" })
	use("simrat39/symbols-outline.nvim")
	use({ "kyazdani42/nvim-tree.lua" }) -- Tree file
	use("mattn/emmet-vim") -- emmet
	use({ "mbbill/undotree" }) -- undo tree
	use({ "kdheepak/lazygit.nvim" }) -- lazygit inside nvim
	use("lukas-reineke/indent-blankline.nvim") -- indent blankline
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	use("editorconfig/editorconfig-vim") -- Editorconfig
	use({ "https://github.com/terryma/vim-multiple-cursors" }) -- CTRL + N for multiple cursors
	use({ "windwp/nvim-autopairs" }) -- auto close ({[
	use({ "nvim-lualine/lualine.nvim" }) -- status bar
	use({ "windwp/nvim-ts-autotag" }) -- <> autoclose tag
	use({ "lewis6991/gitsigns.nvim", tag = "release" }) -- Git
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" }) -- fzf finder
	use({ "nvim-lua/plenary.nvim" })
	use("karb94/neoscroll.nvim") -- better scroll
	use("folke/which-key.nvim") -- which key
	use("petertriho/nvim-scrollbar") -- scrollbar
	use({ "nvim-telescope/telescope-project.nvim" }) -- find projects
	use("rcarriga/nvim-notify") -- notify
	use({ "debugloop/telescope-undo.nvim" }) -- undo tree with telescope
	use({ "shortcuts/no-neck-pain.nvim" })
	use({ "goolord/alpha-nvim" }) -- title screen
	use({ "j-hui/fidget.nvim" })
	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
	})

	use({ "yamatsum/nvim-cursorline" })
	use({ "NvChad/nvim-colorizer.lua" })
	use({ "MunifTanjim/nui.nvim" })

	--
	-- Useful
	use({ "asiryk/auto-hlsearch.nvim" })
	use({ "nvim-lua/popup.nvim" }) -- PopUp API for neovim
	use({ "akinsho/toggleterm.nvim" }) -- show a "portable" terminal
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	}) -- TODO:
	use({ "tamago324/lir.nvim" })

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	}) -- preview markdown files on browser
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({ window = { width = 0.85, backdrop = 0.85, height = 80 } })
		end,
	}) -- zenmode
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- CMP :
	use("dcampos/cmp-emmet-vim")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use({ "mtoohey31/cmp-fish", ft = "fish" })
	use("hrsh7th/cmp-buffer")
	use("dburian/cmp-markdown-link")
	use("hrsh7th/cmp-path")
	use({ "jcha0713/cmp-tw2css" })
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use({ "ray-x/cmp-treesitter" })
	use("amarakon/nvim-cmp-fonts")
	use({ "williamboman/mason.nvim" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" })

	use({
		"utilyre/barbecue.nvim",
	})
	use({
		"antonk52/markdowny.nvim",
		config = function()
			require("markdowny").setup()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
