return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  config = function(_, opts)
    local trouble = require('trouble')
    trouble.setup(opts)
    vim.keymap.set('n', '<leader>xx', trouble.toggle, { silent = true, noremap = true, desc = 'Open Problems List' })
  end,
}
