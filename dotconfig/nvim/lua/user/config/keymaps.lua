local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

local map = function(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", get_opts("remap space as leader"))
map("n", "<space>R", "q", get_opts("R to q"))
map("", "q", "<Nop>", get_opts("remove default q keymap"))
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--  _  __
-- | |/ /___ _   _ _ __ ___   __ _ _ __  ___
-- | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- | . \  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- Basic Keymaps
map({ "n", "i" }, "<C-s>", "<cmd>write!<cr>", get_opts("Write"))
map("n", "<leader>Q", "<cmd>qa!<cr>", get_opts("Quit all"))
map("n", "<leader>a", "gg<S-v>G", get_opts("Select all text in the buffer"))
map("n", "<CR>", "ciw", get_opts("Cut the inner word"))
map("n", "<TAB>", "<C-6>", get_opts("Cut the inner word"))
map("n", "vv", "viw", get_opts("Select word under cursor"))

-- Moviment
map("n", "<A-j>", "5j", get_opts("Down 5 lines "))
map("n", "<A-k>", "5k", get_opts("Up 5 Lines"))
map("n", "<C-d>", "<C-d>zz", get_opts("Scroll down half a page"))
map("n", "<C-u>", "<C-u>zz", get_opts("Scroll up half a page"))
map("i", "<C-d>", "<C-o><C-d>", get_opts("Scroll down in insert mode"))
map("i", "<C-u>", "<C-o><C-u>", get_opts("Scroll up in insert mode"))
map("n", "n", "nzzzv", get_opts("Scroll up half a page"))
map("n", "N", "Nzzzv", get_opts("Scroll up half a page"))

-- Better J/K
map(
  "n",
  "j",
  [[(v:count > 1 ? "m'" . v:count : '') . 'gj']],
  get_opts("Jump list relative line jump", true)
)
map(
  "n",
  "k",
  [[(v:count > 1 ? "m'" . v:count : '') . 'gk']],
  get_opts("Jump list relative line jump", true)
)

-- Better
map({ "n", "v" }, "<leader>y", '"+y', get_opts("Copy to system clipboard"))
map({ "n", "v" }, "<leader>c", '"+c', get_opts("Cut to system clipboard"))
map({ "n", "v" }, "<leader>p", '"+p', get_opts("Paste from system clipboard"))
map({ "n", "v" }, "<leader>d", '"_d', get_opts("Delete for the void register"))
map({ "v", "x" }, "p", '"_dP', get_opts("greatest remap ever"))

-- window
map(
  "n",
  "<leader>re",
  ":%s//<Left>",
  get_opts("Rename with substitute command")
)

map(
  { "n", "v" },
  "<leader>rr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  get_opts("Rename with substitute command based on current text")
)

map("n", "<C-t>", "<cmd>Ha<cr>", get_opts("Build and run"))

-- Make executable
map(
  "n",
  "<leader>x",
  "<cmd>!chmod +x %<cr>",
  get_opts("Make the current file executable")
)
map(
  "n",
  "<leader><leader>x",
  "<cmd>!chmod -x %<cr>",
  get_opts("Make the current file not executable")
)

-- Terminal
map("t", "<esc>", [[<C-\><C-n>]], get_opts("Esc in terminal"))

-- window
map("n", "<leader>wv", "<C-w>v", get_opts("Vertical split"))
map("n", "<leader>ws", "<C-w>s", get_opts("Horizontal split"))
map("n", "<leader>wr", "<C-w>r", get_opts("Rotate splits"))
map("n", "<leader>wq", "<C-w>q", get_opts("Close split"))
map("n", "<leader>w=", "<C-w>=", get_opts("Make split equal"))
map("n", "<leader>w|", "<C-w>|", get_opts("Maximize split"))

-- Better window navigation
map("n", "<C-h>", "<C-w>h", get_opts("Move to left window"))
map("n", "<C-l>", "<C-w>l", get_opts("Move to right window"))

-- visual inc

map("v", "<CR>", "e", get_opts(""))
map("v", "<BS>", "b", get_opts(""))

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<cr>", get_opts("Resize Up"))
map("n", "<C-Down>", ":resize +2<cr>", get_opts("Resize Down"))
map("n", "<C-Left>", ":vertical resize -2<cr>", get_opts("Resize Left"))
map("n", "<C-Right>", ":vertical resize +2<cr>", get_opts("Resize Right"))

-- Navigate buffers
map("n", "<S-l>", "<cmd>bnext<cr>", get_opts("Prev Buffer"))
map("n", "<S-h>", "<cmd>bprevious<cr>", get_opts("Next Buffer"))

-- Stay in indent mode
map("v", "<", "<gv", get_opts("Left indent"))
map("v", ">", ">gv", get_opts("Right indent"))

-- Move text up and down
map("v", "<A-j>", ":m .+1<cr>==", get_opts("Move text up"))
map("v", "<A-k>", ":m .-2<cr>==", get_opts("Move text down"))
map("x", "<A-j>", ":move '>+1<cr>gv-gv", get_opts("Move line down"))
map("x", "<A-k>", ":move '<-2<cr>gv-gv", get_opts("Move text up"))
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", get_opts("Move line down"))
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", get_opts("Move line up"))

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", get_opts("Create a new tab"))
map("n", "<A-,>", "<cmd>tabprevious<cr>", get_opts("Previous tab"))
map("n", "<A-.>", "<cmd>tabnext<cr>", get_opts("Next tab"))
map("n", "<leader>tc", "<cmd>tabclose<cr>", get_opts("Close Tab"))

-- Close buffer
map(
  "n",
  "<leader>q",
  "<cmd>bp | sp | bn | bd<cr>",
  get_opts("Close current buffer")
)

-- Lazy
map({ "n", "v" }, "<leader>L", "<cmd>Lazy<cr>", get_opts("Open Lazy"))
