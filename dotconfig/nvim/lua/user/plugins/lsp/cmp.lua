local cmp = require("cmp")
local utils = require("user.utils")

local luasnip = require("luasnip")

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip").log.set_loglevel("debug")
local icons = require("user.utils").icons_selected

local function format(entry, item)
  item.menu = item.kind .. "" or ""
  item.kind = (icons[item.kind] or icons.treesitter) -- .. "│"

  if entry.source.name == "fonts" then
    item.kind = "󰞂 " -- .. "│"
  end

  if entry.source.name == "codeium" then
    item.kind = "󰚩 " --  .. "│"
  end

  return item
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  -- Snippet
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Mappings
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-k>"] = cmp.mapping({
      i = function()
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end,
    }),

    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),

    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function()
      luasnip.expand_or_jump()
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
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
    { name = "nvim_lsp", group_index = 1, priority = 10 },
    { name = "codeium", max_item_count = 7, group_index = 1 },
    { name = "copilot", group_index = 1 },
    { name = "async_path", max_item_count = 7, group_index = 1 },
    { name = "luasnip", max_item_count = 5, group_index = 1 },
    { name = "buffer", keyword_length = 3, group_index = 2 },
    { name = "fish" },
    { name = "fonts", option = { space_filter = "-" } },
  },

  performance = {
    trigger_debounce_time = 500,
    throttle = 550,
    fetching_timeout = 80,
  },

  sorting = {
    priority_weight = 2,
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
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
