-- Integration with tmux / kitty
local _in_tmux = vim.env.TMUX ~= nil
local _in_kitty = not _in_tmux and vim.env.KITTY_LISTEN_ON ~= nil

return {
  {
    'smart-splits-nvim/smart-splits.nvim',
    version = '^3.0.0',
    lazy = false,
    cond = _in_tmux or _in_kitty,
    opts = {
      mux = { backend = _in_kitty and 'smart-splits-backend-kitty' or 'smart-splits-backend-tmux' },
      move = { at_edge = 'stop' },
    },
    dependencies = {
      { 'smart-splits-nvim/backend-tmux', main = 'smart-splits-backend-tmux' },
      { 'smart-splits-nvim/backend-kitty', main = 'smart-splits-backend-kitty' },
    },
    config = function(_, opts)
      require('smart-splits').setup(opts)
      local s = require 'smart-splits'
      vim.keymap.set('n', '<C-h>', s.move_cursor_left)
      vim.keymap.set('n', '<C-j>', s.move_cursor_down)
      vim.keymap.set('n', '<C-k>', s.move_cursor_up)
      vim.keymap.set('n', '<C-l>', s.move_cursor_right)
      vim.keymap.set('n', '<M-h>', s.resize_left)
      vim.keymap.set('n', '<M-j>', s.resize_down)
      vim.keymap.set('n', '<M-k>', s.resize_up)
      vim.keymap.set('n', '<M-l>', s.resize_right)
    end,
  },
}
