return {
  "kawre/leetcode.nvim",
  cmd = "Leet",
  build = ":TSUpdate html",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    arg = "leet",
    lang = "typescript",
    storage = {
      home = vim.uv.os_homedir() .. "/Code/leetcode",
    },
    injector = {
      ["rust"] = {
        before = { "#[allow(dead_code)]", "fn main(){}", "#[allow(dead_code)]", "struct Solution;" },
      }, ---@type table<lc.lang, lc.inject>
    },
    ---@type fun()[]
    hooks = {
      ---@type fun(question: lc.ui.Question)[]
      ["question_enter"] = {
        function(question)
          vim.cmd("wincmd h")
          vim.cmd("set wrap")
          vim.cmd("wincmd l")
          vim.keymap.set("n", "<leader>clr", "<cmd>Leet run<cr>", { desc = "run leetcode answer" })
          vim.keymap.set("n", "<leader>cls", "<cmd>Leet submit<cr>", { desc = "submit leetcode answer" })
          if question.lang ~= "rust" then
            return
          end
          local problem_dir = vim.uv.os_homedir() .. "/Code/leetcode/Cargo.toml"
          local content = [[
              [package]
              name = "leetcode"
              edition = "2021"
                                                                                                     
              [lib]
              name = "%s"
              path = "%s"
                                                                                                     
              [dependencies]
              rand = "0.8"
              regex = "1"
              itertools = "0.14.0"
            ]]
          local file = io.open(problem_dir, "w")
          if file then
            local formatted = (content:gsub(" +", "")):format(question.q.frontend_id, question:path())
            file:write(formatted)
            file:close()
          else
            print("Failed to open file: " .. problem_dir)
          end
        end,
      },
    },
    description = {
      width = "35%",
    },
    image_support = false,
  },
}
