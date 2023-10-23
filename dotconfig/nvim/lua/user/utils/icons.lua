local M = {}

M.icons = {
	kinds = {
		new = {
			Text = "󰉿 ",
			Method = "󰆧 ",
			Function = "󰊕 ",
			Constructor = " ",
			Field = "󰜢 ",
			Variable = " ",
			Class = "󰠱 ",
			Interface = " ",
			Module = " ",
			Property = "󰜢 ",
			Unit = "󰑭 ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Color = "󰏘 ",
			File = "󰈙 ",
			Reference = "󰈇 ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = "󰙅 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = " ",
		},

		kind_icons = {
			Array = " ",
			Boolean = " ",
			Text = " ",
			Method = "󰆧 ",
			Function = "󰊕 ",
			Constructor = " ",
			Field = "󰇽 ",
			Variable = "󰂡 ",
			Class = "󰠱 ",
			Interface = " ",
			Module = " ",
			Null = "󰟢 ",
			Property = "󰜢 ",
			Unit = " ",
			Value = "󰎠 ",
			Enum = " ",
			Key = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Package = " ",
			Color = "󰏘 ",
			File = "󰈙 ",
			Reference = " ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = " ",
			Object = " ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰅲 ",
		},

		codicons = {
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = " ",
			Module = " ",
			Property = " ",
			Unit = " ",
			Value = " ",
			Enum = " ",
			Keyword = " ",
			Snippet = " ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			EnumMember = " ",
			Constant = " ",
			Struct = " ",
			Event = " ",
			Operator = " ",
			TypeParameter = " ",
		},

		icons_icons = {
			Text = "󰉿 ",
			Method = "m ",
			Function = "󰊕 ",
			Constructor = " ",
			Field = " ",
			Variable = "󰆧 ",
			Class = "󰌗 ",
			Interface = " ",
			Module = " ",
			Property = " ",
			Unit = " ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Color = "󰏘 ",
			File = "󰈙 ",
			Reference = " ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰇽 ",
			Struct = " ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
		},

		icons_2 = {
			Text = "󰉿 ",
			Method = "󰆧 ",
			Function = "󰊕 ",
			Constructor = " ",
			Field = "󰜢 ",
			Variable = " ",
			Class = "󰠱 ",
			Interface = " ",
			Module = "󰅩 ",
			Property = "󰜢 ",
			Unit = "󰑭 ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Color = "󰏘 ",
			File = "󰈙 ",
			Reference = "󰈇 ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = "󰙅 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = " ",
		},

		nvchad = {
			Namespace = "󰌗 ",
			Text = "󰉿 ",
			Method = "󰆧 ",
			Function = "󰆧 ",
			Constructor = " ",
			Field = "󰜢 ",
			Variable = "󰀫 ",
			Class = "󰠱 ",
			Interface = " ",
			Module = " ",
			Property = "󰜢 ",
			Unit = "󰑭 ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Color = "󰏘 ",
			File = "󰈚 ",
			Reference = "󰈇 ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = "󰙅 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
			Table = " ",
			Object = "󰅩 ",
			Tag = " ",
			Array = "[] ",
			Boolean = " ",
			Number = " ",
			Null = "󰟢 ",
			String = "󰉿 ",
			Calendar = " ",
			Watch = "󰥔 ",
			Package = " ",
			Copilot = " ",
			Codeium = " ",
			TabNine = " ",
		},

		custom_icons = {
			Text = " ",
			Method = " ",
			Function = "󰊕 ",
			Constructor = "⌘ ",
			Field = "󰜢 ",
			Variable = "󰈜 ",
			Class = "󰠱 ",
			Interface = " ",
			Module = "󰏓 ",
			Property = "󰜢 ",
			Unit = "󰑭 ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰔌 ",
			Snippet = "󰅱 ",
			Color = "󰏘 ",
			File = "󰈙 ",
			Reference = "󰈇 ",
			Folder = " ",
			EnumMember = " ",
			Constant = "󰐀 ",
			Struct = "󰙅 ",
			Event = " ",
			treesitter = " ",
			Operator = "󰆕 ",
			TypeParameter = " ",
			fonts = " ",
		},
	},
	ui = {
		file = "󰈔",
		files = "󰈢",
		folder = "󰉖",
		folders = "󰉓",
		open_folder = "󰝰",
		empty_folder = "󰉖",
		project_folder = "󰀼",
		buffers = "󰈙",
		restore = "󰦛",
		config = "󰒓",
		close = "󰅚",
		buffer_close = "󰅖",
		modified_buffer = "●",
		arrow_right_out = "󰧂",
		arrow_right = "󰁔",
		arrow_left = "",
		arrow_left_out = "󰧀",
		double_chevron = "󰄾",
		chevron = "󰅂",
		lsp_error = "󰅙 ",
		lsp_warn = "󰀦 ",
		lsp_hint = "󰌵 ",
		lsp_info = "󰋼 ",
		powerline_round_right = "",
		powerline_round_left = "",
		powerline_square_right = " ",
		powerline_square_left = " ",
		mode_icon = "󰀘 ",
		modified = "󰜄 ",
		plus_square = "󰜄",
		minus_square = "󰛲",
		empty = "󱋭",
		new = "󰎔",
		prompt_prefix = "󰋇 ",
		selection_caret = " ",
	},
	git = {
		git = "󰊢 ",
		add = "󰐙 ",
		change = "󰐙 ",
		delete = "󰍷 ",
		unstaged = "● ",
		modified = "  ",
		renamed = "󱦰 ",
		ignored = "◌",
		conflict = "",
		staged = "S",
		untracked = "U",
	},
}

return M
