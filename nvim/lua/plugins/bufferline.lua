-- Add top bar that show a list of open buffers
return {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  event = 'VeryLazy',
  opts = {
    options = {
      show_buffer_close_icons = false,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
    },
  },
}
