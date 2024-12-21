return {
  'folke/snacks.nvim',
  lazy = true,
  cmd = { 'OpenOnBrowser', 'ZenMode', 'Lg' },
  init = function()
    local snacks = require 'snacks'
    vim.api.nvim_create_user_command('OpenOnBrowser', function()
      snacks.gitbrowse()
    end, {})

    vim.api.nvim_create_user_command('Lg', function()
      snacks.lazygit()
    end, {})

    vim.api.nvim_create_user_command('ZenMode', function()
      snacks.zen()
    end, {})
  end,
}
