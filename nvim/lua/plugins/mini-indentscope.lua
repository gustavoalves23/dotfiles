return {
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  opts = {
    symbol = '│',
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = {
        'help',
        'lazy',
        'mason',
        'alpha',
        'notify',
        'trouble',
        'Trouble',
        'neo-tree',
        'lazyterm',
        'dashboard',
        'toggleterm',
      },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
}
