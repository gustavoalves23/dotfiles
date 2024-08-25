-- Associate symbol highlighting
return {
  'RRethy/vim-illuminate',
  config = function()
    local illuminate = require 'illuminate'

    vim.keymap.set('n', '[[', function()
      illuminate.goto_prev_reference(false)
    end, { noremap = true, silent = true, desc = 'Previous symbol match' })
    vim.keymap.set('n', ']]', function()
      illuminate.goto_next_reference(false)
    end, { noremap = true, silent = true, desc = 'Next symbol match' })
  end,
}
