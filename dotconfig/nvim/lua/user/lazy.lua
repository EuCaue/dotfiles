local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local configs_opts = {
	change_detection = {
		notify = false,
	},
	ui = {
		border = require("user.utils").border_status,
		title = "Lazy",
	},
	install = { colorscheme = { vim.cmd.colorscheme } },
}

require("lazy").setup("user.plugins", configs_opts)
