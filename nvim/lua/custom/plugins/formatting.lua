return {
  "stevearc/conform.nvim",
  event = {
    "BufReadPre",
    "BufNewFile"
  },
  opts = {
    formatters_by_ft = {
      javascript = { "eslint_ls" },
      typescript = { "eslint_ls" },
      typescriptreact = { "eslint_ls" },
      javascriptreact = { "eslint_ls" },
      css = { "eslint_ls" },
      html = { "eslint_ls" }
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 500
    }
  },
}
