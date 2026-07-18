return {
  'folke/snacks.nvim',
  opts = {
    notifier = {
      enabled = true,
      timeout = 3000,
      style = 'compact',
      -- Suppress noisy messages that nvim-notify previously filtered out.
      filter = function(notif)
        local banned_messages = { 'No information available' }
        for _, banned in ipairs(banned_messages) do
          if notif.msg == banned then
            return false
          end
        end
        return true
      end,
    },
  },
  init = function()
    local snacks = require 'snacks'
    vim.api.nvim_create_user_command('OpenInBrowser', function()
      snacks.gitbrowse()
    end, {})

    vim.api.nvim_create_user_command('ZenMode', function()
      snacks.zen()
    end, {})

    vim.keymap.set('n', '<leader>snd', function()
      snacks.notifier.hide()
    end, { desc = 'Dismiss notifications' })

    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end
    _G.bt = function()
      Snacks.debug.backtrace()
    end
    vim.print = _G.dd
  end,
}
