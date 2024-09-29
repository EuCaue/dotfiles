-- get this from lazyvim :)
-- thanks.
local function expand_fix(snippet)
  local function snippet_replace(snippet, fn)
    return snippet:gsub("%$%b{}", function(m)
      local n, name = m:match("^%${(%d+):(.+)}$")
      return n and fn({ n = n, text = name }) or m
    end) or snippet
  end

  local function snippet_preview(snippet)
    local ok, parsed = pcall(function()
      return vim.lsp._snippet_grammar.parse(snippet)
    end)
    return ok and tostring(parsed)
      or snippet_replace(snippet, function(placeholder)
        return snippet_preview(placeholder.text)
      end):gsub("%$0", "")
  end

  local function snippet_fix(snippet)
    local texts = {} ---@type table<number, string>
    return snippet_replace(snippet, function(placeholder)
      texts[placeholder.n] = texts[placeholder.n] or snippet_preview(placeholder.text)
      return "${" .. placeholder.n .. ":" .. texts[placeholder.n] .. "}"
    end)
  end

  local function expand(snippet)
    local session = vim.snippet.active() and vim.snippet._session or nil
    local ok = pcall(vim.snippet.expand, snippet)
    if not ok then
      local fixed = snippet_fix(snippet)
      ok = pcall(vim.snippet.expand, fixed)
    end

    if session then
      vim.snippet._session = session
    end
  end
  expand(snippet)
end

return {
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  {
    "yioneko/nvim-cmp",
    branch = "perf-up",
    dependencies = {
      { "FelipeLema/cmp-async-path" },
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local function auto_brackets(entry)
        local Kind = cmp.lsp.CompletionItemKind
        local item = entry:get_completion_item()
        if vim.tbl_contains({ Kind.Function, Kind.Method }, item.kind) then
          local cursor = vim.api.nvim_win_get_cursor(0)
          local prev_char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
          if prev_char ~= "(" and prev_char ~= ")" then
            local keys = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
            vim.api.nvim_feedkeys(keys, "i", true)
          end
        end
      end
      cmp.event:on("confirm_done", function(event)
        auto_brackets(event.entry)
      end)
      return {
        snippet = {
          expand = function(args)
            expand_fix(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-2),
          ["<C-f>"] = cmp.mapping.scroll_docs(2),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        formatting = {
          expandable_indicator = true,
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            if vim.g.have_nerd_font then
              local mini_icon, hl, _ = require("mini.icons").get("lsp", vim_item.kind)
              local icon = mini_icon .. " "
              vim_item.kind = icon
              vim_item.kind_hl_group = hl
            end

            vim_item.menu = ({
              nvim_lsp = "",
              async_path = "",
              -- snippets = "",
              emoji = "",
              -- buffer = "",
            })[entry.source.name]
            return vim_item
          end,
        },
        sources = {
          { name = "nvim_lsp", priority = 150, group_index = 1, max_item_count=30 },
          { name = "async_path", priority = 150, group_index = 1 },
          { name = "snippets", priority = 10, max_item_count = 5,keyword_length=2 },
          { name = "emoji", priority = 0, group_index = 3 },
        },
        sorting = {
          priority_weight = 2,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = {
            border = vim.g.border_type,
            scrollbar = false,
          },
          documentation = {
            border = vim.g.border_type,
          },
        },
        experimental = {
          ghost_text = false,
        },
      }
    end,
  },
}
