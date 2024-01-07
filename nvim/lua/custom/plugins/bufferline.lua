return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = 'nvim_lsp',
        separator_style = "slant"
      }
    })
  end,
  dependencies = 'nvim-tree/nvim-web-devicons'
}