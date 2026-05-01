return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },
  version = "^18.0.0",
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "Agent Actions" },
    { "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "Chat with Agent" },
  },
  opts = {
    interactions = {
      chat = {
        adapter = "copilot",
      },
      adapters = {
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              defaults = {
                auth_method = "oauth_personal",
                timeout = 5000,
              },
            })
          end,
        },
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
    },
  },
  dependencies = {
    "ravitemer/mcphub.nvim",
  },
}
