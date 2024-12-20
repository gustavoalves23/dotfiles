local function add_padding()
  vim.fn.system 'kitten @ set-spacing padding=0'
  vim.fn.system 'kitten @ set-background-opacity 1'
end

local function reset_config()
  vim.fn.system 'kitten @ set-spacing padding=14'
  vim.fn.system 'kitten @ load-config'
end

local _kitty_au = vim.api.nvim_create_augroup('kitty_padding_au', {
  clear = true,
})

vim.api.nvim_create_user_command('Padding', add_padding, {})
vim.api.nvim_create_autocmd('VimEnter', {
  group = _kitty_au,
  callback = add_padding,
  once = true,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  group = _kitty_au,
  callback = reset_config,
  once = true,
})
