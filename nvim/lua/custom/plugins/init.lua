return {
  { 'windwp/nvim-ts-autotag' },
  { 'github/copilot.vim' },
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup()
    end,
  },
}
