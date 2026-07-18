---@diagnostic disable: missing-fields

local langs_utils = require 'langs.utils'
local langs = require 'langs'

require('mason').setup()

local servers = {}
-- Plain lspconfig server names, used for `vim.lsp.config`/`vim.lsp.enable`.
local server_names = {}
-- Names optionally suffixed with `@version`, used only for mason's `ensure_installed`.
local ensure_installed = {}

for _, lang in pairs(langs) do
  if lang.language and lang.language.servers then
    for server_name, server_config in pairs(lang.language.servers) do
      servers[server_name] = server_config
      table.insert(server_names, server_name)
      if server_config.version then
        table.insert(ensure_installed, server_name .. '@' .. server_config.version)
      else
        table.insert(ensure_installed, server_name)
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
  ensure_installed = ensure_installed,
  -- We enable servers explicitly below, so disable mason-lspconfig's automatic enabling.
  automatic_enable = false,
}

vim.lsp.enable(server_names)
