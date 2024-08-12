local utils = require 'utils'
local langs = require 'langs'
local slow_format_filetypes = require('utils').slow_format_filetypes

local linters_by_ft, lint_file_types = utils.get_linters_by_ft(langs)
local formatters_by_ft, format_file_types = utils.get_formatters_by_ft(langs)

return {
  {
    'mfussenegger/nvim-lint',
    ft = lint_file_types,
    opts = {
      events = {
        'BufWritePost',
      },
    },
    config = function(_, opts)
      local lint = require 'lint'
      lint.linters_by_ft = linters_by_ft
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
    ft = format_file_types,
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local conform = require 'conform'
        if #conform.list_formatters_to_run(bufnr) == 0 then
          return
        end

        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        local function on_format(err)
          if err and err:match 'timeout$' then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
            vim.notify('Formatting is taking too long, enabling async formatting.', vim.log.levels.INFO)
          end
        end

        return { timeout_ms = 200, lsp_fallback = false }, on_format
      end,

      format_after_save = function(bufnr)
        local conform = require 'conform'
        if #conform.list_formatters_to_run(bufnr) == 0 then
          return
        end

        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_fallback = false }
      end,
    },
    config = function(_, opts)
      local conform = require 'conform'
      opts.formatters_by_ft = formatters_by_ft
      conform.setup(opts)
    end,
  },
}
