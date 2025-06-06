---@diagnostic disable: missing-fields

local langs_utils = require 'langs.utils'
local langs = require 'langs'

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {}
local server_names = {}

for _, lang in pairs(langs) do
  if lang.language and lang.language.servers then
    for server_name, server_config in pairs(lang.language.servers) do
      servers[server_name] = server_config
      if server_config.version then
        table.insert(server_names, server_name .. '@' .. server_config.version)
      else
        table.insert(server_names, server_name)
      end
    end
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = server_names,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = vim.tbl_deep_extend('keep', capabilities, (servers[server_name] or {}).capabilities or {}),
      on_attach = function(client, bufnr)
        langs_utils.on_attach(client, bufnr)
        if (servers[server_name] or {}).on_attach then
          servers[server_name].on_attach(client, bufnr)
        end
      end,
      settings = (servers[server_name] or {}).settings,
      filetypes = (servers[server_name] or {}).filetypes,
      init_options = (servers[server_name] or {}).init_options,
      on_init = (servers[server_name] or {}).on_init,
      handlers = (servers[server_name] or {}).handlers,
    }
  end,
}

-- require('lspconfig').omnisharp.setup {
--   cmd = { '/opt/OmniSharp/OmniSharp.Stdio.Driver/net6.0/OmniSharp' },
--   capabilities = capabilities,
--   on_attach = langs_utils.on_attach,
--   handlers = {
--     ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
--   },
-- }
