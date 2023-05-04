local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	vim.notify("Plugin nvim-cmp not found", "error")
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	vim.notify("Plugin luasnip not found", "error")
	return
end

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip").log.set_loglevel("debug")
local icons = require("user.utils").icons

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function format(entry, item)
	-- Utils.
	local MAX_LABEL_WIDTH = 50
	local function whitespace(max, len)
		return (" "):rep(max - len)
	end

	-- Limit content width.
	local content = item.abbr
	if #content > MAX_LABEL_WIDTH then
		item.abbr = vim.fn.strcharpart(content, 0, MAX_LABEL_WIDTH) .. "…"
	else
		item.abbr = content .. whitespace(MAX_LABEL_WIDTH, #content)
	end

	-- Replace kind with icons.
	item.kind = (icons.kinds.icons[item.kind] or icons.kinds.icons.treesitter) .. "│"

	item.menu = ({
		nvim_lsp = "LSP",
		nvim_lua = "LUA",
		luasnip = "Snippet",
		emmet_vim = "Emeet",
		path = "Path",
		buffer = "Text",
		fonts = "Fonts",
		fish = "Fish",
		treesitter = "TS",
		crates = "Crates",
	})[entry.source.name]
	-- if entry.source.name == "treesitter" then
	-- 	item.kind = ""
	-- end

	return item
end

cmp.setup({
	--
	-- Snippet
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	-- Mappings
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
			-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = format,
		-- format = function(entry, vim_item)
		-- vim_item.kind = string.format("%s", icons.kinds.icons[vim_item.kind])
		-- vim_item.kind = string.format("%s %s", icons.kinds.icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
		-- 	-- 	-- vim_item.kind = string.format("%s %s", vim_item.kind, icons.kinds.icons[vim_item.kind]) -- This concatenates the icons with the name of the item kind
		-- 	vim_item.menu = ({
		-- 		nvim_lsp = "LSP",
		-- 		nvim_lua = "LUA",
		-- 		luasnip = "Snippet",
		-- 		emmet_vim = "Emeet",
		-- 		path = "Path",
		-- 		buffer = "Text",
		-- 		fonts = "Fonts",
		-- 		fish = "Fish",
		-- 		treesitter = "TS",
		-- 		crates = "Crates",
		-- 	})[entry.source.name]
		-- 	if entry.source.name == "treesitter" then
		-- 		vim_item.kind = ""
		-- 	end
		-- 	-- vim_item.menu = vim_item.kind
		-- 	-- vim_item.kind = icons.kinds.icons[vim_item.kind]
		--
		-- 	return vim_item
		-- end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 3 },
		-- { name = "cmp-tw2css" },
		{ name = "fish" },
		{ name = "fonts", option = { space_filter = "-" } },
		{ name = "markdown-link" },
		{ name = "emmet_vim" },
		-- { name = "treesitter" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered({
			border = "none",
			col_offset = -3,
			side_padding = 1,
			scrollbar = true,
			winhighlight = "Normal:Pmenu,FloatBorder:PmenuDocBorder,CursorLine:PmenuSel,Search:None",
		}),
		completion = cmp.config.window.bordered({
			scrollbar = true,
			winhighlight = "Normal:Pmenu,FloatBorder:PmenuDocBorder,CursorLine:PmenuSel,Search:None",
			col_offset = -3,
			side_padding = 1,
			border = "none",
		}),
	},
	experimental = {
		ghost_text = true,
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
