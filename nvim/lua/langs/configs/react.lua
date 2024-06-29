return {
  react = {
    filetypes = {
      'javascriptreact',
      'typescriptreact',
    },
    language = {
      syntax = {
        'tsx',
      },
      servers = {
        cssmodules_ls = {},
        tailwindcss = {},
      },
    },
    snippets = {
      extends = {
        'html',
      },
      custom = function(s, t, i)
        return {
          s('cssm', {
            t 'className={S.',
            i(1),
            t '}',
          }),
        }
      end,
    },
  },
}
