return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-c>'] = 'actions.select_split',
      ['<C-r>'] = 'actions.refresh',
    },
  },
}
