local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Plugin nvim-lspconfig not found", "error")
  return
end

local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local utils = require("user.utils")
local icons = utils.icons
local rt = require("rust-tools")
local cr = require("crates")
local ts = require("typescript")
require("user.plugins.lsp.lsp-commands")
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- vim.o.updatetime = 250
-- vim.cmd([[autocmd! CursorHold,CursorHoldI * :lua vim.lsp.buf.signature_help()]])

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local function get_opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, get_opts("Line diagnostic"))
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, get_opts("Jump to prev diagnostic"))
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, get_opts("Jump to next diagnostic"))
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, get_opts("Diagnostics loclist"))

local on_attach = function(client, bufnr) -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  require("lsp-inlayhints").on_attach(client, bufnr)
  local function get_bufopts(desc)
    return { noremap = true, silent = true, buffer = bufnr, desc = desc }
  end

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, get_bufopts("Go to declaration"))
  vim.keymap.set("n", "<leader><leader><leader>l", "<cmd>LspCommands<cr>", get_opts("Open Lsp Commands"))
  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", get_bufopts("Go to definitions"))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, get_bufopts("Hover documentation"))
  vim.keymap.set("n", "<leader><leader>r", "<cmd>LspRestart<cr>", get_bufopts("Restart LSP"))
  vim.keymap.set("n", "<space>o", "<cmd>Navbuddy<CR>", get_bufopts("Outline Icons"))
  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", get_bufopts("Go to implementations"))
  vim.keymap.set("n", "<space>l", vim.lsp.buf.signature_help, get_bufopts("Signature help"))
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, get_bufopts("Add workspace folder"))
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, get_bufopts("Remove workspace folder"))
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, get_bufopts("List workspace folders"))
  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", get_bufopts("Go to type definition"))
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, get_bufopts("LSP Rename"))
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, get_bufopts("Code action"))
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", get_bufopts("References"))
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, get_bufopts("LSP Format"))

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
    navbuddy.attach(client, bufnr)
  end

  if client.name == "eslint" then
    client.server_capabilities.documentFormattingProvider = true
  elseif client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

for _, lsp in ipairs(utils.servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    completions = {
      completeFunctionCalls = true,
    },
  })
end

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  completions = {
    completeFunctionCalls = true,
  },
  filetypes = { "sh", "zsh", "fish" },
})

lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  completions = {
    completeFunctionCalls = true,
  },
  root_dir = lspconfig.util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.cjs",
    "postcss.config.ts"
  ),
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  completions = {
    completeFunctionCalls = true,
  },
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
  },
})

rt.setup({
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      vim.keymap.set("n", "K", rt.hover_actions.hover_actions, get_opts("Rust Tools Hover"))
      vim.keymap.set(
        "n",
        "<leader>ca",
        rt.code_action_group.code_action_group,
        get_opts("Rust Tools Code Action")
      )
      vim.keymap.set("n", "<leader>rtr", rt.runnables.runnables, get_opts("Rust Tools Runnables"))
      vim.keymap.set(
        "n",
        "<leader>rtoc",
        rt.open_cargo_toml.open_cargo_toml,
        get_opts("Rust Tools Open Cargo Toml")
      )
      vim.keymap.set("n", "<leader>rtj", rt.join_lines.join_lines, get_opts("Rust Tools Join Lines"))
      vim.keymap.set("n", "<leader>rtuc", cr.update_crate, get_opts("Update Create"))
      vim.keymap.set("n", "<leader>rtuca", cr.update_all_crates, get_opts("Update All Create"))
      vim.keymap.set("n", "<leader>rtod", cr.open_documentation, get_opts("Open create documentation"))
      vim.keymap.set("n", "<leader>rtp", cr.show_popup, get_opts("Show Create Pop Up"))
      vim.keymap.set("n", "<leader>rtub", cr.update, get_opts("Update Data"))

      rt.inlay_hints.enable()

      navic.attach(client, bufnr)
      navbuddy.attach(client, bufnr)
    end,
  },
})

ts.setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false,            -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true,        -- fall back to standard LSP definition on failure
  },
  server = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- require("lsp-inlayhints").on_attach(client, bufnr)
      vim.keymap.set(
        "n",
        "<leader>tmi",
        ts.actions.addMissingImports,
        get_opts("Typescript Add Missing Imports ")
      )
      vim.keymap.set("n", "K", vim.lsp.buf.hover, get_opts("LSP HOVER"))
      vim.keymap.set("n", "<leader>toi", ts.actions.organizeImports, get_opts("Typescript Organize Imports"))
      vim.keymap.set("n", "<leader>tru", ts.actions.removeUnused, get_opts("Typescript Remove Unused"))
      vim.keymap.set("n", "<leader>tfa", ts.actions.fixAll, get_opts("Typescript Fix All"))
      vim.keymap.set("n", "<leader>trf", "<cmd>TypescriptRenameFile<cr>", get_opts("Typescript Rename File"))
      vim.keymap.set("n", "gd", ts.goToSourceDefinition, get_opts("Typescript Go To Source definition"))
    end,
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },

      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
})

local signs =
{ Error = icons.ui.lsp_error, Warn = icons.ui.lsp_warn, Hint = icons.ui.lsp_hint, Info = icons.ui.lsp_info }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  float = {
    border = utils.border_status,
    focusable = true,
    -- style = "minimal",
    source = "always",
    header = "",
    prefix = "  ",
  },
  virtual_text = {
    -- prefix = "󱨇 ",
    prefix = " ",
  },
  signs = true,
  underline = false,
  update_in_insert = true,
  severity_sort = false,
})
