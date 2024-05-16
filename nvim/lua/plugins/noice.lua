return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      "rcarriga/nvim-notify",
      event = "VeryLazy",
      opts = {
        stages = "static",
        timeout = 3000,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end
      },
    }
  },
  opts = {
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = true,
    },
    views = {
      mini = {
        position = {
          row = 1,
          col = "100%",
        },
      },
    },
    lsp = {
      hover = {
        silent = true,
      },
      progress = {
        enabled = true,
        format = 'lsp_progress',
        format_done = {
          { '󰄬 ', hl_group = 'NoiceLspProgressSpinner' },
          { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
          { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
        },
        throttle = 1000 / 30,
        view = 'mini',
      }
    }
  },
  config = function(_, opts)
    require('noice').setup(opts)
    require('telescope').load_extension 'noice'
  end,
  keys = {
    {
      '<leader>snh',
      function()
        require('noice').cmd 'telescope'
      end,
      desc = 'Noice Notification History',
    },
    {
      '<leader>snl',
      function()
        require('noice').cmd 'last'
      end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>snd',
      function()
        require('noice').cmd 'dismiss'
      end,
      desc = 'Dismiss All',
    },
  }
}
