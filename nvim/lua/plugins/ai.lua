return {
  'supermaven-inc/supermaven-nvim',
  opts = {
    ignore_filetypes = {
      'oil',
      'TelescopePrompt',
      'TelescopeResults',
    },
    keymaps = {
      accept_suggestion = '<C-j>',
      clear_suggestion = '<C-]>',
      accept_word = '<C-z>',
    },
  },
}

-- return {
--   'zbirenbaum/copilot.lua',
--   event = 'VeryLazy',
--   opts = {
--     suggestion = { enabled = true, auto_trigger = true },
--     panel = {
--       enabled = false,
--     },
--     filetypes = {
--       rust = false,
--     },
--   },
--   config = function(_, opts)
--     local copilot = require 'copilot'
--     copilot.setup(opts)
--
--     local suggestion = require 'copilot.suggestion'
--
--     vim.keymap.set('i', '<C-j>', function()
--       if suggestion.is_visible() then
--         suggestion.accept()
--       else
--         suggestion.next()
--       end
--     end)
--   end,
-- }
