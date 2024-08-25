-- Show the erros in my code in a floating window
return {
  'folke/trouble.nvim',
  keys = { '<leader>xx' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    modes = {
      preview_float = {
        mode = 'diagnostics',
        preview = {
          type = 'float',
          relative = 'editor',
          border = 'rounded',
          title = 'Preview',
          title_pos = 'center',
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
  },
  config = function(_, opts)
    local trouble = require 'trouble'
    trouble.setup(opts)
    vim.keymap.set('n', '<leader>xx', function()
      trouble.toggle 'preview_float'
    end, { silent = true, noremap = true, desc = 'Open diagnostics list' })
  end,
}
