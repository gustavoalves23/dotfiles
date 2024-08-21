local langs = require 'langs'
local ensure_installed = {}
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

for _, lang in pairs(langs) do
  if lang.language and lang.language.syntax then
    for key, parser in pairs(lang.language.syntax) do
      if type(key) == 'number' then
        table.insert(ensure_installed, parser)
      elseif type(parser) == 'table' then
        if parser.define and type(parser.define) == 'table' then
          parser_config[key] = parser.define
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

vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = ensure_installed,
    auto_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    modules = {},
    sync_install = true,
    ignore_install = {},
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
        },
      },
    },
  }
end, 0)
