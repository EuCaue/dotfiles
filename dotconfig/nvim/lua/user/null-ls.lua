require("null-ls").setup({
	diagnostics_format = "[#{c}] #{m} (#{s})",
	temp_dir = "/home/caue/nothing/",
	sources = {
		-- NOTE: FORMATTING
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.codespell,
		require("null-ls").builtins.formatting.fish_indent,
		-- require("null-ls").builtins.formatting.tidy,
		require("null-ls").builtins.formatting.black,
		-- require("null-ls").builtins.formatting.eslint_d,
		require("null-ls").builtins.formatting.markdownlint,
		require("null-ls").builtins.formatting.prettier,

		-- NOTE: diagnostics
		-- require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.diagnostics.codespell,
		require("null-ls").builtins.diagnostics.fish,
		require("null-ls").builtins.diagnostics.luacheck.with({ extra_args = { "-g vim" } }),
		require("null-ls").builtins.diagnostics.proselint,
		-- require("null-ls").builtins.diagnostics.shellcheck,
		require("null-ls").builtins.diagnostics.markdownlint,
		require("null-ls").builtins.diagnostics.jsonlint,
		-- require("null-ls").builtins.diagnostics.tidy,
		require("null-ls").builtins.diagnostics.mypy,
		-- require("null-ls").builtins.diagnostics.todo_comments,
		-- require("null-ls").builtins.diagnostics.ltrs,

		-- NOTE: completion

		-- require("null-ls").builtins.completion.spell,

		-- NOTE: code_actions
		-- require("null-ls").builtins.code_actions.eslint_d,
		-- require("null-ls").builtins.code_actions.shellcheck,
		require("null-ls").builtins.code_actions.proselint,

		-- NOTE: hover
		require("null-ls").builtins.hover.dictionary,
		require("null-ls").builtins.hover.printenv,
	},
})
