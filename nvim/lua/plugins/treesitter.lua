return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  -- The `main` branch does not support lazy-loading.
  lazy = false,
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  build = ':TSUpdate',
}
