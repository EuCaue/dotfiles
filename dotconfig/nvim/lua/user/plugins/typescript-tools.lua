return {
  "pmizio/typescript-tools.nvim",
  ft = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {
    setttings = {
      jsx_close_tag = {
        enable = true,
      },
    },
  },
}
