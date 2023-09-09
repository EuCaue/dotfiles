local root_dir = vim.fn.getcwd()
if root_dir.match(root_dir, "/home/caue/Documents/vault/") then
	--  TODO: make this use nvim_option
	vim.cmd("set spell")
	vim.cmd("set spelllang=en_us,pt_br")
	vim.cmd("hi SpellBad  guifg=Red")
end

vim.keymap.set(
	"n",
	"<leader>mp",
	"<cmd>MarkdownPreview<cr>",
	{ noremap = true, silent = true, desc = "Markdown Preview" }
)
