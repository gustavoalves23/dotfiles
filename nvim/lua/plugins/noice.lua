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
  },
  keys = {
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
