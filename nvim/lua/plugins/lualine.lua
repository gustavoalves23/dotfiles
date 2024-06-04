local slow_format_filetypes = require('utils').slow_format_filetypes
return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'AndreM222/copilot-lualine'
  },
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
        {
          'mode',
          color = {
            gui = 'bold',
          },
        },
      },
      lualine_b = { {
        'branch',
        fmt = function(content)
          return content:sub(1, 10)
        end
      }, 'diagnostics', {
        'macro-recording',
        fmt = require('utils').show_macro_recording,
      } },
      lualine_c = {
        {
          'filename',
          path = 1,
          fmt = function(content)
            if #content > 50 then
              local parts = vim.fn.split(content, '/')
              local last = parts[#parts]

              local path = ''

              for i = 1, #parts - 1 do
                path = path .. parts[i]:sub(1, 3)

                if #parts[i] > 3 then
                  path = path .. '..'
                end

                path = path .. '/'
              end

              return path .. last
            end
            return content
          end
        },
      },
      lualine_x = {
        {
          'formatting_status',
          fmt = function()
            if slow_format_filetypes[vim.bo.filetype] then
              return ''
            end

            return ''
          end,
        },

        'copilot',
        'encoding',
        'fileformat',
        'filetype',
      },
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
