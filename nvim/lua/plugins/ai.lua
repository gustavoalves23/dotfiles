local utils = require 'utils'

return { {
  'zbirenbaum/copilot.lua',
  event = 'VeryLazy',
  opts = {
    suggestion = { enabled = true, auto_trigger = true },
    panel = {
      enabled = false,
    },
    filetypes = {
      rust = false,
    },
    copilot_node_command = utils.is_workstation and 'node_no_ssl' or 'node',
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
},
  {
    'olimorris/codecompanion.nvim',
    cmd = {
      'CodeCompanion',
      'CodeCompanionChat',
      'CodeCompanionCmd',
      'CodeCompanionActions',
    },
    keys = {
      { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion chat toggle' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      interactions = {
        chat = {
          adapter = {
            name = 'copilot',
            model = 'gpt-4.1',
          },
        },
        inline = {
          adapter = 'copilot',
        },
        cmd = {
          adapter = 'copilot',
        },
      },
      display = {
        action_palette = {
          provider = 'snacks',
        },
      },
    },
  },
}
