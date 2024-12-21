return {
  'folke/snacks.nvim',
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

    _G.dd = function(...)
      Snacks.debug.inspect(...)
    end
    _G.bt = function()
      Snacks.debug.backtrace()
    end
    vim.print = _G.dd
  end,
}
