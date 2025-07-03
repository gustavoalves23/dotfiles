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
        cssmodules_ls = {
          capabilities = {
            definitionProvider = false,
          },
        },
        tailwindcss = {},
      },
    },
    snippets = {
      extends = {
        'html',
      },
      custom = function(s, t, i)
        return {
          s('cssmx', {
            t 'className={clsx(S.',
            i(1),
            t ',',
            i(2),
            t ')}',
          }),
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
