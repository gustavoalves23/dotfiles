local utils = require 'custom.utils'

-- Defaults
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.scrolloff = 4

--theme
vim.cmd.colorscheme 'tokyonight'
vim.api.nvim_set_hl(0, 'iCursor', { foreground = '#ffffff', background = '#CD0058' })
vim.opt.guicursor = 'i:block-iCursor'
vim.api.nvim_set_hl(0, 'CursorLine', { background = '#233745' })
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })
-- git-blame
vim.g.gitblame_highlight_group = 'GitBlame'
vim.api.nvim_set_hl(0, 'GitBlame', { background = '#233745', foreground = '#565f89' })

--file explorer
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

--auto-resize
vim.api.nvim_command 'autocmd VimResized * wincmd ='

vim.api.nvim_set_keymap('n', '<C-w>s', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', '<C-w>s', { noremap = true, silent = true })

--lock scroll with cursor on center of screen
vim.api.nvim_set_keymap('n', '<leader>zz', ':let &scrolloff=999-&scrolloff<CR>', { noremap = true, silent = true })

--disable auto comment on newline
vim.cmd 'autocmd BufEnter * set formatoptions-=o'

--enable cursorline
vim.opt.cursorline = true

--remove alacritty padding
local alacritty_config_file = '/home/gmiyazaki/.config/alacritty/alacritty.toml'

local function remove_alacritty_padding()
  utils.Sad('07', 16, 0, alacritty_config_file)
  utils.Sad('08', 16, 0, alacritty_config_file)
end

local function reset_alacritty_padding()
  -- verify if there is no other nvim instance running
  -- each nvim instance will add 2 to the count
  local nvim_count = vim.fn.system 'pgrep -c nvim'
  if tonumber(nvim_count) >= 3 then
    vim.cmd 'sleep 100m'
    return
  end
  utils.Sad('07', 0, 16, alacritty_config_file)
  utils.Sad('08', 0, 16, alacritty_config_file)
  vim.cmd 'sleep 100m'
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
