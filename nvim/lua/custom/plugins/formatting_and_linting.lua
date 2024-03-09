-- return {
--   'nvimtools/none-ls.nvim',
--   config = function()
--     local null_ls = require('null-ls')
--
--     null_ls.setup({
--       sources = {
--         -- JS/TS
--         null_ls.builtins.diagnostics.eslint_d,
--         null_ls.builtins.formatting.eslint_d,
--         -- JS/TS
--         --LUA
--         null_ls.builtins.formatting.stylua,
--         --LUA
--         --CSS
--         -- null_ls.builtins.diagnostics.stylelint,
--         -- null_ls.builtins.formatting.stylelint,
--         --CSS
--       },
--     })
--   end,
-- }

return {
  {
    'mfussenegger/nvim-lint',
    opts = {
      events = {
        'BufWritePost',
        'BufReadPost',
        'InsertLeave',
        -- 'TextChanged', -- uncomment this line if want to lint on every change on the file text (may increase CPU consumption)
      },
      linters_by_ft = {
        typescript = { 'eslint_d' },
      },
    },
    config = function(_, opts)
      local lint = require 'lint'
      lint.linters_by_ft = opts.linters_by_ft

      local nvim_lint_au = vim.api.nvim_create_augroup('nvim_lint', { clear = true })
      vim.api.nvim_create_autocmd(opts.events, {
        group = nvim_lint_au,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typescript = { 'eslint_d' },
        lua = { 'stylua' },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
    config = function(_, opts)
      local conform = require 'conform'
      conform.setup(opts)
      local nvim_format_au = vim.api.nvim_create_augroup('nvim_format', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = nvim_format_au,
        callback = function(args)
          conform.format { bufnr = args.buf }
        end,
      })
    end,
  },
}
