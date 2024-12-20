local _is_alacritty = vim.env.ALACRITTY_WINDOW_ID ~= nil
local _is_kitty = vim.env.KITTY_PID ~= nil

if _is_alacritty then
  require 'automation.alacritty'
end

if _is_kitty then
  require 'automation.kitty'
end

--Set filetype to groovy for jenkinsfiles
vim.filetype.add {
  filename = {
    ['Jenkinsfile'] = 'groovy',
  },
}

--Auto refresh file changes outside nvim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  command = 'checktime',
})

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local relative_number_group = vim.api.nvim_create_augroup('RelativeNumber', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', {
  pattern = '*',
  command = 'set norelativenumber',
  group = relative_number_group,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set relativenumber',
  group = relative_number_group,
})

local disable_new_line_comment_group = vim.api.nvim_create_augroup('DisableNewLineComment', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
  group = disable_new_line_comment_group,
  desc = 'Disable New Line Comment',
})
