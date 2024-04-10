return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      component_separators = '|',
      section_separators = { left = '', right = '' },
      disabled_filetypes = { 'Trouble', 'oil' },
    },
    sections = {
      lualine_a = {
        { 'mode', color = {
          gui = 'bold',
        } },
      },
      lualine_b = { 'branch', 'diagnostics', {
        'macro-recording',
        fmt = require('custom.utils').show_macro_recording,
      } },
      lualine_c = { {
        'filename',
        path = 1,
      } },
    },
  },
  config = function(_, opts)
    local lualine = require 'lualine'
    lualine.setup(opts)
    vim.api.nvim_create_autocmd('RecordingEnter', {
      callback = function()
        lualine.refresh {
          place = { 'statusline' },
        }
      end,
    })

    vim.api.nvim_create_autocmd('RecordingLeave', {
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh {
              place = { 'statusline' },
            }
          end)
        )
      end,
    })
  end,
}
