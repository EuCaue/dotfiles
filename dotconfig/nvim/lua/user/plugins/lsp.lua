---@class LspCommand: lsp.ExecuteCommandParams
---@field handler? lsp.Handler
local function lsp_execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
end

local function lsp_action(action)
  return function()
    vim.lsp.buf.code_action({
      apply = true,
      context = {
        only = { action },
        diagnostics = {},
      },
    })
  end
end
---@param jumpCount number
local function jumpWithVirtLineDiags(jumpCount)
  pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags") -- prevent autocmd for repeated jumps

  vim.diagnostic.jump({ count = jumpCount })

  local initialVirtTextConf = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
  })

  vim.defer_fn(function() -- deferred to not trigger by jump itself
    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User(once): Reset diagnostics virtual lines",
      once = true,
      group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
      callback = function()
        vim.diagnostic.config({ virtual_lines = false, virtual_text = initialVirtTextConf })
      end,
    })
  end, 1)
end

return {
  {
    "mason-org/mason.nvim",
    lazy = true,
    cmd = "Mason",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    event = { "BufReadPre", "BufNewFile", "BufReadPost" },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile", "BufReadPost" },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", "BufReadPost" },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    dependencies = {},
    config = function()
      local icons = require("user.core.icons")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("custom-lsp-attach", {}),
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          local win = vim.api.nvim_get_current_win()
          if client and client:supports_method("textDocument/foldingRange") then
            vim.wo[win].foldexpr = "v:lua.vim.lsp.foldexpr()"
          else
            vim.wo[win].foldexpr = "v:lua.require'user.core.fold'.foldexpr()"
          end
          if client:supports_method("textDocument/completion") then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          end

          local map = function(modes, keys, func, desc)
            vim.keymap.set(modes, keys, func, { buffer = bufnr, desc = desc })
          end

          map("n", "K", function()
            vim.lsp.buf.hover()
          end, "hover")
          map("n", "gd", vim.lsp.buf.definition, "goto declaration")
          map("n", "gD", function()
            vim.cmd("vsplit")
            vim.lsp.buf.definition()
          end, "goto definition in vsplit")
          map("n", "gk", vim.lsp.buf.declaration, "goto declaration")
          map("n", "gr", vim.lsp.buf.references, "goto references")
          map("n", "<leader>cR", "<cmd>FzfLua lsp_references<cr>", "goto references with fzf")
          map("n", "gI", vim.lsp.buf.implementation, "goto implementation")
          map("n", "gy", vim.lsp.buf.type_definition, "goto type definition")
          map("n", "<leader>cr", vim.lsp.buf.rename, "code rename")
          map({ "n", "v", "x" }, "<leader>ca", vim.lsp.buf.code_action, "code action")

          map("n", "<leader>cl", "<cmd>LspInfo<cr>", "show lsp info")
          map("i", "<A-s>", function()
            vim.lsp.buf.signature_help()
          end, "show signature help")
          map("n", "<leader>k", function()
            local initialVirtTextConf = vim.diagnostic.config().virtual_text
            vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })

            vim.defer_fn(function()
              vim.api.nvim_create_autocmd("CursorMoved", {
                desc = "User(once): Reset diagnostics virtual lines",
                once = true,
                group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
                callback = function()
                  vim.diagnostic.config({ virtual_lines = false, virtual_text = initialVirtTextConf })
                end,
              })
            end, 1)
          end)
          map("n", "[d", function()
            jumpWithVirtLineDiags(-1)
          end, "Jump to the previous diagnostic in the current buffer")
          map("n", "]d", function()
            jumpWithVirtLineDiags(1)
          end, "Jump to the next diagnostic in the current buffer")
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("n", "<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
            end, "toggle inlay hints")
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
            map("n", "<leader>tc", function()
              vim.lsp.codelens.refresh({ bufnr = bufnr })
            end, "toggle code lens")
          end

          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          elseif client.name == "html" then
            client.server_capabilities.documentFormattingProvider = false
          end

          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          if client.name == "tailwindcss" then
            client.server_capabilities.completionProvider.triggerCharacters =
              { '"', "'", "`", ".", "(", "[", "!", "/", ":" }
          end
        end,
      })

      vim.diagnostic.config({
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 4,
          prefix = icons.misc.Point,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
        underline = { severity = vim.diagnostic.severity.ERROR },
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          -- border = vim.g.border_type,
          source = "if_many",
          header = "",
          prefix = "",
        },
      })
      -- require("lspconfig.ui.windows").default_options.border = vim.g.border_type
      -- vim.lsp.handlers["textDocument/definition"] = goto_definition("vsplit")
      local servers = {
        -- ts_ls = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.vimruntime,
                  "${3rd}/luv/library",
                  "${3rd}/busted/library",
                },
              },
            },
          },
        },
        pyright = {},
        ruff = {
          cmd_env = { RUFF_TRACE = "messages" },
          nit_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
        -- jedi_language_server = {},
        gopls = {},
        rust_analyzer = {},
        -- markdown_oxide = {},
        tailwindcss = {
          flags = { debounce_text_changes = 300 },
        },
        eslint = {},
        cssls = {},
        bashls = {
          filetypes = { "sh", "zsh" },
        },
        html = {},
        vtsls = {
          --  FIX: for some reason, `single_file_support` isn't working in vtsls 
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local project_root = require("lspconfig.util").root_pattern("tsconfig.json", "package.json", ".git")(fname)
            if project_root then
              on_dir(project_root)
            else
              on_dir(vim.fs.dirname(fname))
            end
          end,
          settings = {
            complete_functions_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
        jsonls = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua",
        "markdownlint",
        "shellcheck",
        "prettier",
        "shfmt",
      })

      require("mason").setup({
        ui = {
          icons = {
            package_installed = icons.ui.Check,
            package_pending = icons.ui.ArrowCircleRight,
            package_uninstalled = icons.ui.Close,
          },
        },
        max_concurrent_installers = 10,
      })
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      for server, cfg in pairs(servers) do
        cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end
    end,
  },
}
