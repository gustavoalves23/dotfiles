-- LSP loading indicator
return {
  'j-hui/fidget.nvim',
  opts = {
    progress = {
      display = {
        done_icon = '󰄬',
      },
    },
    notification = {
      window = {
        align = 'top',
      },
    },
  },
}
