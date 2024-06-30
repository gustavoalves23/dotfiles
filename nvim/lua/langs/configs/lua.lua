return {
  lua = {
    filetypes = { 'lua' },
    formatters = { 'stylua' },
    language = {
      syntax = { 'lua' },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      },
    },
  },
}
