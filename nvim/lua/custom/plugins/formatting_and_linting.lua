return {
  {
    'mfussenegger/nvim-lint',
    opts = {
      events = {
        'BufWritePost',
        'BufReadPost',
        'InsertLeave',
      },
      linters_by_ft = {
        typescript = { 'biomejs' },
      },
    },
    config = function(_, opts)
      local lint = require 'lint'
      lint.linters_by_ft = opts.linters_by_ft

      local nvim_lint_au = vim.api.nvim_create_augroup('nvim_lint', { clear = true })
      vim.api.nvim_create_autocmd(opts.events, {
        group = nvim_lint_au,
        callback = require('custom.utils').debounce(100, function()
          lint.try_lint()
        end),
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        typescript = {
          'biome',
        },
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
