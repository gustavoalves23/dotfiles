local utils = require 'custom.utils'

--remove alacritty padding
local _alacritty_config_file = '/home/gmiyazaki/.config/alacritty/alacritty.toml'

local _is_alacritty = vim.env.ALACRITTY_WINDOW_ID ~= nil

local _padding = 16

local function _remove_alacritty_padding()
  if not _is_alacritty then
    return
  end
  utils.Sad('07', _padding, 0, _alacritty_config_file)
  utils.Sad('08', _padding, 0, _alacritty_config_file)
end

local function _reset_alacritty_padding()
  if not _is_alacritty then
    return
  end
  -- verify if there is no other nvim instance running
  -- each nvim instance will add 2 to the count
  local nvim_count = vim.fn.system 'pgrep -c nvim'
  if tonumber(nvim_count) > 2 then
    vim.cmd 'sleep 100m'
    return
  end
  utils.Sad('07', 0, _padding, _alacritty_config_file)
  utils.Sad('08', 0, _padding, _alacritty_config_file)
  vim.cmd 'sleep 100m'
end

local _alacritty_au = vim.api.nvim_create_augroup('alacritty_padding_au', {
  clear = true,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
  pattern = { '*' },
  callback = _remove_alacritty_padding,
  group = _alacritty_au,
})

vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  pattern = { '*' },
  callback = _reset_alacritty_padding,
  group = _alacritty_au,
})

--Set filetype to groovy for jenkinsfiles
vim.filetype.add {
  filename = {
    ['Jenkinsfile'] = 'groovy',
  },
}

--Auto refresh file changesoutside nvim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  command = 'checktime',
})
