return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local ensure_installed = {
      "bash",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "toml",
      "yaml",
      "css",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "diff",
      "dockerfile",
      "editorconfig",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
    }
    local ts = require("nvim-treesitter")
    ts.install(ensure_installed, { max_jobs = 8 })

    local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

    local ignore_filetypes = {
      "checkhealth",
      "alpha",
      "fzf",
      "blink-cmp-menu",
      "lazy",
      "lazy_backdrop",
      "fidget",
      "mason",
      "mason_backdrop",
      "snacks_dashboard",
      "snacks_notif",
      "snacks_win",
    }

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      desc = "Enable treesitter highlighting and indentation",
      callback = function(event)
        if vim.tbl_contains(ignore_filetypes, event.match) then
          return
        end

        local lang = vim.treesitter.language.get_lang(event.match) or event.match
        local buf = event.buf

        -- Start highlighting immediately (works if parser exists)
        pcall(vim.treesitter.start, buf, lang)

        -- Enable treesitter indentation
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Install missing parsers (async, no-op if already installed)
        ts.install({ lang })
      end,
    })
  end,
}
