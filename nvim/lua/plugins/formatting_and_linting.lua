local langs = require 'langs'
return {
  {
    'mfussenegger/nvim-lint',
    opts = {
      events = {
        'BufWritePost',
        'BufReadPost',
        'InsertLeave',
      },
    },
    config = function(_, opts)
      local lint = require 'lint'
      local linters_by_ft = {}

      for _, value in pairs(langs) do
        local linters = value.linters
        local filetypes = value.filetypes
        if linters and filetypes then
          for _, file_type in pairs(filetypes) do
            linters_by_ft[file_type] = linters
          end
        end
      end

      lint.linters_by_ft = linters_by_ft

      local nvim_lint_au = vim.api.nvim_create_augroup('nvim_lint', { clear = true })
      vim.api.nvim_create_autocmd(opts.events, {
        group = nvim_lint_au,
        callback = require('utils').debounce(100, function()
          lint.try_lint()
        end),
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
    config = function(_, opts)
      local conform = require 'conform'
      local formatters_by_ft = {}

      for _, value in pairs(langs) do
        local formatters = value.formatters
        local filetypes = value.filetypes
        if formatters and filetypes then
          for _, file_type in pairs(filetypes) do
            formatters_by_ft[file_type] = formatters
          end
        end
      end

      opts.formatters_by_ft = formatters_by_ft

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
