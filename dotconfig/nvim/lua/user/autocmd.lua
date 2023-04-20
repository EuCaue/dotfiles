vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 80 })
	end,
})

-- Autoformat
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = true })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
	callback = function()
		local root_dir = vim.fn.getcwd()
		local eslint_config_path = vim.fn.expand(root_dir .. "/.eslintrc.cjs")
		local eslint_config_exists = vim.loop.fs_stat(eslint_config_path)
		if eslint_config_exists ~= nil then
			vim.cmd("EslintFixAll")
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "styled.js" },
	callback = function()
		vim.cmd([[TSBufDisable highlight]])
	end,
})

function leave_snippet()
	if
		((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
		and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
		and not require("luasnip").session.jump_active
	then
		require("luasnip").unlink_current()
	end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = { "*" },
	callback = function()
		vim.cmd([[lua leave_snippet()]])
	end,
})


