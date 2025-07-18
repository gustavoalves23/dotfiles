---@diagnostic disable: missing-fields

local langs_utils = require 'langs.utils'
local langs = require 'langs'

require('mason').setup()

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
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

for _, server_name in pairs(server_names) do
  local server_config = servers[server_name] or {}

  local default_on_attach = (vim.lsp.config[server_name] or {}).on_attach

  vim.lsp.config(server_name, {
    capabilities = vim.tbl_deep_extend('keep', capabilities, server_config.capabilities or {}),
    on_attach = function(client, bufnr)
      if default_on_attach then
        default_on_attach(client, bufnr)
      end

      langs_utils.on_attach(client, bufnr)

      if server_config.on_attach then
        server_config.on_attach(client, bufnr)
      end
    end,
    settings = server_config.settings,
    filetypes = server_config.filetypes,
    init_options = server_config.init_options,
    on_init = server_config.on_init,
    handlers = server_config.handlers,
  })
end

require('mason-lspconfig').setup {
  ensure_installed = server_names,
}
