local utils = require('custom.utils')

--remove alacritty padding
local alacritty_config_file = '/home/gmiyazaki/.config/alacritty/alacritty.toml'

local is_alacritty = vim.env.ALACRITTY_WINDOW_ID ~= nil

local function remove_alacritty_padding()
  if not is_alacritty then
    return
  end
  utils.Sad('07', 16, 0, alacritty_config_file)
  utils.Sad('08', 16, 0, alacritty_config_file)
end

local function reset_alacritty_padding()
  if not is_alacritty then
    return
  end
  -- verify if there is no other nvim instance running
  -- each nvim instance will add 2 to the count
  local nvim_count = vim.fn.system('pgrep -c nvim')
  if tonumber(nvim_count) >= 3 then
    vim.cmd('sleep 100m')
    return
  end
  utils.Sad('07', 0, 16, alacritty_config_file)
  utils.Sad('08', 0, 16, alacritty_config_file)
  vim.cmd('sleep 100m')
end

local alacritty_au = vim.api.nvim_create_augroup('alacritty_padding_au', {
  clear = true,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  pattern = { '*' },
  callback = remove_alacritty_padding,
  group = alacritty_au,
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = { '*' },
  callback = reset_alacritty_padding,
  group = alacritty_au,
})

--Set filetype to groovy for jenkinsfiles
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'Jenkinsfile',
  command = 'set ft=groovy',
})
