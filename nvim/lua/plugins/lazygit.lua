return {
  'kdheepak/lazygit.nvim',
  cmd = { 'Lg', 'LazyGit' },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local lazygit = require 'lazygit'
    vim.api.nvim_create_user_command('Lg', function()
      lazygit.lazygit()
    end, {})
  end,
}
