return {
  'nvim-telescope/telescope.nvim',
  -- branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
  },
  opts = {
    extensions = {
      fzf = {
        case_mode = 'ignore_case',
      },
    },
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
      file_ignore_patterns = { 'node_modules', '%.min.js', 'dist', '.git' },
      preview = {
        treesitter = false,
      },
    },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)
    pcall(require('telescope').load_extension, 'fzf')
  end,
}
