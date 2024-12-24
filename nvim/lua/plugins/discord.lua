local utils = require 'utils'

return {
  'andweeb/presence.nvim',
  enabled = utils.is_personal_computer,
  opts = {},
}
