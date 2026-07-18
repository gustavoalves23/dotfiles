return {
  'folke/snacks.nvim',
  opts = {
    bigfile = {
      enabled = true,
      size = 0.5 * 1024 * 1024,
    },
    indent = {
      enabled = true,
      indent = {
        char = '│',
      },
      scope = { enabled = false },
    },
    words = {
      enabled = true,
      debounce = 0,
    },
    lazygit = {
      enabled = true,
    },
    notifier = {
      enabled = true,
      timeout = 3000,
      style = 'compact',
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

    vim.api.nvim_create_user_command('Lg', function()
      snacks.lazygit()
    end, {})
    vim.api.nvim_create_user_command('LazyGit', function()
      snacks.lazygit()
    end, {})

    vim.keymap.set('n', '[[', function()
      snacks.words.jump(-vim.v.count1)
    end, { noremap = true, silent = true, desc = 'Previous symbol match' })
    vim.keymap.set('n', ']]', function()
      snacks.words.jump(vim.v.count1)
    end, { noremap = true, silent = true, desc = 'Next symbol match' })

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
