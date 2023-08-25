local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

local map = function(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", get_opts("remap space as leader key"))
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

map({ "n", "i" }, "<C-s>", "<cmd>write!<cr>", get_opts("Write"))
map("n", "<leader>qq", "<cmd>qa!<cr>", get_opts("Quit"))
map("n", "<leader>aa", "gg<S-v>G", get_opts("Select all"))
map("n", "<C-S-t>", "<cmd>e#<cr>", get_opts("Reopen the last closed buffer"))
map("n", "<Tab>", "<C-W>w", get_opts("Cycle through windows"))
map("n", "<F2>", "<C-w>|", get_opts("Max the current window"))
map("n", "<F3>", "<C-w>=", get_opts("Equal widths between windows"))
map("n", "<CR>", "ciw", get_opts("Cut the inner word"))
map("n", "<leader>U", "gU", get_opts("Easy Caps"))
map("n", "<leader>u", "gu", get_opts("Easy Uncaps"))
map("n", "<leader><leader>s", "<cmd>spellrepall<cr>", get_opts("Fix all spell problem"))
map("n", "vv", "viw", get_opts("Select word under cursor"))

-- Better J/K
map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'gj']], get_opts("Jump list relative line jump", true))
map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'gk']], get_opts("Jump list relative line jump", true))

-- Better
map({ "n", "v" }, "<leader>y", '"+y', get_opts("Copy to system clipboard"))
map({ "n", "v" }, "<leader>c", '"+c', get_opts("Cut to system clipboard"))
map({ "n", "v" }, "<leader>p", '"+p', get_opts("Paste from system clipboard"))
map({ "n", "v" }, "<leader>d", '"_d', get_opts("Delete for the void register"))
map({ "v", "x" }, "p", '"_dP', get_opts("greatest remap ever"))

vim.api.nvim_set_keymap(
  "n",
  "gcmt",
  "gcO TODO:<ESC><Right>",
  { silent = true, noremap = false, desc = "Create a todo comment" }
)

map("n", "<leader>re", ":%s//<Left>", get_opts("Rename with substitute command"))

map(
  { "n", "v" },
  "<leader>rr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  get_opts("Rename with substitute command based on current text")
)

-- Make executable
map("n", "<leader>x", "<cmd>!chmod +x %<cr>", get_opts("Make the current file executable"))
map("n", "<leader><leader>x", "<cmd>!chmod -x %<cr>", get_opts("Make the current file not executable"))

-- Better window navigation
map("n", "<C-h>", "<C-w>h", get_opts("Move to left window"))
map("n", "<C-l>", "<C-w>l", get_opts("Move to right window"))

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
map("n", "<A-j>", "<Esc>:m .+1<cr>==gi", get_opts("Move line down"))
map("n", "<A-k>", "<Esc>:m .-2<cr>==gi", get_opts("Move line up"))
map("x", "<A-j>", ":move '>+1<cr>gv-gv", get_opts("Move line down"))
map("x", "<A-k>", ":move '<-2<cr>gv-gv", get_opts("Move text up"))
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", get_opts("Move line down"))
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", get_opts("Move line up"))

-- Tabs
map("n", "<leader>tn", "<cmd>tabnew<cr>", get_opts("Create a new tab"))
map("n", "<A-,>", "<cmd>tabprevious<cr>", get_opts("Previous tab"))
map("n", "<A-.>", "<cmd>tabnext<cr>", get_opts("Next tab"))
map("n", "<leader>tc", "<cmd>tabclose<cr>", get_opts("Close Tab"))

-- Move to previous/next
map("n", "<A-[>", "<cmd>bprevious<cr>", get_opts("Prev buffer"))
map("n", "<A-]>", "<cmd>bnext<cr>", get_opts("Next buffer"))

-- Close buffer
map("n", "<A-c>", "<cmd>bp | sp | bn | bd<cr>", get_opts("Close current buffer"))




