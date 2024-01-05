-- HACK: one day i'll figure out what is this but works nice. :)ot
-- vim.opt.statuscolumn =
-- "%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%{v:relnum == 0 ? ' ' : ''}"

local opt = vim.opt
local g = vim.g

--   ___        _   _
--  / _ \ _ __ | |_(_) ___  _ __  ___
-- | | | | '_ \| __| |/ _ \| '_ \/ __|
-- | |_| | |_) | |_| | (_) | | | \__ \
--  \___/| .__/ \__|_|\___/|_| |_|___/
--       |_|

opt.backup = false -- creates a backup file
opt.background = "dark" -- dark bg
opt.clipboard = "" -- disable system clipboard support
opt.cmdheight = 1 -- command line height
opt.completeopt = { "menu", "menuone", "preview", "noselect" } -- mostly just for cmp
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.mouse = "" -- disable mouse
opt.pumheight = 15 -- pop up menu height, like cmp
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.fillchars = { fold = "0", eob = " " } -- :help fillchars
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = "v:lua.vim.treesitter.foldtext()"
opt.foldmethod = "indent"
opt.foldcolumn = "0" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.showcmd = false -- not show
opt.title = true -- neovim window title by titlestring
opt.showtabline = 0 -- always show tabs
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- disable swapfile
-- opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
-- opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50" -- blocky cursor
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.updatetime = 50 -- faster completion
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.incsearch = true -- incremental search
opt.softtabstop = 2 -- insert 2 spaces for a tab
opt.cursorline = true -- highlight the current line
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.numberwidth = 4 -- set number column width to 4 {default 4}
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.linebreak = true -- companion to wrap, don't split words
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
opt.wrap = false -- disable wrap
opt.guifont = os.getenv("FONT_NAME") -- the font used in graphical neovim applications
opt.shortmess:append({ C = true }) -- i dont know
opt.iskeyword:append("-") -- Treat dash separated words as a word text object

--   ____    ___        _   _
--  / ___|  / _ \ _ __ | |_(_) ___  _ __  ___
-- | |  _  | | | | '_ \| __| |/ _ \| '_ \/ __|
-- | |_| | | |_| | |_) | |_| | (_) | | | \__ \
--  \____|  \___/| .__/ \__|_|\___/|_| |_|___/
--               |_|

-- NOTE: disabling vim plugins

g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_matchit = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1

g.netrw_banner = 0

g.skip_ts_context_commentstring_module = true
