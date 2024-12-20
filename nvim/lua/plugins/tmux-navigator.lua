-- Integration with tmux
return {
  {
    'christoomey/vim-tmux-navigator',
    cond = vim.env.TMUX ~= nil,
  },
  {
    'knubie/vim-kitty-navigator',
    cond = vim.env.KITTY_PID ~= nil,
  },
}
