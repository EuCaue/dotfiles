local opt = vim.opt
local g = vim.g

-- custom macros
vim.fn.setreg("s", "]sz=1\r")
vim.fn.setreg("S", "[sz=1\r")

-- set <space> as the leader key
g.mapleader = " "
g.maplocalleader = " "

-- autoformat
g.autoformat = false

g.async_format = true

-- use icons or not
g.have_nerd_font = true

-- border style for windows
g.border_type = "none"

vim.cmd(
  "set guicursor=n-v-c-i-ci-ve-o-sm:block-blinkwait700-blinkon400-blinkoff250-Cursor,n-v-c:block-ModeNormal,i-ci-ve:block-ModeInsert,r-cr:hor20-blinkwait700-blinkon400-blinkoff250-ModeReplace "
)
-- trigger bigfile size
g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB
opt.background = "dark"
opt.autowrite = true -- Enable auto write
opt.backup = false -- creates a backup file
opt.colorcolumn = "120" -- colorcolumn
opt.completeopt = "menu,menuone,noinsert,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highdarking of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.foldlevel = 99
opt.foldexpr = "v:lua.require'user.core.fold'.foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.ignorecase = true -- Ignore case
opt.inccommand = "split" -- inc in split view
opt.jumpoptions = "stack,view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.showbreak = ">>> "
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 0 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = false -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en", "pt_br" } -- set spelllang
opt.spelloptions:append("noplainbuffer")
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.swapfile = false -- creates a swapfile
opt.ruler = false -- hide ruler
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.title = true -- enable title
opt.undofile = true -- enable undo file
opt.undolevels = 10000 -- increase undo levels
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winborder = g.border_type
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.writebackup = false -- disable backup
opt.smoothscroll = true

-- Fix markdown indentation settings
g.markdown_recommended_style = 0
g.markdown_folding = 1 -- enable markdown folding

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
