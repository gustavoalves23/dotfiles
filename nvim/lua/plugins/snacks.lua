return {
  'folke/snacks.nvim',
  lazy = true,
  cmd = { 'OpenOnBrowser', 'ZenMode' },
  init = function()
    local snacks = require 'snacks'
    vim.api.nvim_create_user_command('OpenOnBrowser', function()
      snacks.gitbrowse()
    end, {})

    vim.api.nvim_create_user_command('ZenMode', function()
      snacks.zen()
    end, {})
  end,
}
