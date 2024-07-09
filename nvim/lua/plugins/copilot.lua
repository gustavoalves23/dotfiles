-- return { 'github/copilot.vim' }
return {
  'zbirenbaum/copilot.lua',
  enabled = false,
  opts = {
    suggestion = { enabled = true, auto_trigger = true },
    panel = {
      enabled = true,
      auto_refresh = false,
      keymap = {
        jump_prev = '[[',
        jump_next = ']]',
        accept = '<CR>',
        refresh = 'gr',
      },
      layout = {
        position = 'bottom',
        ratio = 0.4,
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
  config = function(_, opts)
    local copilot = require 'copilot'
    copilot.setup(opts)

    local suggestion = require 'copilot.suggestion'

    vim.keymap.set('i', '<C-j>', function()
      if suggestion.is_visible() then
        suggestion.accept()
      else
        suggestion.next()
      end
    end)
  end,
}
