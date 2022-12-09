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
keymap("n", "<C-z>", "<cmd>wq!<cr>", opts)
keymap("n", "<C-x>", "<cmd>q!<cr>", opts)
-- Comment
keymap("x", "<C-/>", "<cmd>normal gcc<cr>", opts)
keymap("n", "<C-/>", "<cmd>normal gcc<cr>", opts)
keymap("i", "<C-/>", "<cmd>normal gcc<cr>", opts)

keymap("n", "<leader>x", "<cmd>e ~/dotfiles/dotconfig/nvim/init.lua<cr>", opts)

-- LazyGit && ToggleTerm
keymap("n", "<leader>lg", "<cmd>LazyGit<cr>", opts)
keymap("n", "<leader>qq", "<cmd>ToggleTerm<cr>", opts)

-- NvimTree
keymap("n", "<leader>g", "<cmd>:NvimTreeToggle<cr>", opts)
keymap("n", "<leader>h", "<cmd>:NvimTreeFocus<cr>", opts)
-- keymap("n", "<leader>o", "<cmd>:NvimTreeCollapse<cr>", opts)
keymap("n", "<leader>D", "<cmd>cd ~/Dev/ | NvimTreeToggle<cr>", opts)
keymap("n", "<leader>z", "<cmd>cd ~/dotfiles/ | NvimTreeToggle<cr>", opts)


-- Telescope
keymap("n", "<leader>to", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>td", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>tl", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>tp", "<cmd>Telescope project<cr>", opts)
keymap("n", "<leader>tc", "<cmd>Telescope colorscheme<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope git_status<cr>", opts)
keymap("n", "<leader>ca", "<cmd>Telescope code_actions<cr>", opts)
-- vim.keymap.set("n", "<space>ta", "<cmd>Telescope code_actions<cr>", { remap = true })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
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

-- barbar mapping
-- local map = vim.api.nvim_set_keymap
-- local opts = { noremap = true, silent = true }

-- Move to previous/next
keymap("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
keymap("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
keymap("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
keymap("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
keymap("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
keymap("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
keymap("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
keymap("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
keymap("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
keymap("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
keymap("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
keymap("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
keymap("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
keymap("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
keymap("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
keymap("n", "<leader>bc", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
keymap("n", "<leader>bp", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
keymap("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
keymap("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
keymap("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
keymap("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
