local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
  history = true,
  region_check_events = "InsertEnter",
  updateevents = "TextChanged,TextChangedI",
  delete_check_events = "TextChanged,InsertLeave",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "Red" } },
      },
    },
  },
})

ls.filetype_extend("text", { "license" })
ls.filetype_extend("markdown", { "license" })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })
