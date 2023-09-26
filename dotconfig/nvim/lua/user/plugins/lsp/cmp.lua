local cmp_status_ok, cmp = pcall(require, "cmp")
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local utils = require("user.utils")
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
local icons = require("user.utils").icons_selected

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function format(entry, item)
	-- Utils.
	local MAX_LABEL_WIDTH = 30
	local function whitespace(max, len)
		return (" "):rep(max - len)
	end
	-- Limit content width.

	-- Replace kind with icons.
	-- item.kind = (icons[item.kind] or icons.treesitter) -- .. "│"
	-- item.kind = string.format("%s %s", icons[item.kind], item.kind) -- This concatenates the icons with the name of the item kind
	-- item.kind = string.format("%s", icons[item.kind])

	-- item.menu = ({
	--   nvim_lsp = "lsp",
	--   nvim_lua = "lua",
	--   luasnip = "snippet",
	--   path = "path",
	--   buffer = "text",
	--   fonts = "fonts",
	--   fish = "fish",
	--   codeium = "ia",
	--   treesitter = "ts",
	--   crates = "crates",
	--
	-- })[entry.source.name]
	item.menu = item.kind .. "" or ""
	item.kind = (icons[item.kind] or icons.treesitter) -- .. "│"

	if entry.source.name == "fonts" then
		item.kind = " " -- .. "│"
	end

	if entry.source.name == "codeium" then
		item.kind = "󰘦 " --  .. "│"
	end

	return item
end

-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
cmp.setup({
	preselect = cmp.PreselectMode.None,
	-- Snippet
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	-- Mappings
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
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
			luasnip.expand_or_jump()
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			luasnip.jump(-1)
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = format,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "codeium", max_item_count = 5},
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "buffer", keyword_length = 3 },
		{ name = "fish" },
		{ name = "fonts", option = { space_filter = "-" } },
	},

	sorting = {
		comparators = {
			cmp.config.compare.sort_text, -- this needs to be 1st
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered({
			border = utils.border_status,
			col_offset = -3,
			side_padding = 1,
			scrollbar = false,
			winhighlight = "Normal:Pmenu,FloatBorder:PmenuDocBorder,CursorLine:PmenuSel,Search:None",
		}),
		completion = cmp.config.window.bordered({
			scrollbar = false,
			winhighlight = "Normal:Pmenu,FloatBorder:PmenuDocBorder,CursorLine:PmenuSel,Search:None",
			col_offset = -3,
			side_padding = 1,
			border = utils.border_status,
		}),
	},
	experimental = {
		ghost_text = true,
	},
})
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- cmp.setup.filetype({ "fish" },
--   { sources = { { name = "fish" } } })

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
