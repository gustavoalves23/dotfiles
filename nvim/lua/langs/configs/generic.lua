return {
  others = {
    language = {
      syntax = {
        'regex',
        'markdown',
        'markdown_inline',
        'vimdoc',
        'vim',
        'bash',
        'html',
        'styled',
      },
      servers = {
        cssls = {
          on_init = function(client)
            client.server_capabilities.hoverProvider = false
          end,
        },
        somesass_ls = {},
        html = {},
      },
    },
  },
}
