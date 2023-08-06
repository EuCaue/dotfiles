local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  vim.notify("Plugin null-ls not found", "error")
  return
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local async_formatting = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  vim.lsp.buf_request(
    bufnr,
    "textDocument/formatting",
    vim.lsp.util.make_formatting_params({}),
    function(err, res, ctx)
      if err then
        local err_msg = type(err) == "string" and err or err.message
        -- you can modify the log message / level (or ignore it completely)
        vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
        return
      end

      -- don't apply results if buffer is unloaded or has been modified
      if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
        return
      end

      if res then
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("silent noautocmd update")
        end)
      end
    end
  )
end

null_ls.setup({
  diagnostics_format = "[#{c}] #{m} (#{s})",
  temp_dir = "/home/caue/nothing/",
  on_attach = function(client, bufnr)
    -- vim.notify(client)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        async_formatting(bufnr)
      end,
    })
  end,
  sources = {
    -- NOTE: FORMATTING
    -- require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.fish_indent,
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.markdownlint,
    require("null-ls").builtins.formatting.gofumpt,
    require("null-ls").builtins.formatting.goimports,
    require("null-ls").builtins.formatting.golines,
    require("null-ls").builtins.formatting.prettier.with({
      extra_args = { "--single-attribute-per-line" },
    }),

    -- NOTE: diagnostics
    require("null-ls").builtins.diagnostics.codespell,
    require("null-ls").builtins.diagnostics.fish,
    require("null-ls").builtins.diagnostics.luacheck.with({ extra_args = { "-g vim" } }),
    -- require("null-ls").builtins.diagnostics.proselint,
    -- require("null-ls").builtins.diagnostics.write_good,
    require("null-ls").builtins.diagnostics.markdownlint,
    require("null-ls").builtins.diagnostics.jsonlint,
    require("null-ls").builtins.diagnostics.mypy,

    -- NOTE: completion

    -- require("null-ls").builtins.completion.spell,
    -- NOTE: code_actions
    require("null-ls").builtins.code_actions.proselint,

    -- NOTE: hover
    require("null-ls").builtins.hover.dictionary,
    require("null-ls").builtins.hover.printenv,

    require("typescript.extensions.null-ls.code-actions"),
  },
})
