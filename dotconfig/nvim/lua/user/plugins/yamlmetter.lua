return {
  "ray-x/yamlmatter.nvim",
  enabled=false,
  ft = "yaml",
  cmd = "YamlMatter",
  event = {
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/Documents/vault/zk/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/vault/zk/*.md",
  },
  opts = {},
}
