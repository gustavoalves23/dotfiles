return {
  'rmagatti/goto-preview',
  opts = {},
  config = function(_, opts)
    local goto_preview = require 'goto-preview'
    goto_preview.setup(opts)

    vim.keymap.set('n', 'gpd', goto_preview.goto_preview_definition, { silent = true, desc = '[G]o to [P]review [D]definition' })
  end,
}
