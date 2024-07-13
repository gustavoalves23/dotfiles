return {
  'zbirenbaum/copilot.lua',
  opts = {
    suggestion = { enabled = true, auto_trigger = true },
    panel = {
      enabled = false,
    }
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
