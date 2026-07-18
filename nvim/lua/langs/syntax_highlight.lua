local langs = require 'langs'

local ensure_installed = {}
local custom_parsers = {}

for _, lang in pairs(langs) do
  if lang.language and lang.language.syntax then
    for key, parser in pairs(lang.language.syntax) do
      if type(key) == 'number' then
        table.insert(ensure_installed, parser)
      elseif type(parser) == 'table' then
        if parser.define and type(parser.define) == 'table' then
          custom_parsers[key] = parser.define
          table.insert(ensure_installed, key)
        end
      end
    end
  end

  if lang.register_by_treesitter then
    for _, filetype in pairs(lang.filetypes) do
      vim.treesitter.language.register(lang.register_by_treesitter, filetype)
    end
  end
end

if next(custom_parsers) ~= nil then
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TSUpdate',
    callback = function()
      local parsers = require 'nvim-treesitter.parsers'
      for name, install_info in pairs(custom_parsers) do
        ---@type ParserInfo
        parsers[name] = { install_info = install_info, tier = 0 }
      end
    end,
  })
end

require('nvim-treesitter').install(ensure_installed)

local ts_group = vim.api.nvim_create_augroup('TreesitterHighlight', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = ts_group,
  callback = function(args)
    local ok = pcall(vim.treesitter.start, args.buf)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require 'langs.treesitter_textobjects'
