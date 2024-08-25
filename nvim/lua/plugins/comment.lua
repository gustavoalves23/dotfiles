---@diagnostic disable: missing-fields
return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- Allow contextual comment by position of character. For example: in html files, inside the script tag, it will use // for comments, but for the rest of the file, it will use <!-- -->.
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('Comment').setup {
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    }
  end,
}
