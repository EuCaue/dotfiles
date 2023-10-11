local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

-- close some filetypes with <q>
autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"spectre_panel",
		"lspinfo",
		"oil",
		"vim",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

autocmd("FileType", {
	group = augroup("MyQuickFixGroup"),
	pattern = { "qf" },
	callback = function()
		vim.opt_local.wrap = true
		vim.keymap.set(
			"n",
			"<Leader>sr",
			[[:cdo s/<C-r><C-w>//gc | update <C-Left><C-Left><Left><Left><Left><Left>]],
			{ buffer = true, desc = "qf search and replace cword" }
		)
		vim.keymap.set(
			"v",
			"<Leader>sr",
			'y:cdo s/<C-R>"//gc | update <C-Left><C-Left><Left><Left><Left><Left>',
			{ buffer = true, desc = "qf search and replace selection" }
		)
	end,
	once = false,
})

autocmd("FileType", {
	group = augroup("quickfix"),
	pattern = {
		"qf",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = event.buf, silent = true })
	end,
})

-- highlight yank
autocmd({ "TextYankPost" }, {
	group = augroup("yank_highlight"),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 80 })
	end,
})

-- Autoformat
autocmd("BufWritePost", {
	group = augroup("format_on_save"),
	callback = function(args)
		require("conform").format({ async = true, bufnr = args.buf, lsp_fallback = true })
		-- vim.lsp.buf.format({ async = true, bufnr = args.buf })
	end,
})

-- better highlight on styled.js
autocmd("BufReadPost", {
	group = augroup("styled"),
	pattern = { "styled.js" },
	callback = function()
		vim.cmd([[TSBufDisable highlight]])
	end,
})

autocmd("BufNew", {
	group = augroup("ColorScheme"),
	callback = function()
		vim.cmd("hi FlashCurrent guibg=none")
		vim.cmd("hi FlashMatch guibg=none")
		--  TODO: make this get the colorscheme
		vim.cmd("hi FlashLabel guifg=White guibg=#E55C67 cterm=bold")
		vim.cmd("hi FlashLabel guifg=White guibg=#E55C67 cterm=bold")
		vim.cmd("highlight Pmenu guifg=NONE guibg=NONE")
	end,
})

-- LuaSnip Snippet History Fix (Seems to work really well, I think.)
autocmd("ModeChanged", {
	group = augroup("LuaSniptHistory"),
	pattern = "*",
	callback = function()
		if
			((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
			and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require("luasnip").session.jump_active
		then
			require("luasnip").unlink_current()
		end
	end,
})

-- vim.api.nvim_create_autocmd("WinLeave", {
-- 	callback = function()
-- 		if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
-- 			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
-- 		end
-- 	end,
-- })
