return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'rshkarin/mason-nvim-lint',
    { 'folke/neodev.nvim', opts = {} },
  },
}
