local utils = require 'utils'

-- Defaults

vim.o.mouse = 'a'
vim.opt.tabstop = 2
vim.wo.number = true
vim.o.undofile = true
vim.opt.scrolloff = 4
vim.o.showcmd = false
vim.o.hlsearch = false
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.opt.shiftwidth = 2
vim.o.smartcase = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.o.breakindent = true
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.g.have_nerd_font = true
vim.wo.relativenumber = true
vim.opt.inccommand = 'split'
vim.o.completeopt = 'menuone,noselect'

--disable optional providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

--sync clipboard with system clipboard
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

--theme
vim.cmd.colorscheme 'tokyonight'
vim.api.nvim_set_hl(0, 'iCursor', { foreground = '#ffffff', background = '#CD0058' })
vim.opt.guicursor = 'i:block-iCursor'
vim.api.nvim_set_hl(0, 'CursorLine', { background = '#233745' })
vim.api.nvim_set_hl(0, 'DashboardHeader', { foreground = '#fc8803' })
vim.api.nvim_set_hl(0, 'FlashCursor', { foreground = '#ffffff', background = '#000000' })

vim.api.nvim_set_hl(0, 'NormalFloat', { background = '#222436' }) -- Popup window bg
vim.api.nvim_set_hl(0, 'FloatBorder', { foreground = '#4ED1BA', background = '#222436' }) -- Popup window border - Related to Noice/NUI

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

--diagnostics
vim.keymap.set('n', '<leader>xx', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--auto-resize
vim.api.nvim_create_autocmd('VimResized', {
  pattern = '*',
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

vim.api.nvim_set_keymap('n', '<C-w>s', '<C-w>v', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', '<C-w>s', { noremap = true, silent = true })

--enable cursorline
vim.opt.cursorline = true

--copy and paste to and from the star register
-- vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = '[Y]ank from star register' })
-- vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = '[P]aste to star register' })

--reorder lines by character count
vim.api.nvim_create_user_command('SortLinesByCharacterCount', utils.sort_lines_by_character_count, { range = true })

--hightlight lines and colums on pair programming
do
  (function()
    local is_enabled = false

    vim.api.nvim_create_user_command('Ruler', function()
      if is_enabled then
        vim.opt.cursorcolumn = false
        vim.api.nvim_set_hl(0, 'CursorLine', { background = '#233745' })
        vim.notify 'Ruler: disabled'
      else
        vim.opt.cursorcolumn = true
        vim.api.nvim_set_hl(0, 'CursorLine', { background = '#303000' })
        vim.api.nvim_set_hl(0, 'CursorColumn', { background = '#303000' })
        vim.notify 'Ruler: enabled'
      end
      is_enabled = not is_enabled
    end, {})
  end)()
end

-- toggle inlay hints
if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>ih', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = '[I]nlay [H]int' })
end

-- Disable command history bind
vim.api.nvim_set_keymap('n', 'q:', '<nop>', { noremap = true, silent = true })
