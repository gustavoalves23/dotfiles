-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.wo.relativenumber = true

-- autoclosing tags
vim.api.nvim_set_keymap('i', '"', '""<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', "'", "''<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '(', '()<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '[', '[]<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{', '{}<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{<CR>', '{<CR>}<ESC>O', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '{;<CR>', '{<CR>};<ESC>O', { noremap = true, silent = true })

-- copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

--file explorer
--nerdtree
-- vim.keymap.set('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true })
-- vim.keymap.set('n', '<C-n>', ':NERDTree<CR>', { noremap = true })
-- vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
-- vim.keymap.set('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true })

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

--auto-resize
vim.api.nvim_command('autocmd VimResized * wincmd =')

vim.api.nvim_set_keymap('n', '<C-w>s', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', '<C-w>s', { noremap = true, silent = true })

--lock scroll with cursor on center of screen
vim.api.nvim_set_keymap('n', '<leader>zz', ':let &scrolloff=999-&scrolloff<CR>', { noremap = true, silent = true })

-- Set cursor colors
vim.api.nvim_set_hl(0, 'Cursor', { foreground = '#ffffff', background = '#ffffff' })
vim.api.nvim_set_hl(0, 'iCursor', { foreground = '#ffffff', background = '#CD0058' })
vim.opt.guicursor = 'n-v-c:block-Cursor,i:block-iCursor'

--disable auto comment on newline
vim.cmd('autocmd BufEnter * set formatoptions-=o')
