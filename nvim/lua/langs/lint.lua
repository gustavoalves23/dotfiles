local langs = require 'langs'

local ensure_installed = {}

local mason_nvim_lint = require 'mason-nvim-lint'

for _, lang in pairs(langs) do
  if lang.linters then
    for _, linter in pairs(lang.linters) do
      if type(linter) == 'string' then
        table.insert(ensure_installed, linter)
      else
        table.insert(ensure_installed, linter.install_alias or linter.name)
      end
    end
  end
end

mason_nvim_lint.setup {
  ensure_installed = ensure_installed,
  automatic_installation = false,
}
