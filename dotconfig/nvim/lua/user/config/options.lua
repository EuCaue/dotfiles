-- HACK: one day i'll figure out what is this but works nice. :)
-- vim.opt.statuscolumn =
-- "%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%{v:relnum == 0 ? ' ' : ''}"

local opt = vim.opt

opt.backup = false                                  -- creates a backup file
opt.background = "dark"
opt.clipboard = ""                                  -- allows neovim to access the system clipboard
opt.cmdheight = 1                                   -- more space in the neovim command line for displaying messages
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 2                                -- so that `` is visible in markdown files
opt.fileencoding = "utf-8"                          -- the encoding written to a file
opt.hlsearch = true                                 -- highlight all matches on previous search pattern
opt.ignorecase = true                               -- ignore case in search patterns
opt.mouse = "a"                                     -- allow the mouse to be used in neovim
opt.pumheight = 10                                  -- pop up menu height
opt.showmode = false                                -- we don't need to see things like -- INSERT -- anymore
opt.foldmethod = "indent"
opt.fillchars = { fold = " ", eob = " " }
opt.foldcolumn = "0" -- '0' is not bad
opt.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true
opt.showcmd = false
opt.title = true
opt.showtabline = 1    -- always show tabs
opt.smartcase = true   -- smart case
opt.smartindent = true -- make indenting smarter again
opt.splitbelow = true  -- force all horizontal splits to go below current window
opt.splitright = true  -- force all vertical splits to go to the right of current window
opt.swapfile = false   -- creates a swapfile
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
-- opt.guicursor = "n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50"
opt.termguicolors = true                -- set term gui colors (most terminals support this)
opt.timeoutlen = 300                    -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true                     -- enable persistent undo
opt.updatetime = 1000                   -- faster completion (4000ms default)
opt.writebackup = false                 -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = true                    -- convert tabs to spaces
opt.shiftwidth = 2                      -- the number of spaces inserted for each indentation
opt.tabstop = 2                         -- insert 2 spaces for a tab
opt.incsearch = true
opt.softtabstop = 2                     -- insert 2 spaces for a tab
opt.cursorline = true                   -- highlight the current line
opt.number = true                       -- set numbered lines
opt.relativenumber = true               -- set relative numbered lines
opt.numberwidth = 4                     -- set number column width to 2 {default 4}
opt.signcolumn = "yes"                  -- always show the sign column, otherwise it would shift the text each time
opt.linebreak = true                    -- companion to wrap, don't split words
opt.scrolloff = 8                       -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8                   -- minimal number of screen columns either side of cursor if wrap is `false`
opt.wrap = false                        -- wrap
opt.guifont = "iMWritingMono Nerd Font" -- the font used in graphical neovim applications
opt.splitkeep = "screen"
opt.shortmess:append({ C = true })
