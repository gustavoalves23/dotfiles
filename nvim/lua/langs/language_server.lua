---@diagnostic disable: missing-fields

local langs_utils = require 'langs.utils'
local langs = require 'langs'

require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    'github:Crashdummyy/mason-registry',
  },
}

local mason_packages = {}
for _, lang in pairs(langs) do
  vim.list_extend(mason_packages, lang.mason_packages or {})
end

local function install_missing_mason_packages()
  local registry = require 'mason-registry'
  for _, name in ipairs(mason_packages) do
    local ok, pkg = pcall(registry.get_package, name)
    if ok and not pkg:is_installed() and not pkg:is_installing() then
      pkg:install()
    end
  end
end

local function missing_mason_packages()
  local registry = require 'mason-registry'
  for _, name in ipairs(mason_packages) do
    local ok, pkg = pcall(registry.get_package, name)
    if not ok or not pkg:is_installed() then
      return true
    end
  end
  return false
end

if missing_mason_packages() then
  require('mason-registry').refresh(install_missing_mason_packages)
end

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

require('mason-lspconfig').setup {
  ensure_installed = ensure_installed,
  -- We enable servers explicitly below, so disable mason-lspconfig's automatic enabling.
  automatic_enable = false,
}

local server_filetypes = {}
for _, server_name in pairs(server_names) do
  local fts = servers[server_name].filetypes or (vim.lsp.config[server_name] or {}).filetypes or {}
  for _, ft in pairs(fts) do
    server_filetypes[ft] = true
  end
end

local lsp_hooks = {}
for _, lang in pairs(langs) do
  if lang.lsp_hook then
    table.insert(lsp_hooks, lang.lsp_hook)
    for _, ft in pairs(lang.lsp_hook.filetypes) do
      server_filetypes[ft] = true
    end
  end
end

local function setup_servers()
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

  vim.lsp.enable(server_names)

  for _, hook in ipairs(lsp_hooks) do
    hook.setup()
  end
end

local function is_server_filetype(ft)
  return server_filetypes[ft] == true
end

local done = false
local function setup_once()
  if done then
    return
  end
  done = true
  setup_servers()
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('LazyLspSetup', { clear = true }),
  callback = function(args)
    if is_server_filetype(args.match) then
      setup_once()
      return true
    end
  end,
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.api.nvim_buf_is_loaded(buf) and is_server_filetype(vim.bo[buf].filetype) then
    setup_once()
    break
  end
end
