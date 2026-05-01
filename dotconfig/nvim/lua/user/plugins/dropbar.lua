return {
  "Bekaboo/dropbar.nvim",
  event = { "LspAttach" },
  config = function()
    local dropbar_api = require("dropbar.api")
    local map = require("user.core.helpers").map
    map("n", "<leader>cc", dropbar_api.pick, { desc = "code context" })
    map("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    map("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
  end,
}
