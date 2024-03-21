return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  opts = {
    options = {
      show_buffer_close_icons = false,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
  end,
  dependencies = 'nvim-tree/nvim-web-devicons',
}
