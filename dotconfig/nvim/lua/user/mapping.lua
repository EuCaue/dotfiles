-- Shorten function name
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local function get_opts(desc, expr)
	return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

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
keymap("n", "<C-s>", "<cmd>write!<cr>", get_opts("Write"))
keymap("i", "<C-s>", "<cmd>write!<cr>", get_opts("Write"))
keymap("n", "<C-z>", "<cmd>wq!<cr>", get_opts("Write and Quit"))
keymap("n", "<C-x>", "<cmd>q!<cr>", get_opts("Quit"))
keymap("n", "<C-a>", "gg<S-v>G", get_opts("Select all"))

-- Comment
keymap("x", "<C-/>", "<cmd>normal gcc<cr>", get_opts("Comment"))
keymap("n", "<C-/>", "<cmd>normal gcc<cr>", get_opts("Comment"))
keymap("i", "<C-/>", "<cmd>normal gcc<cr>", get_opts("Comment"))

keymap("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'gj']], get_opts("Jump list relative line jump", true))
keymap("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'gk']], get_opts("Jump list relative line jump", true))

keymap("n", "vv", "viw", get_opts("Select word under cursor"))
keymap("n", "<leader>m", "<cmd>Glow<cr>", get_opts("Open glow in the current file"))
keymap("v", "<leader>m", "<cmd>Glow<cr>", get_opts("Open glow in the current file"))

-- LazyGit && ToggleTerm
keymap("n", "<leader>tl", "<cmd>LazyGit<cr>", get_opts("LazyGit"))
keymap("n", "<C-t>", "<cmd>ToggleTerm<cr>", get_opts("ToggleTerm float"))
keymap("n", "<leader>qq", "<cmd>ToggleTerm direction=horizontal size=5<cr>", get_opts("ToggleTerm"))

-- Neotree
keymap("n", "<leader>g", "<cmd>Neotree toggle<cr>", get_opts("Neotree toggle"))
keymap("n", "<leader>nf", "<cmd>Neotree focus<cr>", get_opts("Neotree focus"))
keymap("n", "<leader>dt", "<cmd>cd ~/dotfiles/ | Neotree toggle<cr>", get_opts("Go to dotfiles"))

keymap(
	"n",
	"<leader>cn",
	"<cmd>lua require('notify').dismiss({ silent = true, pending = true })<cr>",
	get_opts("Close all notifications")
)

keymap("v", "<leader>y", '"+y', get_opts("Copy to system clipboard"))
keymap("n", "<leader>y", '"+y', get_opts("Copy to system clipboard"))

keymap("v", "<leader>c", '"+c', get_opts("Cut to system clipboard"))
keymap("n", "<leader>c", '"+c', get_opts("Cut to system clipboard"))

keymap("v", "<leader>p", '"+p', get_opts("Paste from system clipboard"))
keymap("n", "<leader>p", '"+p', get_opts("Paste from system clipboard"))

keymap("v", "<leader>d", '"_d', get_opts("Delete for the void register"))
keymap("n", "<leader>d", '"_d', get_opts("Delete for the void register"))

keymap("n", "<leader>re", ":%s//<Left>", get_opts("Rename with substitute command"))
vim.keymap.set(
	"n",
	"<leader>rr",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	get_opts("Rename with substitute command based on current text")
)
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", get_opts("Make the current file executable"))

keymap("n", "<leader>nc", "<cmd>NoNeckPain<cr>", get_opts("Center the screen"))
keymap("n", "<leader>nz", "<cmd>ZenMode<cr>", get_opts("ZenMode"))

-- Telescope
keymap("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", get_opts("Recent Files"))
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", get_opts("Find Files"))
keymap("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", get_opts("File Browser"))
keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", get_opts("All Diagnostics"))
keymap("n", "<leader>fl", "<cmd>Telescope live_grep<cr>", get_opts("Live Grep"))
keymap("n", "<leader>fp", "<cmd>Telescope project<cr>", get_opts("Projects"))
keymap("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", get_opts("Change Colorscheme"))
keymap("n", "<leader>fg", "<cmd>Telescope git_status<cr>", get_opts("Check git status"))
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", get_opts("Keymaps"))
keymap("n", "<leader>fu", "<cmd>Telescope undo<cr>", get_opts("Undo Tree"))
keymap("n", "<leader>fv", "<cmd>cd ~/Documents/my vault/Personal/ | Telescope file_browser<cr>", get_opts("Markdown"))
keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", get_opts("Todos"))

-- Git
keymap("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", get_opts("Preview Git Hunk"))
keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", get_opts("Blame Line"))

keymap("n", "<leader>sv", "<C-w>v", get_opts("Split window vertically"))
keymap("n", "<leader>se", "<C-w>=", get_opts("Make split windows equal width & height"))

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", get_opts("Move to left window"))
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", get_opts("Move to right window"))

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", get_opts("Resize Up"))
keymap("n", "<C-Down>", ":resize +2<CR>", get_opts("Resize Down"))
keymap("n", "<C-Left>", ":vertical resize -2<CR>", get_opts("Resize Left"))
keymap("n", "<C-Right>", ":vertical resize +2<CR>", get_opts("Resize Right"))

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", get_opts("Prev Buffer"))
keymap("n", "<S-h>", ":bprevious<CR>", get_opts("Next Buffer"))

-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", get_opts("Exit insert mode"))
keymap("i", "kj", "<ESC>", get_opts("Exit insert mode"))

-- Stay in indent mode
keymap("v", "<", "<gv", get_opts("Left indent"))
keymap("v", ">", ">gv", get_opts("Right indent"))

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", get_opts("Move text up"))
keymap("v", "<A-k>", ":m .-2<CR>==", get_opts("Move text down"))
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", get_opts("Move line down"))
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", get_opts("Move line up"))
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", get_opts("Move line down"))
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", get_opts("Move text up"))
keymap("i", "<A-j>", "<Esc>:m .+1<cr>==gi", get_opts("Move line down"))
keymap("i", "<A-k>", "<Esc>:m .-2<cr>==gi", get_opts("Move line up"))

keymap("v", "p", '"_dP', opts)

-- buffer line
-- Move to previous/next
keymap("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", get_opts("Prev buffer"))
keymap("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", get_opts("Next buffer"))
-- Re-order to previous/next
keymap("n", "<A-<>", "<Cmd>BufferLineMovePrev<CR>", get_opts("Move buffer prev "))
keymap("n", "<A->>", "<Cmd>BufferLineMoveNext<CR>", get_opts("Move buffer next"))
-- Goto buffer in position...
keymap("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>", get_opts("Go to buffer 1"))
keymap("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>", get_opts("Go to buffer 2"))
keymap("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>", get_opts("Go to buffer 3"))
keymap("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>", get_opts("Go to buffer 4"))
keymap("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>", get_opts("Go to buffer 5"))
keymap("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>", get_opts("Go to buffer 6"))
keymap("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>", get_opts("Go to buffer 7"))
keymap("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>", get_opts("Go to buffer 8"))
keymap("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>", get_opts("Go to buffer 9"))
-- Pin/unpin buffer
keymap("n", "<A-p>", "<Cmd>BufferLineTogglePin<CR>", get_opts("Pin current buffer"))
-- Close buffer
keymap("n", "<A-c>", "<Cmd>bdelete!<CR>", get_opts("Close current buffer"))
keymap("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", get_opts("Choose a buffer"))

-- Sort automatically by...
keymap("n", "<Space>bb", "<Cmd>BufferLineSortByTabs<CR>", get_opts("Sort buffer by tabs"))
keymap("n", "<Space>bd", "<Cmd>BufferLineSortByDirectory<CR>", get_opts("Sort buffer by directory"))
keymap("n", "<Space>be", "<Cmd>BufferLineSortByLanguage<CR>", get_opts("Sort buffer by language"))
keymap("n", "<Space>br", "<Cmd>BufferLineSortByRelativeDirectory<CR>", get_opts("Sort buffer by relative directory "))
