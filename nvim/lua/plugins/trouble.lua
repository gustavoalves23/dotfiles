return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  commit = "250ea79c810a3e5fff846c788792441f1c795c92",
  opts = {
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    }
  },
  config = function(_, opts)
    local trouble = require 'trouble'
    trouble.setup(opts)
    vim.keymap.set('n', '<leader>xx', function()
      trouble.toggle("preview_float")
    end, { silent = true, noremap = true, desc = 'Open diagnostics list' })
  end,
}
