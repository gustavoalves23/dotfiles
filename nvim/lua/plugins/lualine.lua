return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      component_separators = { left = '', right = '|' },
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
      lualine_b = {
        {
          'branch',
          fmt = function(content)
            local ret = content:sub(1, 10)

            if #content > 10 then
              ret = ret .. '...'
            end
            return content
          end,
        },
        'diagnostics',
      },
      lualine_c = {
        {
          'filetype',
          icon_only = true,
        },
        {
          'filename',
          path = 1,
          fmt = function(content)
            if #content > 30 then
              local parts = vim.fn.split(content, '/')
              if #parts < 3 then
                return content
              end
              return parts[1] .. '/…/' .. parts[#parts - 1] .. '/' .. parts[#parts]
            end
            return content
          end,
        },
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
