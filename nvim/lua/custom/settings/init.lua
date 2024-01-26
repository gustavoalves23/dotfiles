-- Defaults
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.scrolloff = 4

--theme
vim.cmd.colorscheme('tokyonight')
vim.api.nvim_set_hl(0, 'iCursor', { foreground = '#ffffff', background = '#CD0058' })
vim.opt.guicursor = 'i:block-iCursor'
vim.api.nvim_set_hl(0, 'CursorLine', { background = '#233745' })
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'DashboardHeader', { foreground = '#fc8803' })
vim.api.nvim_set_hl(0, 'FlashCursor', { foreground = '#ffffff', background = '#000000' })
-- git-blame
vim.g.gitblame_highlight_group = 'GitBlame'
vim.api.nvim_set_hl(0, 'GitBlame', { background = '#233745', foreground = '#565f89' })

--file explorer
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { noremap = true, desc = 'Open parent directory' })

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', { silent = true, expr = true })

--auto-resize
vim.api.nvim_command('autocmd VimResized * wincmd =')

vim.api.nvim_set_keymap('n', '<C-w>s', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', '<C-w>s', { noremap = true, silent = true })

--lock scroll with cursor on center of screen
vim.api.nvim_set_keymap('n', '<leader>zz', ':let &scrolloff=999-&scrolloff<CR>', { noremap = true, silent = true })

--disable auto comment on newline
vim.cmd('autocmd BufEnter * set formatoptions-=o')

--enable cursorline
vim.opt.cursorline = true

--copy and paste to and from the star register
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = '[Y]ank from star register' })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = '[P]aste to star register' })
