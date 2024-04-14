local langs = require 'langs'

local ensure_installed = {}

local mason_nvim_dap = require 'mason-nvim-dap'

for _, lang in pairs(langs) do
  local debuggers = lang.debuggers
  if debuggers then
    for _, debugger in pairs(debuggers) do
      table.insert(ensure_installed, debugger.name)
    end
  end
end

mason_nvim_dap.setup {
  ensure_installed = ensure_installed,
  automatic_installation = false,
}
