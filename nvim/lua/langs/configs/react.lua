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
          on_attach = function(client)
            client.server_capabilities.definitionProvider = false
          end,
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
