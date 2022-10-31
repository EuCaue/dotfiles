require("null-ls").setup({
	sources = {
		-- NOTE: FORMATTING
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.codespell,
		require("null-ls").builtins.formatting.eslint,
		require("null-ls").builtins.formatting.semistandardjs,
		require("null-ls").builtins.formatting.markdownlint,
		require("null-ls").builtins.formatting.prettier.with({
			extra_args = { "semi", "--single-quote", "--jsx-single-quote" },
		}),

		-- NOTE: diagnostics
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.diagnostics.codespell,
		require("null-ls").builtins.diagnostics.fish,
		require("null-ls").builtins.diagnostics.markdownlint,
		require("null-ls").builtins.diagnostics.semistandardjs,

		-- NOTE: completion
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.completion.tags,
		require("null-ls").builtins.completion.luasnip,

		-- NOTE: code_actions
		require("null-ls").builtins.code_actions.eslint,
	},
})
