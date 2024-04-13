local langs_utils = require 'langs.utils'
local langs = require 'langs'

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {}

for _, lang in pairs(langs) do
  if lang.lsp and lang.lsp.servers then
    for server_name, server_config in pairs(lang.lsp.servers) do
      servers[server_name] = server_config
    end
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

local server_names = vim.tbl_keys(servers)

mason_lspconfig.setup {
  ensure_installed = server_names,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = langs_utils.on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
      init_options = (servers[server_name] or {}).init_options,
    }
  end,
}