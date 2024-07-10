return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  opts = {
    stages = 'static',
    timeout = 3000,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  config = function(_, opts)
    local notify = require 'notify'
    notify.setup(opts)

    local banned_messages = { 'No information available' }
    vim.notify = function(msg, ...)
      for _, banned in ipairs(banned_messages) do
        if msg == banned then
          return
        end
      end
      return notify(msg, ...)
    end
    vim.keymap.set('n', '<leader>snd', notify.dismiss)
  end,
}
