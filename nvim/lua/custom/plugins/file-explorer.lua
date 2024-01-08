return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-c>'] = 'actions.select_split',
    },
  },
}
