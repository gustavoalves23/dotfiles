-- Defaults
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.scrolloff = 4
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

--theme
vim.cmd.colorscheme 'tokyonight'
vim.api.nvim_set_hl(0, 'iCursor', { foreground = '#ffffff', background = '#CD0058' })
vim.opt.guicursor = 'i:block-iCursor'
vim.api.nvim_set_hl(0, 'CursorLine', { background = '#233745' })
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'Visual' })
vim.api.nvim_set_hl(0, 'DashboardHeader', { foreground = '#fc8803' })
vim.api.nvim_set_hl(0, 'FlashCursor', { foreground = '#ffffff', background = '#000000' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float {
    source = true,
  }
end, { desc = 'Open floating diagnostic message' })

-- Telescope keybindings
local telescope_builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sf', function()
  telescope_builtin.find_files {
    hidden = true,
    debounce = 150,
  }
end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', function()
  telescope_builtin.live_grep {
    hidden = true,
    debounce = 150,
  }
end, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })

--file explorer
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { noremap = true, desc = 'Open parent directory' })

--auto-resize
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

vim.api.nvim_set_keymap('n', '<C-w>s', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', '<C-w>s', { noremap = true, silent = true })

--lock scroll with cursor on center of screen
vim.api.nvim_set_keymap('n', '<leader>zz', ':let &scrolloff=999-&scrolloff<CR>', { noremap = true, silent = true })

--disable auto comment on newline
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove 'o'
  end,
})

--enable cursorline
vim.opt.cursorline = true

--copy and paste to and from the star register
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = '[Y]ank from star register' })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = '[P]aste to star register' })
