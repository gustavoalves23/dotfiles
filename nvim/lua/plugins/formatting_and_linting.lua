local langs = require 'langs'
local slow_format_filetypes = require('utils').slow_format_filetypes
return {
  {
    'mfussenegger/nvim-lint',
    opts = {
      events = {
        'BufWritePost',
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
            local linters_name = {}

            for _, linter in pairs(linters) do
              if type(linter) == 'string' then
                table.insert(linters_name, linter)
              else
                table.insert(linters_name, linter.name)
              end
            end

            linters_by_ft[file_type] = linters_name
          end
        end
      end

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
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
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
    end,
  },
}