--  ____  _             _             _  __
-- |  _ \| |_   _  __ _(_)_ __  ___  | |/ /___ _   _ _ __ ___   __ _ _ __  ___
-- | |_) | | | | |/ _` | | '_ \/ __| | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- |  __/| | |_| | (_| | | | | \__ \ | . \  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|   |_|\__,_|\__, |_|_| |_|___/ |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--                |___/                        |___/                |_|

-- Comment
map({ "n", "i", "x" }, "<C-_>", "<cmd>normal gcA<cr>", get_opts("Comment"))
map({ "n", "i", "x" }, "<C-/>", "<cmd>normal gcA<cr>", get_opts("Comment"))

-- Telescope
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", get_opts("Recent Files"))
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", get_opts("Find Files"))
map("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", get_opts("File Browser"))
map("n", "<leader>b", "<cmd>Telescope buffers<cr>", get_opts("Find Buffers"))
map("n", "<leader>fr", "<cmd>Telescope current_buffer_fuzzy_find<cr>", get_opts("Fuzzy Find in Buffer"))
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", get_opts("See diagnostics"))
map("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", get_opts("Find Words"))
map("n", "<leader>fs", "<cmd>Telescope grep_string<cr>", get_opts("Find for word under cursor"))
map("n", "<leader>fp", "<cmd>Telescope project<cr>", get_opts("Projects"))
map("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", get_opts("Change Colorscheme"))
map("n", "<leader>fg", "<cmd>Telescope git_status<cr>", get_opts("Check git status"))
map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", get_opts("Keymaps"))
map("n", "<leader>fu", "<cmd>Telescope undo<cr>", get_opts("Undo Tree"))
map("n", "<leader>fv", "<cmd>cd ~/Documents/vault/ | Telescope file_browser<cr>", get_opts("Markdown"))
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", get_opts("Todos"))
map("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>", get_opts("See harpoon marks"))
map("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", get_opts("Telescope Jumplist"))
map("n", "<leader><leader>t", "<cmd>Telescope<cr>", get_opts("Open Telescope Builtins Options"))

-- Session Manager
map("n", "<leader>sl", "<cmd>SessionManager load_session<cr>", get_opts("Sessions "))
map("n", "<leader>sd", "<cmd>SessionManager delete_session<cr>", get_opts("Delete Sessions"))
map("n", "<leader>sc", "<cmd>SessionManager save_current_session<cr>", get_opts("Save Current Session"))
map("n", "<leader>ss", "<cmd>SessionManager load_last_session<cr>", get_opts("Load Last Session"))

-- Harpoon
map(
  { "n", "v" },
  "<leader>ah",
  "<cmd>:lua require('harpoon.mark').add_file(vim.fn.expand('%')) vim.notify('File add to harpoon: ' .. vim.fn.expand('%:t'))<cr>",
  get_opts("Add a file to harpoon")
)

-- Lazy
map({ "n", "v" }, "<leader><leader>l", "<cmd>Lazy<cr>", get_opts("Open Lazy"))

-- Git
map({ "n", "v" }, "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", get_opts("Preview Git Hunk"))
map({ "n", "v" }, "<leader>gb", "<cmd>Gitsigns blame_line<cr>", get_opts("Blame Line"))

-- Markdown
map({ "n", "v" }, "<leader>mg", "<cmd>Glow<cr>", get_opts("Open glow in the current file"))
map("n", "<leader>mf", "<cmd>Flote<cr>", get_opts("Open Flote"))

-- ToggleTerm
map("n", "<C-t>", "<cmd>ToggleTerm<cr>", get_opts("ToggleTerm float"))
map("n", "<leader><leader><leader>t", "<cmd>ToggleTerm direction=horizontal size=5<cr>", get_opts("ToggleTerm"))

-- Neotree
map("n", "<leader>n", "<cmd>Neotree toggle<cr>", get_opts("Neotree toggle"))
map("n", "<leader>nf", "<cmd>Neotree focus<cr>", get_opts("Neotree focus"))

map("n", "<leader>dt", "<cmd>cd ~/dotfiles/ | Neotree toggle<cr>", get_opts("Go to dotfiles"))
map("n", "<leader>vf", "<cmd>lua MiniFiles.open()<cr>", get_opts("Open MiniFiles"))

-- Muren
map({ "n", "v" }, "<leader>rm", "<cmd>MurenToggle<cr>", get_opts("Replace with Muren"))

-- Hop
map("n", "<leader>H", ":HopChar2<cr>", get_opts("Hop to Char"))
map("n", "<leader>h", ":HopWord<cr>", get_opts("Hop to Word"))

-- Notify
map(
  { "n", "v" },
  "<leader>cn",
  "<cmd>lua require('notify').dismiss({ silent = true, pending = true })<cr>",
  get_opts("Close all notifications")
)

-- Center screen
map("n", "<leader>nc", "<cmd>NoNeckPain<cr>", get_opts("Center the screen"))
map("n", "<leader>nz", "<cmd>ZenMode<cr>", get_opts("ZenMode"))
