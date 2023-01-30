-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Basic keymaps
keymap("n", "<C-s>", "<cmd>write!<cr>", opts)
keymap("i", "<C-s>", "<cmd>write!<cr>", opts)
keymap("n", "<C-z>", "<cmd>wq!<cr>", opts)
keymap("n", "<C-x>", "<cmd>q!<cr>", opts)
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Comment
keymap("x", "<C-/>", "<cmd>normal gcc<cr>", opts)
keymap("n", "<C-/>", "<cmd>normal gcc<cr>", opts)
keymap("i", "<C-/>", "<cmd>normal gcc<cr>", opts)

keymap("n", "<leader>x", "<cmd>cd ~/dotfiles/dotconfig/nvim/ | e ~/dotfiles/dotconfig/nvim/init.lua<cr>", opts)

-- LazyGit && ToggleTerm
keymap("n", "<leader>l", "<cmd>LazyGit<cr>", opts)
-- keymap("n", "<C-t>T", "<cmd>ToggleTerm direction=tab<cr>", opts)
keymap("n", "<C-t>", "<cmd>ToggleTerm<cr>", opts)
keymap("n", "<leader>qq", "<cmd>ToggleTerm direction=horizontal size=5<cr>", opts)

-- NvimTree
keymap("n", "<leader>g", "<cmd>NvimTreeToggle<cr>", opts)
keymap("n", "<leader>nf", "<cmd>NvimTreeFocus<cr>", opts)
keymap("n", "<leader>no", "<cmd>NvimTreeCollapse<cr>", opts)
keymap("n", "<leader>dt", "<cmd>cd ~/dotfiles/ | NvimTreeToggle<cr>", opts)

-- keymap("v", "p", '"_dP', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>y", '"+y', opts)

keymap("v", "<leader>d", '"_d', opts)
keymap("n", "<leader>d", '"_d', opts)

keymap("n", "<leader>re", ":%s//<Left>", opts)
keymap("n", "<leader>s", "<cmd>!chmod +x %<CR>", opts)
vim.keymap.set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

keymap("n", "<leader>nc", "<cmd>NoNeckPain<cr>", opts)
keymap("n", "<leader>nz", "<cmd>ZenMode<cr>", opts)

-- Telescope
keymap("n", "<leader>to", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>tf", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>tl", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>tp", "<cmd>Telescope project<cr>", opts)
keymap("n", "<leader>tc", "<cmd>Telescope colorscheme<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>tk", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>tu", "<cmd>Telescope undo<cr>", opts)
keymap("n", "<leader>tv", "<cmd>cd ~/Documents/my vault/Personal/ | Telescope file_browser<cr>", opts)

keymap("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
keymap("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- buffer line
-- Move to previous/next
keymap("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", opts)
keymap("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", opts)
-- Re-order to previous/next
keymap("n", "<A-<>", "<Cmd>BufferLineMovePrev<CR>", opts)
keymap("n", "<A->>", "<Cmd>BufferLineMoveNext<CR>", opts)
-- Goto buffer in position...
keymap("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)
-- Pin/unpin buffer
keymap("n", "<A-p>", "<Cmd>BufferLineTogglePin<CR>", opts)
-- Close buffer
keymap("n", "<A-c>", "<Cmd>bdelete!<CR>", opts)
keymap("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", opts)

-- Sort automatically by...
keymap("n", "<Space>bb", "<Cmd>BufferLineSortByTabs<CR>", opts)
keymap("n", "<Space>bd", "<Cmd>BufferLineSortByDirectory<CR>", opts)
keymap("n", "<Space>be", "<Cmd>BufferLineSortByLanguage<CR>", opts)
keymap("n", "<Space>br", "<Cmd>BufferLineSortByRelativeDirectory<CR>", opts)
